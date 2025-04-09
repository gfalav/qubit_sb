import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_sb/shared/controllers/app_controller.dart';
import 'package:qubit_sb/shared/ui/pixabay/pixabay.dart';
import 'package:qubit_sb/shared/ui/scaffold/my_scaffold.dart';
import 'package:qubit_sb/shared/ui/users/forms/changeusrnameform.dart';

class ChangeUsrName extends StatelessWidget {
  const ChangeUsrName({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appController.setAppBarState(
        'UserName',
        0xe491,
        true,
        true,
        false,
        false,
        true,
        false,
        0.0,
        0.45,
      );
    });
    return MyScaffold(
      left: Center(child: Text("Left")),
      main: Changeusrnameform(),
      right: Pixabay(),
      bottom: Center(child: Text("Bottom")),
    );
  }
}
