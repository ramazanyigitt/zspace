import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/splash/splash/splash_viewmodel.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Center(
            child: Text('Splash Page'),
          ),
        );
      },
    );
  }
}
