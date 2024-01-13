import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/get_department_list.dart';
import 'package:appdemo/modules/device/bloc/device_bloc.dart';
import 'package:appdemo/modules/device/widget/show_device.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});
  static String routeName = "device_screen";
  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String selectedStatus = statusDeviceObject['all']!;
  String selectedDepartment = statusDeviceObject['all']!;
  bool look = false;

  Future<List<DepartmentData>?> dataListDepartment() async {
    final List<DepartmentData>? dataList = await getDataDepartmentFromApi();
    return dataList;
  }

  List<DepartmentData> _department = [];

  void fetchDepartmentData() async {
    _department = (await dataListDepartment())!;
    listDepartment = _department.map((e) => e.title).toList();
    listDepartment.insert(0, statusDeviceObject['all']!);
  }
   List<String> listDepartment = [];
  @override
  void initState() {
    super.initState();
    fetchDepartmentData();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    final fetchDevice = BlocProvider.of<DeviceBloc>(context);
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Thiết Bị'),
          centerTitle: true,
        ),
        body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(children: [
              textFormField(),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Trạng thái',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 40,
                              margin: const EdgeInsets.all(13),
                              width: 150,
                              padding: const EdgeInsets.only(left: 10),
                              decoration: const BoxDecoration(
                                  color: AppColors.white2,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          selectedStatus,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColors.gray,
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  selectDeviceStatus();
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, right: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Khoa phòng',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 40,
                              margin: const EdgeInsets.all(13),
                              width: 150,
                              padding: const EdgeInsets.only(top: 1),
                              decoration: const BoxDecoration(
                                  color: AppColors.white2,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          selectedDepartment,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColors.gray,
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  selectDeparment();
                                },
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        AppDeviceTerm.clickToShow,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              Flexible(
                  child: RefreshIndicator(onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  look = true;
                });
              }, child:FilterDevice(
                  loadData: fetchDevice,
                  statusDevice: selectedStatus,
                  department: selectedDepartment,
                  listDepartment: _department,
                  nameDevice: _textEditingController.text.toString(),
                  look: look,
                ), ))
            ])));
  }

  void applySelection() {
    Navigator.of(context).pop();
    setState(() {
      look = true;
    });
  }

  void search(String query) {
   setState(() {
      look = true;
    });
  }

  void selectDeviceStatus() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return CupertinoPopupSurface(
          isSurfacePainted: false,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            height: 500,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    itemExtent: 40.0, // Chiều cao của mỗi item trong picker
                    onSelectedItemChanged: (int index) {
                      // Xử lý khi phần tử được chọn thay đổi
                      setState(() {
                        selectedStatus = AppDeviceTerm.listStatus[index];
                      });
                    },
                    childCount: AppDeviceTerm.listStatus.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppDeviceTerm.listStatus[index],
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                      onPressed: applySelection, child: const Text('Xác Nhận')),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void selectDeparment() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return CupertinoPopupSurface(
          isSurfacePainted: false,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            height: 500,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    itemExtent: 40.0, // Chiều cao của mỗi item trong picker
                    onSelectedItemChanged: (int index) {
                      // Xử lý khi phần tử được chọn thay đổi
                      setState(() {
                        selectedDepartment = listDepartment[index];
                      });
                    },
                    childCount: listDepartment.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            listDepartment[index],
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                      onPressed: applySelection, child: const Text('Xác Nhận')),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget textFormField() {
    return Row(
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
              onChanged: search,
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
              margin: const EdgeInsets.only(top: 3, right: 20, bottom: 5),
              child: TextButton(
                child: const Text(
                  'Tìm kiếm',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    look = true;
                  });
                },
              )),
        ),
      ],
    );
  }
}
