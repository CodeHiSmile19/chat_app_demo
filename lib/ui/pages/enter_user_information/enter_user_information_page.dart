import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_images.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/ui/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              AppVectors.icArrowRight,
              height: 24,
              width: 24,
            ),
          ),
        ),
        centerTitle: false,
        title: const Text(
          "Your Profile",
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.lightPurpleColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      hintText: "First Name (Required)",
                      hintStyle: TextStyle(
                        color: AppColors.textGrayColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      contentPadding: EdgeInsets.only(top: 10),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.lightPurpleColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Last Name (Optional)",
                      hintStyle: TextStyle(
                        color: AppColors.textGrayColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      contentPadding: EdgeInsets.only(top: 10),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
