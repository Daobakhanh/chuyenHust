import "package:appdemo/data/term/app_term.dart";
import 'package:appdemo/modules/statistic/bloc/statistic_bloc_event.dart';
import 'package:appdemo/modules/statistic/bloc/statistic_bloc_state.dart';
import 'package:appdemo/modules/statistic/model/statistic_model.dart';
import 'package:appdemo/modules/statistic/repo/statistic_repo.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial()) {
    on<StatisticEvent>((event, emit) async {
      if (event is FetchStatistic) {
        emit(StatisticLoading());
        try {
          List<StatisticModel>? data = await StatisticRepo.getStatistic();
          if (data != null) {
            emit(StatisticLoaded(data: data));
          } else {
            emit(StatisticErrorApi(error: AppLoadDataTerm.errorLoad));
          }
        } catch (e) {
          emit(StatisticError());
        }
      }
    });
  }
}
