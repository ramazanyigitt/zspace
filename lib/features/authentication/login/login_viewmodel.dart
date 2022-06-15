import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/domain/repositories/data_repository.dart';
import 'package:zspace/injection_container.dart';

import '../../../core/services/validator_service.dart';
import '../../../data/models/auto_validator_model.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../_components/overlay/lock_overlay.dart';
import '../../_components/overlay/snackbar_overlay.dart';
import '../../home/main_menu/main_menu_page.dart';
import '../register/register_page.dart';

class LoginViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();

  AutoValidatorModel name = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text, maxLength: 32),
  );
  AutoValidatorModel password = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );

  void login() async {
    if (formKey.currentState?.validate() == true) {
      LockOverlay().showClassicLoadingOverlay();
      await sendLoginRequestAndHandle();
      LockOverlay().closeOverlay();
    } else {
      //
    }
  }

  Future<void> sendLoginRequestAndHandle() async {
    final result = await locator<DataRepository>().login(
      name.textController.text,
      password.textController.text,
    );
    if (result is Right) {
      log('LoginViewModel Result user model is: ${(result as Right).value}');
      await locator<LocalDataRepository>().saveUser((result as Right).value);
      log('Local user: ${locator<LocalDataRepository>().getUser()}');
      Get.off(() => MainMenuPage());
    } else {
      SnackbarOverlay().show(
        text: 'Login failed please try again.',
        buttonText: 'OK',
        buttonTextColor: Colors.red,
        addFrameCallback: true,
        removeDuration: Duration(seconds: 3),
        fullTap: true,
        onTap: () {
          SnackbarOverlay().closeCustomOverlay();
        },
      );
    }
  }

  void goToRegisterPage() {
    Get.off(
      () => RegisterPage(),
      duration: Duration.zero,
      transition: Transition.noTransition,
    );
  }
}
