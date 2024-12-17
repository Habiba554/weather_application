import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.translate(AppStrings.haveAnAccount) ,style: AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color),),
        Semantics(
          button: true,
          label:  "Tab to Navigate to Login screen" ,
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.translate(AppStrings.login),
                  style: AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color,decoration: TextDecoration.underline,),)),
        )
      ],
    );
  }
}