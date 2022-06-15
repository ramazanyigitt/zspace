import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ValidatorService {
  String? onlyNumber(String? text) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      RegExp regExp = new RegExp(r'[^0-9-]');

      if (regExp.hasMatch(text!)) {
        return 'Please enter valid number.';
      }
      return null;
    }
  }

  String? onlyDouble(String? text) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      RegExp regExp = new RegExp(r'[^0-9-.]');

      if (regExp.hasMatch(text!)) {
        return 'Please enter valid number.';
      }
      return null;
    }
  }

  String? onlyText(String? text, {int? maxLength}) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      RegExp regExp = new RegExp(r'[!@#<>?":_`~;[\]\\|=+) (*&^%0-9-]');

      if (regExp.hasMatch(text!)) {
        return 'Please enter valid text.';
      }
      if (maxLength != null) if (text.length > maxLength) {
        return 'Please enter a $maxLength digit.';
      }
      return null;
    }
  }

  String? phoneNumber(String? text) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(pattern);

      if (!regExp.hasMatch(text!)) {
        return 'Please enter valid mobile number';
      }
      return null;
    }
  }

  String? onlyRequired(String? text, {int? maxLength}) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      if (maxLength != null) if (text!.length > maxLength) {
        return 'Please enter a $maxLength digit.';
      }
      return null;
    }
  }

  String? passwordUpperLowerNumber(String? text, {int? minLength}) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      //Number contains at least one digit
      RegExp numberExp = new RegExp(r'(?=.*[0-9])');
      //Lowercase contains at least one lowercase letter
      RegExp lowerExp = new RegExp(r'(?=.*[a-z])');
      //Uppercase contains at least one uppercase letter
      RegExp upperExp = new RegExp(r'(?=.*[A-Z])');

      if (!numberExp.hasMatch(text!)) {
        return 'Must contain 1 number.';
      }
      if (!lowerExp.hasMatch(text)) {
        return 'Must contain 1 lowercase letter.';
      }
      if (!upperExp.hasMatch(text)) {
        return 'Must contain 1 uppercase letter.';
      }
      if (minLength != null) if (text.length < minLength) {
        return 'Please enter a $minLength digit password.';
      }
      return null;
    }
  }

  String? email(String? text) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      final isEmailCorrect = EmailValidator.validate(text!);

      if (isEmailCorrect) {
        return null;
      }
      return 'Please enter a valid email address.';
    }
  }

  String? phoneNumberWith1To12(
    String? text,
  ) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      //await Future.delayed(Duration(milliseconds: 250));

      String pattern = r'(^(?:[+0]9)?[0-9]{1,12}$)';
      RegExp regExp = new RegExp(pattern);

      if (!regExp.hasMatch(text!)) {
        return 'Please enter valid mobile number.';
      }
      return null;
    }
  }

  Future<String?> validateEmailWhenStop(String? text,
      {required TextEditingController controller}) async {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    } else {
      await Future.delayed(Duration(milliseconds: 100));
      if (text == controller.text) {
        final isEmailCorrect = EmailValidator.validate(text!);

        if (isEmailCorrect) {
          return null;
        }
        return 'Please enter a valid email address.';
      }
      return '';
    }
  }
}
