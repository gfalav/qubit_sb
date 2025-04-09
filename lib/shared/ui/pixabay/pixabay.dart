import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_sb/shared/controllers/pixabay_controller.dart';

class Pixabay extends StatelessWidget {
  const Pixabay({super.key});

  @override
  Widget build(BuildContext context) {
    final PixabayController pixabayController = Get.put(PixabayController());

    return Obx(
      () => Center(
        child:
            pixabayController.images.isNotEmpty
                ? Image.network(
                  fit: BoxFit.fill,
                  pixabayController.images[Random().nextInt(
                    pixabayController.images.length,
                  )],
                  width: 600,
                )
                : Text("Pixabay"),
      ),
    );
  }
}
