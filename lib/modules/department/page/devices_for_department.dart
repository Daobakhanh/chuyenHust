import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/device/widget/show_device.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/material.dart';

class DeviceInDepartmentScreen extends StatefulWidget {
  final DepartmentData getDepartmentData;
  final List<DeviceData> listDevice;
  const DeviceInDepartmentScreen(
      {super.key, required this.getDepartmentData, required this.listDevice});
  @override
  State<DeviceInDepartmentScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceInDepartmentScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<DeviceData> _devices = [];
  List<DeviceData> devices = [];

  void fetchData() {
    devices = widget.listDevice
        .where(
            (element) => (element.departmentId == widget.getDepartmentData.id))
        .toList();
    _devices = devices;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Danh Sách Thiết Bị'),
          centerTitle: true,
        ),
        body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  '--- ${widget.getDepartmentData.title} ---',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: TextFormField(
                        onChanged: searchDevice,
                        maxLength: 500,
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.white2,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            hintText: AppDeviceTerm.hintTextLookForm,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 4,
                                color: Colors.blue,
                              ),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 49.55,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: AppColors.white3,
                        ),
                        margin:
                            const EdgeInsets.only(top: 3, right: 20, bottom: 5),
                        child: TextButton(
                          child: const Text(
                            'Tìm kiếm',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          onPressed: () {
                            searchDevice(
                                _textEditingController.text.toString());
                          },
                        )),
                  ),
                ],
              ),
              Flexible(child: DisplayDevice(_devices))
            ])));
  }

  void searchDevice(String query) {
    final suggestions = devices.where((element) {
      final deviceTitle = element.title.toLowerCase();
      final deviceModel = element.model!.toLowerCase();
      final deviceSerial = element.serial!.toLowerCase();
      final input = query.toLowerCase();
      return deviceTitle.contains(input)||deviceModel.contains(input)||deviceSerial.contains(input);
    }).toList();
    setState(() {
      _devices = suggestions;
    });
  }

  void reApplySelection() {
    searchDevice(_textEditingController.text.toString());
  }
}
