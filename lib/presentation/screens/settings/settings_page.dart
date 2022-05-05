import 'package:flutter/material.dart';
import 'package:zspace/presentation/screens/settings/settings_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget settingButton(String text, VoidCallback onPressed) {
    return RaisedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
