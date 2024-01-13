import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/employee/bloc/employee_bloc.dart';
import 'package:appdemo/modules/employee/bloc/employee_bloc_event.dart';
import 'package:appdemo/modules/employee/bloc/employee_bloc_state.dart';
import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:appdemo/utils/show_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowEmployee extends StatefulWidget {
  final EmployeeBloc fetchEmployee;
  final String nameEmployee;
  final bool look;
  const ShowEmployee(
      {super.key,
      required this.fetchEmployee,
      required this.nameEmployee,
      required this.look});

  @override
  State<ShowEmployee> createState() => _ShowEmployeeState();
}

class _ShowEmployeeState extends State<ShowEmployee> {
  List<EmployeeData> listEmployee = [];

  void searchEmployee(List<EmployeeData> employee, String query) {
    final suggestions = employee.where((element) {
      final employeeTitle = element.displayname.toLowerCase();
      final employeeEmail = element.email.toLowerCase();
      final employeePhone = element.phone.toLowerCase();
      final input = query.toLowerCase();
      return employeeTitle.contains(input)||employeeEmail.contains(input)||employeePhone.contains(input);
    }).toList(); 
      listEmployee = suggestions;  
  }

  @override
  Widget build(BuildContext context) {
    widget.fetchEmployee.add(FetchEmployee());
    return BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
      if (state is EmployeeLoading) {
        return const CircularProgressIndicator();
      } else if (state is EmployeeLoaded) {
        final data = state.employee.data;
        searchEmployee(data!, widget.nameEmployee);
        return DisplayEmployee(
            employees:
                listEmployee);
      } else {
        return Column(
          children: [
            TextButton(
                onPressed: () {
                  widget.fetchEmployee.add(FetchEmployee());
                },
                child: const Text(AppLoadDataTerm.reload)),
            const Text(AppLoadDataTerm.errorLoad)
          ],
        );
      }
    });
  }
}

class DisplayEmployee extends StatelessWidget {
  final List<EmployeeData> employees;
  const DisplayEmployee({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return employees.isEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 40),
            child: const Text(AppEmployeeTerm.emptyEmployee))
        : ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
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
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                employees[index].displayname,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 17),
                                  const SizedBox(
                                    width: 5,
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
                                        path: employees[index].email,
                                        query: encodeQueryParameters(<String,
                                            String>{
                                          'subject':
                                              'Example Subject & Symbols are allowed!',
                                        }),
                                      );

                                      try {
                                        await launchUrl(emailUrl);
                                      } catch (e) {
                                        showToast(
                                            AppDepartmentTerm.errorDirect);
                                      }
                                    },
                                    child: Text(
                                      employees[index].email,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone_android_outlined,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final Uri phoneUrl = Uri(
                                          scheme: 'tel',
                                          path: employees[index].phone);

                                      if (await canLaunchUrl(phoneUrl)) {
                                        await launchUrl(phoneUrl);
                                      } else {
                                        showToast(
                                            AppDepartmentTerm.errorDirect);
                                      }
                                    },
                                    child: Text(
                                      employees[index].phone,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            });
  }
}
