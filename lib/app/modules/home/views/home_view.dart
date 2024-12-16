import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments from APi'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.errorMessages.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessages.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (controller.dataList.isEmpty) {
            return const Center(
              child: Text('No Data Available'),
            );
          }

          return ListView.builder(
            itemCount: controller.dataList.length,
            itemBuilder: (context, index) {
              final item = controller.dataList[index];
              return ListTile(
                leading: Text(item.id.toString()),
                title: Text(item.name ?? ''),
                subtitle: Text(item.body ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
