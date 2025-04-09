import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_sb/shared/controllers/user_controller.dart';
import 'package:qubit_sb/shared/ui/users/useraction/circle_user.dart';

class UserAction extends StatelessWidget {
  UserAction({super.key});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CircleUser(),
      ),
      itemBuilder:
          (itemBuilder) => [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Cambia Nombre de Usuario"),
                onTap: () async {
                  await Get.toNamed("/updateuser");
                  Get.offAllNamed("/home");
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Cambia Password"),
                onTap: () async {
                  await Get.toNamed("/changepwd");
                  Get.offAllNamed("/home");
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Cambia Foto de Perfil"),
                onTap: () async {
                  await Get.toNamed("/changephoto");
                  Get.offAllNamed("/home");
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: const Text("SignOut"),
                onTap: () {
                  userController.signOut();
                },
              ),
            ),
          ],
    );
  }
}
