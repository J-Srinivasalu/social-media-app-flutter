import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/widgets/text_input_field.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, child) => LoadingOverlay(
              isLoading: model.isBusy,
              progressIndicator: const CircularProgressIndicator(),
              color: Colors.black,
              opacity: 0.2,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 40),
                                alignment: Alignment.center,
                                child: const Text(
                                  "SMA",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.primaryColor,
                                      fontSize: 24),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "Login to your Account",
                                  style: TextStyle(
                                      color: CustomColors.blackColor,
                                      fontSize: 18),
                                ),
                              ),
                              TextInputField(
                                controller: model.emailController,
                                keyboardType: TextInputType.emailAddress,
                                text: "Email",
                                isPassword: false,
                              ),
                              TextInputField(
                                controller: model.passwordController,
                                keyboardType: TextInputType.emailAddress,
                                text: "Password",
                                isPassword: true,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      model.login();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primaryColor,
                                    padding: const EdgeInsets.all(12),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: CustomColors.whiteColor,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 24, top: 0, right: 24, bottom: 40),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: "Register",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.blueDarkestColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => model.navigateToRegister(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => LoginViewModel());
  }
}
