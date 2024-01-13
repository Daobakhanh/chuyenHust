import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/device/bloc/device_bloc.dart';
import 'package:appdemo/modules/device/bloc/device_bloc_event.dart';
import 'package:appdemo/modules/device/bloc/device_bloc_state.dart';
import 'package:appdemo/modules/device/widget/show_device.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/screens/qr_screen.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});
  static String routeName = "Inventory_screen";
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<DeviceData> devices = [];
  bool look = false;

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    DeviceBloc fetchData = BlocProvider.of<DeviceBloc>(context);
    fetchData.add(FetchDevice());
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Kiểm Kê'),
          centerTitle: true,
        ),
        body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(children: [
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
                        onChanged: research,
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
                            setState(() {
                              look = true;
                            });
                          },
                        )),
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, QRScreen.routeName);
                  },
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.white2),
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
                                'Quét mã QR',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 5,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 27.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ))),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        AppLoadDataTerm.clickToShow,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              Flexible(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    fetchData.add(FetchDevice());
                  },
                  child: BlocBuilder<DeviceBloc, DeviceState>(
                      builder: (context, state) {
                    if (state is DeviceLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is DeviceLoaded) {
                      searchDevice(
                          state.data.data, _textEditingController.text, look);
                      return DisplayDevice(devices);
                    } else {
                      return Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                fetchData.add(FetchDevice());
                              },
                              child: const Text(AppLoadDataTerm.reload)),
                          const Text(AppLoadDataTerm.errorLoad)
                        ],
                      );
                    }
                  }),
                ),
              )
            ])));
  }

  void searchDevice(
      List<DeviceData>? listDevice, String query, bool look) {
    final suggestions = listDevice!.where((element) {
      final deviceTitle = element.title.toLowerCase();
      final deviceModel = element.model!.toLowerCase();
      final deviceSerial = element.serial!.toLowerCase();
      final input = query.toLowerCase();
      return deviceTitle.contains(input)||deviceModel.contains(input)||deviceSerial.contains(input);
    }).toList();
      devices = suggestions;
  }

  void research(String query) {
    setState(() {
      look = true;
    });
  }
}
