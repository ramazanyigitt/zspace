import 'package:flutter/cupertino.dart';

class AutoValidatorModel {
  late TextEditingController textController;
  late String? Function(String?) validate;
  AutoValidatorModel({
    String? initialText,
    String? Function(String?)? validator,
  }) {
    if (validator == null) {
      validate = _isEmpty;
    } else {
      validate = validator;
    }
    textController = TextEditingController(text: initialText);
  }

  String? _isEmpty(String? text) {
    if (text?.isEmpty == true) {
      return 'This field can not be empty.';
    }
    return null;
  }
}
