// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/statistic/bloc/static_bloc.dart';
import 'package:appdemo/modules/statistic/bloc/statistic_bloc_event.dart';
import 'package:appdemo/modules/statistic/model/statistic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../bloc/statistic_bloc_state.dart';

Widget showPieChart(
  StatisticBloc fetchStatistic,
  String departmentName,
) {
  fetchStatistic.add(FetchStatistic());
  return BlocBuilder<StatisticBloc, StatisticState>(builder: (context, state) {
    if (state is StatisticLoading) {
      return const CircularProgressIndicator();
    } else if (state is StatisticLoaded) {
      return customizePieChart(context, state.data, departmentName);
    } else {
      return Column(
        children: [
          TextButton(
              onPressed: () {
                fetchStatistic.add(FetchStatistic());
              },
              child: const Text(AppLoadDataTerm.reload)),
          const Text(AppLoadDataTerm.errorLoad)
        ],
      );
    }
  });
}

Widget customizePieChart(BuildContext context, List<StatisticModel> dataState,
    String departmentName) {
  List<StatisticModel> searchOnDepartmentDevice(List<StatisticModel> data) {
    if (departmentName != AppDepartmentTerm.allNameDepartment) {
      final suggestions = data.where((element) {
        final department = element.departmentTitle!.toLowerCase();
        final input = departmentName.toLowerCase();
        return department.contains(input);
      }).toList();
      return suggestions;
    }
    return data;
  }
  
   
  Map<String, double> dataMap = {};
  for (var statistic in searchOnDepartmentDevice(dataState)) {
    dataMap[statistic.departmentTitle!] =
        statistic.brokenEquipmentsCount!.toDouble();
  }
  double totalValue = dataMap.values.reduce((a, b) => a + b);
  Map<String, String> customLegendLabels = {};
  dataMap.forEach((key, value) {
    customLegendLabels[key] =
        "$key: ${value.toStringAsFixed(0)} thiết bị (${(value / totalValue).toStringAsFixed(1)}%) ";
  });
  return PieChart(
    dataMap: dataMap,
    chartRadius: MediaQuery.of(context).size.width / 1.1,
    chartType: ChartType.disc,
    ringStrokeWidth: 32,
    formatChartValues: (value) {
      String get() {
        String result = '';
        dataMap.forEach((key, eachValue) {
          if (value == eachValue) result = key;
        });
        return result;
      }

      return '${"${get() + "\n" + value.toStringAsFixed(0)}\n" + ((value / totalValue) * 100).toStringAsFixed(1)}%'; // Định dạng giá trị hiển thị
    },
    legendOptions: const LegendOptions(
      showLegends: true,
      legendPosition: LegendPosition.bottom,
      showLegendsInRow: false,
    ),
    legendLabels: customLegendLabels,
    chartValuesOptions: const ChartValuesOptions(
      showChartValueBackground: false,
      showChartValues: true,
      showChartValuesInPercentage: false,
      showChartValuesOutside: false,
      chartValueStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
