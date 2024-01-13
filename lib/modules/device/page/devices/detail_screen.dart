import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/device/page/history_inventory/bloc/history_inventory_bloc.dart';
import 'package:appdemo/modules/device/page/history_inventory/bloc/history_inventory_bloc_event.dart';
import 'package:appdemo/modules/device/page/history_inventory/bloc/history_inventory_bloc_state.dart';
import 'package:appdemo/modules/error/page/report_screen.dart';
import 'package:appdemo/modules/inventory/page/create_inventory_screen.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/widget/infor_device.dart';
import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/modules/employee/get_employee_list.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(this.models, {super.key});
  final DeviceData models;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<List<EmployeeData>?> dataList() async {
    final List<EmployeeData>? dataList = await getDataEmployeeFromApi();

    return dataList;
  }

  List<EmployeeData> _employee = [];
  void fetchEmployeeData() async {
    _employee = (await dataList())!;
  }


  String getUserInventory(int userId) {
    String name = '';
    for (EmployeeData employee in _employee) {
      if (employee.id == userId) {
        name = employee.displayname;
        break;
      }
    }
    return name;
  }

  @override
  void initState() {
    super.initState();
    fetchEmployeeData();

  }

  @override
  Widget build(BuildContext context) {
    HistoryInventoryBloc fetchHistoryInventory =
        BlocProvider.of<HistoryInventoryBloc>(context);
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Thiết Bị'),
          centerTitle: true,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: ListView(children: [
              Column(children: [
                InforDevice(widget.models),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 0, bottom: 5, right: 10, left: 10),
                  child: const Text(AppDetailDeviceTerm.historyReportError,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () {
                    reportErrorBottomsheet(context, widget.models);
                  },
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.white4),
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      alignment: Alignment.center,
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppDetailDeviceTerm.showHistoryReportError,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 3,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 24.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 10, left: 10),
                  child: const Text(
                    AppDetailDeviceTerm.historyInventory,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      fetchHistoryInventory
                          .add(FetchHistoryInventory(device: widget.models));
                      createInventoryBottomsheet(context, widget.models);
                    },
                    child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.white4),
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 10, left: 10),
                        alignment: Alignment.center,
                        child: const Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppDetailDeviceTerm.showHistoryInventory,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 3,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 24.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ))),
                ((statusDeviceObject[widget.models.status] ==
                            statusDeviceObject['was_broken']!) ||
                        (statusDeviceObject[widget.models.status] ==
                            statusDeviceObject['liquidated']!) ||
                        (statusDeviceObject[widget.models.status] ==
                            statusDeviceObject['corrected']!) ||
                        (statusDeviceObject[widget.models.status] ==
                            statusDeviceObject['inactive']!))
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InventoryScreen(widget.models)));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: const Text(AppDetailDeviceTerm.inventory,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ))
                    : Container(
                        margin: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReportScreen(widget.models)));
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue),
                                    child: const Text(
                                      AppDetailDeviceTerm.reportError,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InventoryScreen(widget.models)));
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue),
                                  child: const Text(
                                      AppDetailDeviceTerm.inventory,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ))
                          ],
                        ),
                      ),
              ])
            ])));
  }

  void reportErrorBottomsheet(BuildContext context, DeviceData models) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(AppDetailDeviceTerm.historyReportError),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: (models.dateFailure != null)
                      ? Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            children: [
                              Text(
                                AppDetailDeviceTerm.dateFailure +
                                    models.dateFailure!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              const Text(AppDetailDeviceTerm.statusRepair),
                            ],
                          ),
                        )
                      : const Text(AppDetailDeviceTerm.none),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          );
        });
  }

  void createInventoryBottomsheet(BuildContext context, DeviceData models) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(AppDetailDeviceTerm.historyInventory),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child:
                      BlocBuilder<HistoryInventoryBloc, HistoryInventoryState>(
                          builder: (context, state) {
                    if (state is HistoryInventoryLoaded) {
                      return ListView.builder(
                          itemCount: state.data.dataLength,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: AppColors.white2),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppDetailDeviceTerm
                                                        .dateInventory +
                                                    state.data.data![index].date
                                                        .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppDetailDeviceTerm
                                                        .noteInventory +
                                                    ((state.data.data![index]
                                                                .note !=
                                                            null)
                                                        ? state.data
                                                            .data![index].note!
                                                        : AppDetailDeviceTerm
                                                            .noneNote),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppDetailDeviceTerm
                                                        .userInventory +
                                                    getUserInventory(state.data
                                                        .data![index].userId!),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            );
                          });
                    } else if (state is HistoryInventoryLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const Text(AppDetailDeviceTerm.none);
                  }),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          );
        });
  }
}
