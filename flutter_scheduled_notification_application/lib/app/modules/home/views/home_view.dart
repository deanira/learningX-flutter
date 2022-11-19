import 'package:flutter/material.dart';
import 'package:flutter_scheduled_notification_application/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: controller.obx((state) =>
        ListView.builder(
          itemCount: controller.listMedicines.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.listMedicines[index].name),
              subtitle: Text("${controller.listMedicines[index].frequency.toString()} kali sehari"),
              onTap: () => Get.toNamed(Routes.DETAIL_MEDICINE,
                    arguments: controller.listMedicines[index].id),
            );
          },
        ),
      onLoading: Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_SCHEDULE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
