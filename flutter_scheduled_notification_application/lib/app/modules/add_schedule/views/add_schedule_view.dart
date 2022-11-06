import 'package:flutter/material.dart';
import 'package:flutter_scheduled_notification_application/app/data/medicine.dart';

import 'package:get/get.dart';

import '../controllers/add_schedule_controller.dart';

class AddScheduleView extends GetView<AddScheduleController> {
  const AddScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddScheduleView'),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: const Text(
              'Add Medicine Page',
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Name',
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              controller: controller.frequencyController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Frequency',
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text('Add'),
                onPressed: () {
                  controller.add(controller.nameController.text,
                      int.parse(controller.frequencyController.text));
                },
              )),
        ],
      )),
    );
  }
}
