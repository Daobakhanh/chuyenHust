import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/modules/device/widget/infor_device.dart';
import 'package:appdemo/modules/error/bloc/report_error_bloc_event.dart';
import 'package:appdemo/modules/error/bloc/report_error_bloc.dart';
import 'package:appdemo/modules/error/bloc/report_error_bloc_state.dart';
import 'package:appdemo/service/connectivity.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:appdemo/utils/show_dialog_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen(this.models, {super.key});
  final DeviceData models;
  static String routeName = 'report_screen';
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    final fetchReportError = BlocProvider.of<ReportErrorBloc>(context);
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Thiết Bị'),
          centerTitle: true,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: ListView(children: [
              Column(children: [
                InforDevice(widget.models),
                BlocConsumer<ReportErrorBloc, ReportErrorState>(
                    builder: (context, state) {
                  if (state is ReportErrorLoading) {
                    return const CircularProgressIndicator();
                  }
                  return const SizedBox();
                }, listener: (context, state) {
                  if (state is ReportErrorLoaded) {                   
                    showDialogCustomize(
                                              context,
                                              AlertType.success,
                                              DialogTitle.success,
                                              state.data.message!.tr());
                  } else if (state is ReportErrorErrorApi) {
                    showDialogCustomize(
                                              context,
                                              AlertType.error,
                                              DialogTitle.error,
                                              state.error);
                  }
                }),
                Container(
                  height: 80,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.white2,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    maxLines: 500,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.white2,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                      hintText: AppReportErrorTerm.reasonError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 0.8),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      if (_textEditingController.text.isNotEmpty) {
                        fetchReportError.add(FetchReportError(
                            device: widget.models,
                            reason: _textEditingController.text));
                      } else {
                        showToast(AppReportErrorTerm.reasonError);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: const Text('Báo Hỏng',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ))
              ])
            ])));
  }
}
