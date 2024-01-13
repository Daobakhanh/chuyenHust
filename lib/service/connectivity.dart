import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/utils/show_dialog_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void connect() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.wifi &&
      connectivityResult != ConnectivityResult.mobile) {
    showToast(AppLoginTerm.notConnectivityWifi);
  }
}
