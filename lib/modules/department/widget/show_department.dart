import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/bloc/department_bloc.dart';
import 'package:appdemo/modules/department/bloc/department_bloc_event.dart';
import 'package:appdemo/modules/department/bloc/department_bloc_state.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/modules/department/page/devices_for_department.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:appdemo/utils/show_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class FilterDepartment extends StatefulWidget {
  final DepartmentBloc fetchDepartment;
  final String nameDepartment;
  final bool look;
  const FilterDepartment(
      {super.key,
      required this.fetchDepartment,
      required this.nameDepartment,
      required this.look});

  @override
  State<FilterDepartment> createState() => _FilterDepartmentState();
}

class _FilterDepartmentState extends State<FilterDepartment> {
  List<DepartmentData> departments = [];

  void searchDepartment(List<DepartmentData> data, String query) async {
    final suggestions = data.where((element) {
      final departmentTitle = element.title.toLowerCase();
      final departmentEmail = element.email.toLowerCase();
      final departmentPhone = element.phone.toLowerCase();
      final input = query.toLowerCase();
      return departmentTitle.contains(input)||departmentEmail.contains(input)||departmentPhone.contains(input);
    }).toList();
      departments = suggestions;
  }

  @override
  Widget build(BuildContext context) {
    widget.fetchDepartment.add(FetchDepartment());
    return BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) {
      if (state is DepartmentLoading) {
        return const CircularProgressIndicator();
      } else if (state is DepartmentLoaded) {
        searchDepartment(state.department.data!, widget.nameDepartment);
        return DisplayDepartment(
            departments: departments, devices: state.device.data!);
      } else {
        return Column(
          children: [
            TextButton(
                onPressed: () {
                  widget.fetchDepartment.add(FetchDepartment());
                },
                child: const Text(AppDepartmentTerm.reload)),
            const Text(AppLoadDataTerm.errorLoad)
          ],
        );
      }
    });
  }
}

class DisplayDepartment extends StatelessWidget {
  final List<DepartmentData> departments;
  final List<DeviceData> devices;
  const DisplayDepartment(
      {super.key, required this.departments, required this.devices});

  @override
  Widget build(BuildContext context) {
    return departments.isEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 40),
            child: const Text(AppDepartmentTerm.emptyDepartment))
        : ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: departments.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(20),
                height: 235,
                decoration: BoxDecoration(
                    color: AppColors.white5,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        departments[index].title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          final Uri emailUrl = Uri(
                            scheme: 'mailto',
                            path: departments[index].email,
                            query: encodeQueryParameters(<String, String>{
                              'subject':
                                  'Example Subject & Symbols are allowed!',
                            }),
                          );

                          try {
                            await launchUrl(emailUrl);
                          } catch (e) {
                            showToast(AppDepartmentTerm.errorDirect);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 5, left: 15, right: 5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Icon(
                                    Icons.email_outlined,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    departments[index].email,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const Positioned(
                                  right: 5,
                                  child: Icon(Icons.keyboard_arrow_right))
                            ],
                          ),
                        )),
                    const Divider(
                      //Divider tạo dòng kẻ ngang
                      color: AppColors.divider, // Màu của dòng kẻ
                      thickness: 1.4, // Độ dày của dòng kẻ
                      indent: 10, // Khoảng cách từ lề trái
                      endIndent: 10, // Khoảng cách từ lề phải
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri phoneUrl =
                            Uri(scheme: 'tel', path: departments[index].phone);

                        if (await canLaunchUrl(phoneUrl)) {
                          await launchUrl(phoneUrl);
                        } else {
                          showToast(AppDepartmentTerm.errorDirect);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 5),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 7,
                                ),
                                const Icon(
                                  Icons.phone_android_outlined,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  departments[index].phone,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Positioned(
                                right: 5,
                                child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      //Divider tạo dòng kẻ ngang
                      color: AppColors.divider, // Màu của dòng kẻ
                      thickness: 1.4, // Độ dày của dòng kẻ
                      indent: 10, // Khoảng cách từ lề trái
                      endIndent: 10, // Khoảng cách từ lề phải
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 5),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 7,
                                ),
                                const Icon(
                                  Icons.location_on_outlined,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  departments[index].address,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Positioned(
                                right: 5,
                                child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      //Divider tạo dòng kẻ ngang
                      color: AppColors.divider, // Màu của dòng kẻ
                      thickness: 1.4, // Độ dày của dòng kẻ
                      indent: 10, // Khoảng cách từ lề trái
                      endIndent: 10, // Khoảng cách từ lề phải
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeviceInDepartmentScreen(
                                      getDepartmentData: departments[index],
                                      listDevice: devices,
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 5),
                        child: const Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.menu_open,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Danh sách thiết bị",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Positioned(
                                right: 5,
                                child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
  }
}
