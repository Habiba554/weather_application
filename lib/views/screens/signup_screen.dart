import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/user_authentication.dart';
import 'package:weather_app/views/widgets/custom_button.dart';
import 'package:weather_app/views/widgets/custom_textfield.dart';
import 'package:weather_app/views/widgets/have_account.dart';
import 'package:weather_app/views/widgets/snack_bar.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserAuthentication userAuthentication=UserAuthentication();
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    context.translate(AppStrings.signup),
                    style: AppStyle.poppins600style35
                        .copyWith(color: theme.textTheme.bodyLarge?.color),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomFormTextField(
                    controller: emailController,
                    hint: context.translate(AppStrings.emailAddress),
                    prefix: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Email';
                      } else if (!(value.contains("@") &&
                          value.contains(".com"))) {
                        return 'Email format should be (Ex. user@gmail.com)';
                      }
                      return null;
                    },
                  ),
                  CustomFormTextField(
                    controller: passwordController,
                    hint: context.translate(AppStrings.password),
                    suffix: Icons.visibility_off,
                    prefix: Icons.lock,
                    isObscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Password';
                      } else if (value.length < 8) {
                        return "Password should be from 8 to 20 characters";
                      }
                      return null;
                    },
                  ),
                  CustomFormTextField(
                    controller: confirmPasswordController,
                    hint: context.translate(AppStrings.confirmPassword),
                    suffix: Icons.visibility_off,
                    prefix: Icons.lock,
                    isObscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Confirm  Password';
                      } else if (confirmPasswordController.text !=
                          passwordController.text) {
                        return "Your password does not match";
                      }
                      return null;
                    },
                  ),
                  CustomElevatedButton(
                    text: context.translate(AppStrings.signup),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        userAuthentication.registerUser(context, emailController.text, passwordController.text);
                      } else {
                         showSnackBars(msg: 'There was an error',context);
                      }
                    },
                    backgroundColor: theme.secondaryHeaderColor,
                    textColor: theme.primaryColor,
                  ),
                  const HaveAnAccount()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
