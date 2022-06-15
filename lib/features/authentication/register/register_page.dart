import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/authentication/register/register_viewmodel.dart';
import '../../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../_components/field_builder_auto.dart';
import '../components/confirm_button.dart';
import '../components/keep_signed_button.dart';
part 'topbar_widget.dart';

class RegisterPage extends StatefulWidget {
  final bool isSignIn;
  final Function()? onLogged, onVerified;
  final bool hideBackButton;
  RegisterPage({
    Key? key,
    this.isSignIn = false,
    this.onLogged,
    this.onVerified,
    this.hideBackButton: false,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().whiteColor,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Form(
              key: viewModel.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: locator<LottieCache>().load(
                      AppImages.spaceBackground.appLottie,
                      Container(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.topLeft,
                          radius: 2.67,
                          colors: <Color>[
                            Colors.yellow.withAlpha(100),
                            Colors.black.withAlpha(40)
                          ],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              _TopBarWidget(),
                              SizedBox(
                                height: 50.h,
                              ),
                              FieldBuilderAuto(
                                key: GlobalKey(),
                                controller: viewModel.name.textController,
                                validator: viewModel.name.validate,
                                text: 'Username',
                                hint: '',
                                margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                                autovalidateMode: true,
                                style: AppTheme().smallParagraphRegularText,
                                keyboardType: TextInputType.name,
                                titleStyle: AppTheme()
                                    .smallParagraphMediumText
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: AppTheme()
                                          .paragraphSemiBoldText
                                          .fontSize,
                                    ),
                                fillColor: Colors.white.withOpacity(0.25),
                                borderColor: Colors.white,
                              ),
                              SizedBox(height: 15.h),
                              FieldBuilderAuto(
                                controller: viewModel.password.textController,
                                validator: viewModel.password.validate,
                                obscureVisibility: true,
                                obscureIconColor: Colors.white,
                                text: 'Password',
                                hint: '',
                                margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                                autovalidateMode: true,
                                style: AppTheme().smallParagraphRegularText,
                                titleStyle: AppTheme()
                                    .smallParagraphMediumText
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: AppTheme()
                                          .paragraphSemiBoldText
                                          .fontSize,
                                    ),
                                fillColor: Colors.white.withOpacity(0.25),
                                borderColor: Colors.white,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              KeepSignedButton(
                                onTap: () {
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: ConfirmButton(
                                  text: 'Register',
                                  onClick: viewModel.register,
                                ),
                              ),
                              GestureDetector(
                                onTap: viewModel.goToLoginPage,
                                child: Container(
                                  color: Colors.transparent,
                                  padding:
                                      EdgeInsets.only(bottom: 10.h, top: 15.h),
                                  alignment: Alignment.bottomCenter,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Already have an account? ',
                                        style: AppTheme()
                                            .smallParagraphMediumText
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      TextSpan(
                                        text: 'Sign in',
                                        style: AppTheme()
                                            .smallParagraphMediumText
                                            .copyWith(
                                              color:
                                                  AppTheme().darkPrimaryColor,
                                            ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
