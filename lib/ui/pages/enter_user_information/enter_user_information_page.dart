import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_images.dart';
import 'package:chat_app_demo/ui/pages/main/main_page.dart';
import 'package:chat_app_demo/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:chat_app_demo/ui/widgets/button/primary_button.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class EnterUserInformationPage extends StatefulWidget {
  const EnterUserInformationPage({Key? key}) : super(key: key);

  @override
  State<EnterUserInformationPage> createState() =>
      _EnterUserInformationPageState();
}

class _EnterUserInformationPageState extends State<EnterUserInformationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const AppBarWidget(
        title: "Your Profile",
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 46),
                Image.asset(
                  AppImages.imgChangeAvatar,
                ),
                const SizedBox(height: 32),
                TextFieldWidget(
                  controller: firstNameController,
                  hintText: "First Name (Required)",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: lastNameController,
                  hintText: "Last Name (Optional)",
                  keyboardType: TextInputType.text,
                ),
                const Spacer(),
                PrimaryButton(
                  title: "Save",
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
