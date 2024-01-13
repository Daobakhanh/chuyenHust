import 'package:appdemo/data/term/local_storage_pref_key.dart';
import 'package:appdemo/modules/authentication/bloc/authentication_bloc.dart';
import 'package:appdemo/modules/authentication/bloc/authentication_bloc_event.dart';
import 'package:appdemo/modules/authentication/bloc/authentication_bloc_state.dart';
import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc.dart';
import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc_event.dart';
import 'package:appdemo/modules/authentication/biometric/bloc/biometric_bloc_state.dart';
import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/home/cubit/cubit.dart';
import 'package:appdemo/modules/screens/myhome_screen.dart';
import 'package:appdemo/utils/show_dialog_widget.dart';
import 'package:appdemo/service/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool radioValue = false;
  bool passToggle = true;
  final keyPref = SharedPrefKey();

  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticated = false;
  bool fingerprintEnabled = false;

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
        showDialogCustomize(context, AlertType.error, DialogTitle.error,
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
      showDialogCustomize(context, AlertType.error, DialogTitle.error,
          AppLoginTerm.emptyFingerPrint);
    }
    if (authenticated) {
      setState(() {
        fingerprintEnabled = true;
      });
    }
  }

  String? email;
  String? password;
  String? emailFingerPrintRemember;
  String? passwordFingerPrintRemember;

  void getEmailAndPasswordByRemember() async {
    email = await keyPref.emailStore.read(key: keyPref.keyEmailRemember);
    password =
        await keyPref.passwordStore.read(key: keyPref.keyPasswordRememer);
    if (email == null) {
      email =
          await keyPref.emailStore.read(key: keyPref.keyEmailRememberToggle);
      password = await keyPref.passwordStore
          .read(key: keyPref.keyPasswordRememberToggle);
    }
    setState(() {
      emailController.text = email!;
      passController.text = password!;
      if (emailController.text.isNotEmpty) {
        setState(() {
          radioValue = true;
        });
      }
    });
  }

  void fingerprintLogin() async {
    emailFingerPrintRemember = await StoreLogin.getEmail();
    passwordFingerPrintRemember = await StoreLogin.getPassword();
  }

  @override
  void initState() {
    super.initState();
    getEmailAndPasswordByRemember();
    checkBiometrics();
    fingerprintLogin();
  }

  AuthenticationBloc fetchLogin = AuthenticationBloc();
  BiometricBloc fetchBiometric = BiometricBloc();
  @override
  Widget build(BuildContext context) {
    final userDataCubit = context.read<UserDataCubit>();
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                child: SafeArea(
                    child: Form(
                  key: formfield,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo-bo-y-te.jpg',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: AppLoginTerm.email,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          bool emailVaild = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return AppLoginTerm.requireEmail;
                          } else if (!emailVaild) {
                            return AppLoginTerm.corectEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.text,
                        obscureText: passToggle,
                        decoration: InputDecoration(
                            labelText: AppLoginTerm.password,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLoginTerm.requirePassword;
                          } else if (passController.text.length < 6) {
                            return AppLoginTerm.corectPassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                    onTap: () async {
                                      if (isAuthenticated) {
                                        await authenticate();
                                        if (fingerprintEnabled) {
                                          fetchBiometric.add(FetchBiometric(
                                              email: emailFingerPrintRemember,
                                              password:
                                                  passwordFingerPrintRemember));
                                        } else {
                                          if (!mounted) return;
                                          showDialogCustomize(
                                              context,
                                              AlertType.error,
                                              DialogTitle.error,
                                              AppLoginTerm.apiError);
                                        }
                                      } else {
                                        showDialogCustomize(
                                            context,
                                            AlertType.warning,
                                            DialogTitle.warning,
                                            AppLoginTerm.unavailableBiometrics);
                                      }
                                    },
                                    child: const Icon(
                                      FontAwesomeIcons.fingerprint,
                                      size: 40,
                                      color: Colors.blueAccent,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.red),
                                  value: radioValue,
                                  groupValue: true,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      radioValue = !radioValue;
                                    });
                                  },
                                  toggleable: true, //giup bat tat button
                                ),
                                const Text(
                                  'Ghi nhớ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (formfield.currentState!.validate()) {
                            fetchLogin.add(FetchLogin(
                                email: emailController.text,
                                password: passController.text));
                          }
                        },
                        child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: const Center(
                                child: Text(
                              'ĐĂNG NHẬP',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))),
                      ),
                    ],
                  ),
                )))),
        BlocConsumer<BiometricBloc, BiometricState>(
            bloc: fetchBiometric,
            builder: (context, state) {
              if (state is BiometricLoading) {
                return const Positioned(
                  top: 330,
                  left: 170,
                  child: Visibility(
                      visible: true, child: CircularProgressIndicator()),
                );
              }
              return const SizedBox();
            },
            listener: (BuildContext context, BiometricState state) async {
              if (state is BiometricLoaded) {
                try {
                  await StoreLogin.setEmailFingerPrintRemember(
                      emailFingerPrintRemember!);

                  userDataCubit.updateUser(state.data);
                  if (!context.mounted) return;
                  Navigator.pushNamed(context, MyhomeScreen.routeName);
                } catch (e) {
                  showDialogCustomize(context, AlertType.error,
                      DialogTitle.error, AppLoginTerm.apiError);
                }
              } else if (state is BiometricErrorApi) {
                showDialogCustomize(context, AlertType.error,
                    DialogTitle.error, AppLoginTerm.apiError);
              } else if (state is BiometricErrorConnectivity) {
                showDialogCustomize(
                    context, AlertType.error, DialogTitle.error, state.error);
              } else if (state is BiometricErrorLoginFirst) {
                showDialogCustomize(context, AlertType.warning,
                    DialogTitle.warning, state.error);
              }
            }),
        BlocConsumer<AuthenticationBloc, AuthenticationState>(
          bloc: fetchLogin,
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return const Positioned(
                top: 330,
                left: 170,
                child: Visibility(
                    visible: true, child: CircularProgressIndicator()),
              );
            }
            return const SizedBox();
          },
          listener: (BuildContext context, AuthenticationState state) async {
            if (state is AuthenticationLoaded) {
              try {
                StoreLogin.setLoginUser(
                    emailController.text, passController.text);
                if (state.data.statusCode == 200) {
                  await keyPref.emailStore.write(
                      key: keyPref.keyEmailRememberToggle,
                      value: emailController.text);
                  await keyPref.passwordStore.write(
                      key: keyPref.keyPasswordRememberToggle,
                      value: passController.text);
                  if (radioValue == true) {
                    await keyPref.emailStore.write(
                        key: keyPref.keyEmailRemember,
                        value: emailController.text);
                    await keyPref.passwordStore.write(
                        key: keyPref.keyPasswordRememer,
                        value: passController.text);
                  } else if (radioValue == false) {
                    keyPref.emailStore.delete(key: keyPref.keyEmailRemember);
                    keyPref.passwordStore
                        .delete(key: keyPref.keyPasswordRememer);
                  }
                  userDataCubit.updateUser(state.data);
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyhomeScreen.routeName, (route) => false);
                }
              } catch (e) {
                showDialogCustomize(context, AlertType.error,
                    DialogTitle.error, AppLoginTerm.apiError);
              }
            } else if (state is AuthenticationError) {
              showDialogCustomize(context, AlertType.error, DialogTitle.error,
                  AppLoginTerm.incorrectEmailAndPassword);
            } else if (state is AuthenticationErrorApi) {
              showDialogCustomize(context, AlertType.error, DialogTitle.error,
                  AppLoginTerm.apiError);
            } else if (state is AuthenticationErrorConnectivity) {
              showDialogCustomize(
                  context, AlertType.error, DialogTitle.error, state.error);
            }
          },
        ),
      ],
    ));
  }
}
