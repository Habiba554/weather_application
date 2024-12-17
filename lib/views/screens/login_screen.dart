import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/user_authentication.dart';
import 'package:weather_app/views/widgets/custom_button.dart';
import 'package:weather_app/views/widgets/custom_textfield.dart';
import 'package:weather_app/views/widgets/no_account.dart';

class LoginScreen extends StatelessWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    UserAuthentication userAuthentication=UserAuthentication();
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
                    child: Text(
                      context.translate(AppStrings.login),
                      style: AppStyle.poppins600style35
                          .copyWith(color: theme.textTheme.bodyLarge?.color),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Semantics(
                    label: 'Email input field',
                    hint: context.translate(AppStrings.emailAddress),
                    child: CustomFormTextField(
                      controller: emailController,
                      hint: context.translate(AppStrings.emailAddress),
                      prefix: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Semantics(
                    label: "Password input field",
                    hint: context.translate(AppStrings.emailAddress),
                    child: CustomFormTextField(
                      controller: passwordController,
                      hint: context.translate(AppStrings.password),
                      suffix: Icons.visibility_off,
                      prefix: Icons.lock,
                      isObscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Password';
                        } else if (value.length < 8 || value.length > 20) {
                          return "Password should be from 8 to 20 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  CustomElevatedButton(
                        text: context.translate(AppStrings.login),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await userAuthentication.loginUser(context,emailController.text,passwordController.text);
                          } 
                        },
                        backgroundColor: theme.secondaryHeaderColor,
                        textColor: theme.primaryColor,
                      ),
                  const NoAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
