import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_localization.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/crud_controller.dart';
import 'package:weather_app/providers/user_provider.dart';
import 'package:weather_app/views/widgets/custom_button.dart';
import 'package:weather_app/views/widgets/snack_bar.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final Crud crud = Crud();



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.translate(AppStrings.addReport),style: AppStyle.poppins400style16.copyWith(color: theme.secondaryHeaderColor),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration:  InputDecoration(
                  labelText: context.translate(AppStrings.title),
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
                ),
                style: AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color),
                cursorColor: theme.secondaryHeaderColor,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descController,
                decoration:  InputDecoration(
                  labelText: context.translate(AppStrings.description),
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
                ),
                style: AppStyle.poppins400style14.copyWith(color: theme.textTheme.bodyLarge?.color),
                cursorColor: theme.secondaryHeaderColor,
                maxLines: 3,
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(text: context.translate(AppStrings.submit), 
              onPressed: ()=>_submitReport(context),
               backgroundColor: theme.secondaryHeaderColor,
                textColor: theme.primaryColor)
            ],
          ),
        ),
      ),
    );
  }

    Future<void> _submitReport(BuildContext context) async {
    String userId = Provider.of<UserProvider>(context,listen: false).userId;
    String title = titleController.text.trim();
    String desc = descController.text.trim();
    if (title.isNotEmpty && desc.isNotEmpty) {
      if (userId.isNotEmpty) {
        try {
          await crud.addReport(userId, title, desc);
          titleController.clear();
          descController.clear();
          showSnackBars(msg: context.translate(AppStrings.reportAddedSuccessfully),context);

        } catch (e) {
          showSnackBars(msg: 'Error: $e',context);

        }
      } else {
        showSnackBars(msg: context.translate(AppStrings.userIdMissing),context);
      }
    } else {
      showSnackBars(msg: context.translate(AppStrings.pleaseEnterBothTitleAndDescription),context);

    }
  }
}
