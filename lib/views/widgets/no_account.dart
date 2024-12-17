import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_routes.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          context.translate(AppStrings.noAccount),
          style:  AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color),
        ),
        Semantics(
          button: true,
          label:  "Tab to Navigate to Sign up screen" ,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.signUpRoute);
            },
            child: Text(
              context.translate(AppStrings.signup),
              style: AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color,decoration: TextDecoration.underline,),
            ),
          ),
        )
      ],
    );
  }
}