import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_sb/shared/controllers/user_controller.dart';

class CircleUser extends StatelessWidget {
  CircleUser({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CircleAvatar(
        backgroundColor: ColorScheme.of(context).tertiary,
        backgroundImage:
            userController.photoUrl.value != ''
                ? Image.network(
                  '${userController.photoUrl.value}?${DateTime.now().millisecondsSinceEpoch.toString()}',
                ).image
                : null,
        child:
            userController.photoUrl.value == ''
                ? Text(
                  userController.initials.value,
                  style: TextStyle(color: Colors.white),
                )
                : null,
      ),
    );
  }
}
