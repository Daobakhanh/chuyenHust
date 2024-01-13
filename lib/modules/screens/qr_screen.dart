import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/get_department_list.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/modules/device/get_device_list.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/page/devices/detail_screen.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});
  static String routeName = 'qr_screen';
  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String result = '';
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<DeviceData> listDevice = [];
  Future<void> dataListDevice() async {
    listDevice = (await getDataFromApi())!;
  }

  List<DepartmentData> listDepartment = [];
  Future<void> dataListDepartment() async {
    listDepartment = (await getDataDepartmentFromApi())!;
  }

  String department = '';
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!.toString();
      });
      goToDetail(result);
      List<DepartmentData> departments = listDepartment.where((element) {
        return (element.id == device[0].departmentId);
      }).toList();
      setState(() {
        department = departments[0].title;
      });
    });
  }

  void goToDetail(String id) {
    final devices = listDevice.where((element) {
      return (element.id.toString() == id);
    }).toList();

    setState(() {
      device = devices;
    });
  }

  List<DeviceData> device = [];
  @override
  void initState() {
    super.initState();
    connect();
    dataListDevice();
    dataListDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )),
          const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 35),
                child: Text(
                  'Thông tin thiết bị:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )),
          device.isNotEmpty
              ? Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppDetailDeviceTerm.nameDevice} ${device[0].title}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${AppDetailDeviceTerm.model} ${device[0].model}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${AppDetailDeviceTerm.serial} ${device[0].serial}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${AppDetailDeviceTerm.status} ${statusDeviceObject[device[0].status]}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${AppDetailDeviceTerm.nameDepartment} $department',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          ElevatedButton(
            onPressed: () {
              if (result.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(device[0])));
              }
            },
            child: const Text('Xem chi tiết'),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
