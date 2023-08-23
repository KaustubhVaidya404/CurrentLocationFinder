import 'package:flutter/material.dart';
import 'package:weatherapplication/controller/global_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalController globalController = Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() => globalController.checkLoading().isTrue ? const Center(
      child: CircularProgressIndicator(),
    ):Container(
        child: const Text(
          "Location Fetch"
        ),
    )));
  }
}

