import 'dart:io';

import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_images.dart';
import 'package:chat_app_demo/global/global_data.dart';
import 'package:chat_app_demo/models/entities/authenticate_entity.dart';
import 'package:chat_app_demo/models/isar_database/isar_account_entity.dart';
import 'package:chat_app_demo/services/fire_storage_service.dart';
import 'package:chat_app_demo/services/fire_store_storage_service.dart';
import 'package:chat_app_demo/services/isar_service.dart';
import 'package:chat_app_demo/ui/components/select_image_widget.dart';
import 'package:chat_app_demo/ui/pages/main/main_page.dart';
import 'package:chat_app_demo/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:chat_app_demo/ui/widgets/button/primary_button.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class EnterUserInformationPage extends StatefulWidget {
  final String? userId;
  final String? phoneNumber;

  const EnterUserInformationPage({
    Key? key,
    this.userId,
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<EnterUserInformationPage> createState() =>
      _EnterUserInformationPageState();
}

class _EnterUserInformationPageState extends State<EnterUserInformationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  String? urlAvatar;
  File? imageSelected;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 46),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return SelectUploadImage(
                          takePhotoTitle: "Chụp ảnh",
                          choosePhotoTile: "Chọn từ thư viện",
                          cancelTitle: "Hủy",
                          onSubmitImage: (files) async {
                            setState(() {
                              imageSelected = File(files.single.path);
                            });
                          },
                        );
                      },
                    );
                  },
                  child: imageSelected != null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: FileImage(imageSelected!),
                                fit: BoxFit.cover),
                          ),
                          // child: Image.file(imageSelected!),
                        )
                      : Image.asset(
                          AppImages.imgChangeAvatar,
                        ),
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
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: addressController,
                  hintText: "Address",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: "Password",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: rePasswordController,
                  hintText: "Enter again pasword",
                  keyboardType: TextInputType.text,
                ),
                PrimaryButton(
                  title: "Save",
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                  ),
                  onTap: () {
                    sendUserInfo();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendUserInfo() async {
    try {
      if (imageSelected != null) {
        String filePath = "images/";
        final fileName = imageSelected!.path;
        final destination = '$filePath${fileName.split("/").last}';

        var avatar = await FireStoreStorageService.uploadFile(
          destination,
          imageSelected!,
        );

        if (avatar != null) {
          urlAvatar = await avatar.ref.getDownloadURL();
        }
      }

      ///Open FireStorage Service
      final fireStorageService = FireStorageService();

      ///Lấy về text mình vừa nhập xong
      final userInfo = AccountEntity(
        uId: widget.userId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        address: addressController.text,
        passWord: passwordController.text,
        phoneNumber: widget.phoneNumber,
        avatar: urlAvatar,
      );

      ///Save thông tin user lên Firestorage
      await fireStorageService.createUser(userInfo);
      final isarService = IsarService();

      final user = IsarAccountEntity(
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        address: userInfo.address,
        phoneNumber: userInfo.phoneNumber,
        avatar: userInfo.avatar,
      );

      isarService.saveAccount(user);

      GlobalData.instance.currentUser = userInfo;
      ///Nếu lưu thành công thì vào màn HomeScreen
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      const SnackBar(
        content: Text("Đã xảy ra lỗi!"),
      );
    }
  }
}
