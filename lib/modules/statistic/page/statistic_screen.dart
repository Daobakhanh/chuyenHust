import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/department/model/department_model.dart';
import 'package:appdemo/modules/department/get_department_list.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:appdemo/modules/statistic/bloc/static_bloc.dart';
import 'package:appdemo/modules/statistic/widget/pie_chart.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});
  static String routeName = "statistic_screen";
  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Thống Kê'),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => StatisticBloc(),
          child: const PieChartScreen(),
        ));
  }
}

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});
  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  bool isLoading = false;
  String _selectedDepartment = AppDepartmentTerm.allNameDepartment;

  Future<List<DepartmentData>?> dataListDepartment() async {
    final List<DepartmentData>? dataList = await getDataDepartmentFromApi();
    // Lọc danh sách dựa trên điều kiện
    return dataList;
  }

  List<DepartmentData> _department = [];

  void fetchDepartmentData() async {
    _department = (await dataListDepartment())!;
    listDepartment = _department.map((e) => e.title).toList();
    listDepartment.insert(0, AppDepartmentTerm.allNameDepartment);
  }

  List<String> listDepartment = [];

  @override
  void initState() {
    super.initState();
    fetchDepartmentData();
  }

  @override
  Widget build(BuildContext context) {
    StatisticBloc fetchStatistic = BlocProvider.of<StatisticBloc>(context);
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, left: 5),
                    child: Column(
                      children: [
                        const Text(
                          'Chọn loại dữ liệu',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              selectDepartment();
                            },
                            child: Container(
                              height: 30,
                              margin: const EdgeInsets.all(10),
                              width: 420,
                              decoration: const BoxDecoration(
                                  color: AppColors.white2,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              alignment: Alignment.center,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                    'Khoa phòng',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            )),
                        const Text(
                          AppStatisticTerm.nameChart,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height:5)
                      ],
                    ),
                  )),
            ],
          ),
          Flexible(
              child: SingleChildScrollView(
                  child: showPieChart(fetchStatistic, _selectedDepartment)))
        ]));
  }

  void applySelection() {
    Navigator.of(context).pop();
  }

  void selectDepartment() {
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
            height: 500, // Điều chỉnh chiều cao của bottom sheet
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
                        _selectedDepartment = listDepartment[index];
                      });
                    },
                    childCount: listDepartment.length, // Số lượng phần tử
                    itemBuilder: (BuildContext context, int index) {
                      // Tùy chỉnh giao diện của ô hiển thị phần tử
                      return Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            listDepartment[index],
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black, // Màu văn bản
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
}
