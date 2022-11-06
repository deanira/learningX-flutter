import 'package:flutter/material.dart';
import 'package:flutter_scheduled_notification_application/app/data/medicine.dart';
import 'package:flutter_scheduled_notification_application/app/data/notification.dart'
    as notif;

import 'package:get/get.dart';

import '../controllers/detail_medicine_controller.dart';

class DetailMedicineView extends GetView<DetailMedicineController> {
  const DetailMedicineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DetailMedicineView'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            FutureBuilder<Medicine>(
              future: controller.getMedicineData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Text(snapshot.data!.name),
                    subtitle: Text(
                        "${snapshot.data!.frequency.toString()} kali sehari"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FutureBuilder<List<notif.Notification>>(
              future: controller.getNotificationData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].time),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('I don\'t need to take this medicine anymore'),
              onPressed: () {
                controller.deleteMedicine(Get.arguments);
              },
            ),
          ],
        ));
  }
}
