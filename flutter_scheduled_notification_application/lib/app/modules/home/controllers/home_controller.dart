import 'package:flutter_scheduled_notification_application/app/data/medicine.dart';
import 'package:flutter_scheduled_notification_application/app/helper/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var db = DbHelper();

  Future<List<Medicine>> getAllMedicineData() async {
    return await db.queryAllRowsMedicine();
  }
}
