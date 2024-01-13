import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/employee/bloc/employee_bloc_event.dart';
import 'package:appdemo/modules/employee/bloc/employee_bloc_state.dart';
import 'package:appdemo/modules/employee/model/employee_model.dart';
import 'package:appdemo/modules/employee/repo/employee_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeEvent>(
      (event, emit) async {
        if (event is FetchEmployee) {
          emit(EmployeeLoading());
          try {
            EmployeeModel? data = await EmployeeRepo.dioGetEmployeeData();
            if (data!.data!.isNotEmpty) {
              emit(EmployeeLoaded(employee: data));
            } else {
              emit(EmployeeErrorApi(error: AppLoadDataTerm.errorLoad));
            }
          } catch (e) {
            emit(EmployeeError());
          }
        }
      },
    );
  }
}
