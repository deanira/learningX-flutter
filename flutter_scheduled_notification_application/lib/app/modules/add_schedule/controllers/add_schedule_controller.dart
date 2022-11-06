import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_scheduled_notification_application/app/data/medicine.dart';
import 'package:flutter_scheduled_notification_application/app/utils/notification_api.dart';
import 'package:flutter_scheduled_notification_application/app/helper/db_helper.dart';
import 'package:get/get.dart';

class AddScheduleController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController frequencyController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    NotificationApi.init();
  }

  var db = DbHelper();

  void add(String name, int frequency) async {
    await db.insertMedicine(Medicine(name: name, frequency: frequency));

    NotificationApi.scheduledNotification(
      id: 1,
      title: "Jangan Lupa Sarapan",
      body: "Yuk cek resep di katalog!",
      payload: "sarapan",
      scheduledDate: const Time(7, 0, 0),
    ).then((value) {
      Get.snackbar("Berhasil", "Pengingat sarapan berhasil diaktifkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    });
  }
}
