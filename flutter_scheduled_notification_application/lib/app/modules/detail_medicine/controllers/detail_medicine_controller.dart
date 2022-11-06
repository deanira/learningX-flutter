import 'package:flutter_scheduled_notification_application/app/data/medicine.dart';
import 'package:flutter_scheduled_notification_application/app/data/notification.dart';
import 'package:flutter_scheduled_notification_application/app/helper/db_helper.dart';
import 'package:get/get.dart';

class DetailMedicineController extends GetxController {
  var db = DbHelper();

  Future<Medicine> getMedicineData(int id) async {
    return await db.queryOneMedicine(id);
  }

  Future<List<Notification>> getNotificationData(int id) async {
    return await db.getNotificationsByMedicineId(id);
  }

  void deleteMedicine(int id) async {
    await db.deleteMedicine(id);
    await db.deleteNotificationByMedicineId(id);
    Get.back();
  }
}
