import 'package:appdemo/modules/statistic/model/statistic_model.dart';

abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticLoaded extends StatisticState {
  final List<StatisticModel>data ;
  StatisticLoaded({required this.data});
}
class StatisticError extends StatisticState{}

class StatisticErrorApi extends StatisticState {
  final String error;
  StatisticErrorApi({required this.error});
}
