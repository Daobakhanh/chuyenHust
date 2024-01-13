import 'package:appdemo/modules/personal/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataCubit extends Cubit<UserModel> {
  UserDataCubit() : super(UserModel());

  void updateUser(UserModel user) {
    emit(user);
  }
}
