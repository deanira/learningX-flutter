import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_application/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_application/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //   future: controller.getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       print(snapshot.data);
      //       var data = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: data.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(data[index]['title']),
      //             subtitle: Text(data[index]['description']),
      //           );
      //         },
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () =>
                        Get.toNamed(Routes.UPDATE, arguments: data[index].id),
                    title: Text(data[index]['title']),
                    subtitle: Text(data[index]['description']),
                    trailing: IconButton(
                        onPressed: () => controller.deleteData(data[index].id),
                        icon: Icon(Icons.delete)),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
