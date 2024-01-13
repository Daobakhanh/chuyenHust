import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc.dart';
import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc_event.dart';
import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:appdemo/utils/show_dialog_widget.dart';
import 'package:appdemo/service/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appdemo/data/term/local_storage_pref_key.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static String routeName = 'setting_screen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  BiometricBloc fetchBiometric = BiometricBloc();
  bool isAuthenticated = false;
  bool fingerprintEnabled = false;
  final keyPref = SharedPrefKey();
  Future<void> checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.strong)) {
        setState(() {
          isAuthenticated = true;
        });
      } else {
        if (!context.mounted) return;
        showDialogCustomize(
                                              context,
                                              AlertType.error,
                                              DialogTitle.error,
                                              availableBiometrics.toString());
      }
    }
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint to log in",
      );
    } catch (e) {
      if (!context.mounted) return;
      showDialogCustomize(
                                              context,
                                              AlertType.error,
                                              DialogTitle.error,
                                              AppLoginTerm.emptyFingerPrint);
    }
    if (authenticated) {
      setState(() {
        fingerprintEnabled = true;
      });
    }
  }

  Future<void> enableFingerprint() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    fingerprintEnabled = await pref.setBool("fingerprintEnabled", true);
  }

  bool savePasswordSwitched = false;
  bool fingerPrintSwitched = false;
  final emailStore = const FlutterSecureStorage();
  final passwordStore = const FlutterSecureStorage();
  bool isLoading = true;
  void toggleSwitchFingerPrint(bool value) async {
    if (fingerPrintSwitched == false) {
      checkBiometrics();
      if (isAuthenticated) {
        await authenticate();
        if (fingerprintEnabled) {
          setState(() {
            fingerPrintSwitched = true;
          });
          fetchBiometric.add(FetchBiometric(
              email: await StoreLogin.getEmail(),
              password: await StoreLogin.getPassword()));
          showToast(AppSettingTerm.fingerPrintSuccess);
        } else {
          showToast(AppSettingTerm.fingerPrintFaild);
        }
      }
    } else {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Lưu ý'),
                content: const Text(AppSettingTerm.fingerPrintConfirm),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Hủy'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Xác nhận'),
                    onPressed: () {
                      setState(() {
                        fingerPrintSwitched = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      });
    }
  }

  void toggleSwitchSavePassord(bool value) {
    if (savePasswordSwitched == false) {
      setState(() {
        savePasswordSwitched = true;
        showToast(AppSettingTerm.savePasswordSuccess);
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Lưu ý'),
              content: const Text(AppSettingTerm.savePasswordConfirm),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Xác nhận'),
                  onPressed: () {
                    setState(() {
                      savePasswordSwitched = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  void clearEmailAndPassword() {
    if (savePasswordSwitched == false) {
      emailStore.delete(key: keyPref.keyEmailRememberToggle);
      passwordStore.delete(key: keyPref.keyPasswordRememberToggle);
      emailStore.delete(key: keyPref.keyEmailRemember);
      passwordStore.delete(key: keyPref.keyPasswordRememer);
    }
  }

  String? email;
  String? password;
  String? email1;
  void getSaveEmailAndPassword() async {
    email = await emailStore.read(key: keyPref.keyEmailRemember);
    password = await passwordStore.read(key: keyPref.keyPasswordRememer);
    email1 = await StoreLogin.getEmailFingerPrintRemember();
    if (email != null) {
      setState(() {
        savePasswordSwitched = true;
      });
    }
    if (email1 != null) {
      setState(() {
        fingerPrintSwitched = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSaveEmailAndPassword();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Cài Đặt'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            children: [
              isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      margin: const EdgeInsets.only(
                          top: 10, right: 10, left: 10, bottom: 10),
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.white2),
                      child: Column(children: [
                        Container(
                            height: 70,
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 5, right: 10, left: 10),
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(Icons.settings),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Lưu mật khẩu',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    right: 3,
                                    child: Switch(
                                      value: savePasswordSwitched,
                                      onChanged: toggleSwitchSavePassord,
                                      activeColor: Colors.blue,
                                      activeTrackColor: AppColors.activeBlue,
                                      inactiveThumbColor: AppColors.white2,
                                      inactiveTrackColor: Colors.grey,
                                    )),
                              ],
                            )),
                        const Divider(
                          color: AppColors.divider,
                          thickness: 1.4,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 5, right: 10, left: 10),
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.logout),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Xác thực bằng vân tay',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Positioned(
                                  bottom: -9,
                                  right: 3,
                                  child: Switch(
                                    value: fingerPrintSwitched,
                                    onChanged: toggleSwitchFingerPrint,
                                    activeColor: Colors.blue,
                                    activeTrackColor: AppColors.activeBlue,
                                    inactiveThumbColor: AppColors.white2,
                                    inactiveTrackColor: Colors.grey,
                                  )),
                            ],
                          ),
                        ),
                      ]),
                    ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    if (savePasswordSwitched == false) {
      clearEmailAndPassword();
    }
    if (fingerPrintSwitched == false) {
      StoreLogin.clearLoginUser();
      StoreLogin.clearEmailFingerPrintRemember();
    }
    super.dispose();
  }
}
