import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/domain/repositories/data_repository.dart';
import 'package:zspace/features/authentication/login/login_page.dart';
import 'package:zspace/injection_container.dart';

import '../../../core/services/validator_service.dart';
import '../../../data/models/auto_validator_model.dart';
import '../../_components/overlay/lock_overlay.dart';
import '../../_components/overlay/snackbar_overlay.dart';
import '../../home/main_menu/main_menu_page.dart';

class RegisterViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();

  AutoValidatorModel name = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text, maxLength: 32),
  );
  AutoValidatorModel password = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );

  void register() async {
    if (formKey.currentState?.validate() == true) {
      LockOverlay().showClassicLoadingOverlay();
      await sendRegisterRequestAndHandle();
      LockOverlay().closeOverlay();
    } else {
      //
    }
  }

  Future<void> sendRegisterRequestAndHandle() async {
    final result = await locator<DataRepository>().register(
      name.textController.text,
      password.textController.text,
    );
    if (result is Right) {
      Get.off(() => MainMenuPage());
    } else {
      SnackbarOverlay().show(
        text: 'Register failed please try again.',
        buttonText: 'OK',
        buttonTextColor: Colors.red,
        addFrameCallback: true,
        fullTap: true,
        removeDuration: Duration(seconds: 3),
      );
    }
  }

  void goToLoginPage() {
    Get.off(
      () => LoginPage(),
      duration: Duration.zero,
      transition: Transition.noTransition,
    );
  }
}
