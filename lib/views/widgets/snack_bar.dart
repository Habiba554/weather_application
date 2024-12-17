import 'package:flutter/material.dart';

void showSnackBars(BuildContext context,{required String msg}) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: theme.secondaryHeaderColor,
      ),
    );
  }