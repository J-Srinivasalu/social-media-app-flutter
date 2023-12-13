import 'package:flutter/material.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:stacked/stacked.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final bool isPassword;
  const TextInputField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.text,
      required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TextInputFieldViewModel>.reactive(
      builder: (context, model, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isPassword ? !model.isPasswordVisible : false,
            style:
                const TextStyle(fontSize: 16, color: CustomColors.blackColor),
            decoration: InputDecoration(
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        model.toggleIsPasswordVisible();
                      },
                      icon: Icon(
                        model.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: model.isPasswordVisible
                            ? CustomColors.blueLightColor
                            : CustomColors.backgroundGreyColor,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.cancel),
                      color: CustomColors.backgroundGreyColor,
                    ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.lightGreyColor),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.lightGreyColor),
              ),
              labelText: text,
              labelStyle: const TextStyle(color: CustomColors.lightGreyColor),
              floatingLabelStyle:
                  const TextStyle(color: CustomColors.primaryColor),
              hintText: text,
              hintStyle: const TextStyle(color: CustomColors.lightGreyColor),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primaryColor),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => TextInputFieldViewModel(),
    );
  }
}

class TextInputFieldViewModel extends BaseViewModel {
  bool isPasswordVisible = false;

  void toggleIsPasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
