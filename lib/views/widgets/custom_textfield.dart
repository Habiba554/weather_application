// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_style.dart';


class CustomFormTextField  extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final IconData? suffix;
  final IconData? prefix;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  CustomFormTextField({super.key, required this.hint,this.suffix,this.prefix,this.isObscureText = false, this.validator, required this.keyboardType, required this.controller});
  late bool isObscureText;


  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool isPasswordShown = false;
  bool get isPasswordShownGetter => isPasswordShown;
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        obscureText:widget.isObscureText ? !isPasswordShown : false,
        style: AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color),
        cursorColor: theme.secondaryHeaderColor,
        decoration: InputDecoration(
          hintText: widget.hint ,
          hintStyle:  TextStyle(color:theme.secondaryHeaderColor ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.secondaryHeaderColor
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.secondaryHeaderColor
              )
          ),
          suffixIcon: widget.isObscureText
              ? IconButton(
            icon: Icon(
              isPasswordShown
                  ? Icons.visibility
                  : Icons.visibility_off,
              color:theme.iconTheme.color,
            ),
            onPressed: () {
              setState(() {
                isPasswordShown = !isPasswordShown;
              });
            },
          )
              : null,
          prefixIcon: Icon(widget.prefix),
          prefixIconColor: theme.iconTheme.color

        ),
      ),
    );
  }
}