import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_scheduled_notification_application/app/data/medicine.dart';
import 'package:flutter_scheduled_notification_application/app/data/notification.dart'
    as notif;
import 'package:flutter_scheduled_notification_application/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_scheduled_notification_application/app/utils/notification_api.dart';
import 'package:flutter_scheduled_notification_application/app/helper/db_helper.dart';
import 'package:get/get.dart';

class AddScheduleController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController frequencyController;
  final List<TextEditingController> timeController =
      [TextEditingController()].obs;

  var db = DbHelper();
  final frequency = 0.obs;

  HomeController homeController = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    NotificationApi.init();

    nameController = TextEditingController();
    frequencyController = TextEditingController();
  }

  void add(String name, int frequency) async {
    await db.insertMedicine(Medicine(name: name, frequency: frequency));

    var lastMedicineId = await db.getLastMedicineId();

    for (int i = 1; i <= frequency; i++) {
      await db.insertNotification(notif.Notification(
          idMedicine: lastMedicineId, time: timeController[i].text));
    }

    List<notif.Notification> notifications =
        await db.getNotificationsByMedicineId(lastMedicineId);

    for (int i = 0; i < notifications.length; i++) {
      print("making notification ${notifications[i].id}");
      await NotificationApi.scheduledNotification(
        id: notifications[i].id!,
        title: "Waktunya minum obat $name",
        body: "Minum obat agar cepat sembuh :)",
        payload: name,
        scheduledDate: Time(int.parse(notifications[i].time.split(':')[0]),
            int.parse(notifications[i].time.split(':')[1]), 0),
      ).then((value) => print("notif ${notifications[i].id} scheduled"));
    }

    // for (var element in notifications) {
    //   await NotificationApi.scheduledNotification(
    //     id: element.id!,
    //     title: "Waktunya minum obat $name",
    //     body: "Minum obat agar cepat sembuh :)",
    //     payload: name,
    //     scheduledDate: Time(int.parse(element.time.split(':')[0]),
    //         int.parse(element.time.split(':')[1]), 0),
    //   );
    //   print("notif ${element.id} scheduled");
    // }

    homeController.getAllMedicineData();
    Get.back();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    frequencyController.dispose();
    for (var element in timeController) {
      element.dispose();
    }
  }
}
