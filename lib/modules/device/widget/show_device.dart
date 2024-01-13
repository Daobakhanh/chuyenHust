import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/modules/device/bloc/device_bloc.dart';
import 'package:appdemo/modules/device/bloc/device_bloc_event.dart';
import 'package:appdemo/modules/device/bloc/device_bloc_state.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/page/devices/detail_screen.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDevice extends StatefulWidget {
  final DeviceBloc loadData;
  final String department;
  final String statusDevice;
  final String nameDevice;
  final List<DepartmentData> listDepartment;
  final bool look;
  const FilterDevice(
      {super.key,
      required this.loadData,
      required this.department,
      required this.statusDevice,
      required this.listDepartment,
      required this.nameDevice,
      required this.look});

  @override
  State<FilterDevice> createState() => _FilterDeviceState();
}

class _FilterDeviceState extends State<FilterDevice> {
  List<DeviceData> devices = [];

  void searchOnDepartmentAndStatusDevice(
      List<DeviceData> defaultDevices,
      List<DepartmentData> listDepartment,
      String selectedStatus,
      String selectedDepartment) {
    final suggestions = defaultDevices.where((element) {
      final deviceStatus = element.status.toLowerCase();
      final input = selectedStatus.toLowerCase();
      return deviceStatus.contains(input);
    }).toList();
    final secondSuggestions = suggestions
        .where((data) => listDepartment.any((department) =>
            ((department.id == data.departmentId) &&
                (selectedDepartment == department.title))))
        .toList();
      devices = secondSuggestions;
  }

  void searchDevice(
    List<DeviceData> defaultDevices,
    String query,
  ) {
    final suggestions = defaultDevices.where((element) {
      final deviceTitle = element.title.toLowerCase();
      final deviceModel = element.model!.toLowerCase();
      final deviceSerial = element.serial!.toLowerCase();
      final input = query.toLowerCase();
      return deviceTitle.contains(input)||deviceModel.contains(input)||deviceSerial.contains(input);
    }).toList();
      devices = suggestions;
  }

  void searchOnStatusDevice(
      List<DeviceData> defaultDevices, String selectedStatus) {
    final suggestions = defaultDevices.where((element) {
      final deviceStatus = element.status.toLowerCase();
      final input = selectedStatus.toLowerCase();
      return deviceStatus.contains(input);
    }).toList();
      devices = suggestions;
  }

  void searchOnDepartmentDevice(List<DeviceData> defaultDevices,
      List<DepartmentData> listDepartment, String selectedDepartment) {
    final List<DeviceData> suggestions = defaultDevices
        .where((data) => listDepartment.any((department) =>
            ((department.id == data.departmentId) &&
                (selectedDepartment == department.title))))
        .toList();
      devices = suggestions;
  }

  String selectDefaultStatus = '';
  void convert() {
    for (var key in statusDeviceObject.keys) {
      if (statusDeviceObject[key] == widget.statusDevice) {
        selectDefaultStatus = key;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.loadData.add(FetchDevice());
    return BlocBuilder<DeviceBloc, DeviceState>(builder: (context, state) {
      if (state is DeviceLoading) {
        return const CircularProgressIndicator();
      } else if (state is DeviceLoaded) {
        if (widget.nameDevice == "") {
          convert();
          if ((widget.statusDevice == statusDeviceObject['all']) &&
              (widget.department == statusDeviceObject['all'])) {
            searchDevice(state.data.data!, "");
          } else if ((widget.statusDevice != statusDeviceObject['all']) &&
              (widget.department == statusDeviceObject['all'])) {
            searchOnStatusDevice(state.data.data!, selectDefaultStatus);
          } else if ((widget.department != statusDeviceObject['all']) &&
              (widget.statusDevice == statusDeviceObject['all'])) {
            searchOnDepartmentDevice(
                state.data.data!, widget.listDepartment, widget.department);
          } else {
            searchOnDepartmentAndStatusDevice(state.data.data!,
                widget.listDepartment, selectDefaultStatus, widget.department);
          }
          return DisplayDevice(devices);
        } else {
          searchDevice(state.data.data!, widget.nameDevice);
          return DisplayDevice(devices);
        }
      } else {
        return Column(
          children: [
            TextButton(
                onPressed: () {
                  widget.loadData.add(FetchDevice());
                },
                child: const Text(AppLoadDataTerm.reload)),
            const Text(AppLoadDataTerm.errorLoad)
          ],
        );
      }
    });
  }
}


class DisplayDevice extends StatelessWidget {
  final List<DeviceData> devices;

  const DisplayDevice(this.devices, {super.key});
  @override
  Widget build(BuildContext context) {
    return devices.isEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 40),
            child: const Text(AppDeviceTerm.emptyDevice))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: devices.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(devices[index])));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppColors.white5,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/logo-bo-y-te.jpg'),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                devices[index].title,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                AppDetailDeviceTerm.model +
                                    devices[index].model!,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                AppDetailDeviceTerm.serial +
                                    devices[index].serial!,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                  'Trạng thái: ${statusDeviceObject[devices[index].status]}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            });
  }
}
