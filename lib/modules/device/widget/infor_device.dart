import 'package:appdemo/data/term/app_term.dart';
import 'package:appdemo/modules/device/model/device_model.dart';
import 'package:appdemo/themes/app_color.dart';
import 'package:flutter/material.dart';

class InforDevice extends StatelessWidget {
  final DeviceData device;

  const InforDevice(this.device, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 500,
      decoration: const BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(children: [
        CircleAvatar(
          backgroundColor: AppColors.white2,
          radius: 60,
          child: CircleAvatar(
            radius: 40,
            child: Image.asset('assets/images/rounded-in-photoretrica.png'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            device.title,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ((device.status == 'not_handed') ||
                      (device.status == 'active'))
                  ? AppColors.green1
                  : Colors.red),
          child: Text(statusDeviceObject[device.status]!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ),
        const Divider(
          color: AppColors.divider,
          thickness: 1.4,
          indent: 20,
          endIndent: 20,
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppDetailDeviceTerm.model,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Text(AppDetailDeviceTerm.serial,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500))
                    ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text((device.model != null) ? device.model! : AppDetailDeviceTerm.none,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  Text(
                      (device.serial != null)
                          ? device.serial!
                          : AppDetailDeviceTerm.none,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black))
                ])
              ],
            )),
        const Divider(
          color: AppColors.divider,
          thickness: 1.4,
          indent: 20,
          endIndent: 20,
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppDetailDeviceTerm.yearManfacture,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Text(AppDetailDeviceTerm.yearUse,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500))
                    ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                      (device.yearManufacture != null)
                          ? device.yearManufacture!
                          : AppDetailDeviceTerm.none,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  Text(
                      (device.yearUse != null)
                          ? device.yearUse!
                          : AppDetailDeviceTerm.none,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black))
                ])
              ],
            )),
        const Divider(
          color: AppColors.divider,
          thickness: 1.4,
          indent: 20,
          endIndent: 20,
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppDetailDeviceTerm.manufacturer,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Text(AppDetailDeviceTerm.origin,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500))
                    ]),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            (device.manufacturer != null)
                                ? device.manufacturer!
                                : AppDetailDeviceTerm.none,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        Text(
                            (device.origin != null)
                                ? device.origin!
                                : AppDetailDeviceTerm.none,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black))
                      ]),
                )
              ],
            )),
      ]),
    );
  }
}
