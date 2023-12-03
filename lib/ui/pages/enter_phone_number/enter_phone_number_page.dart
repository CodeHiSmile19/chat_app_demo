import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/global/global_data.dart';
import 'package:chat_app_demo/models/isar_database/isar_account_entity.dart';
import 'package:chat_app_demo/services/fire_storage_service.dart';
import 'package:chat_app_demo/services/isar_service.dart';
import 'package:chat_app_demo/ui/pages/enter_pin_code/enter_pin_code_page.dart';
import 'package:chat_app_demo/ui/pages/main/main_page.dart';
import 'package:chat_app_demo/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:chat_app_demo/ui/widgets/button/primary_button.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnterPhoneNumberPage extends StatefulWidget {
  const EnterPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<EnterPhoneNumberPage> createState() => _EnterPhoneNumberPageState();
}

class _EnterPhoneNumberPageState extends State<EnterPhoneNumberPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String preNumber = "+84";
  bool showEnterPassWord = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const AppBarWidget(
        leading: SizedBox(),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Enter Your Phone Number",
                      style: AppTextStyles.primaryS24Bold,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Please confirm your country code and enter your phone number",
                      style: AppTextStyles.primaryS14Normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.lightPurpleColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CountryCodePicker(
                        padding: EdgeInsets.zero,
                        onChanged: (value) {
                          preNumber = value.dialCode ?? preNumber;
                        },
                        initialSelection: 'VN',
                        hideSearch: true,
                        showFlagMain: true,
                        showCountryOnly: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFieldWidget(
                        hintText: "Phone Number",
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              if (showEnterPassWord) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: TextFieldWidget(
                    hintText: "Password",
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
              const Spacer(),
              PrimaryButton(
                title: showEnterPassWord ? "Login" : "Continue",
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                onTap: () {
                  showEnterPassWord ? login() : onVerifyPhoneNumber();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onVerifyPhoneNumber() async {
    try {
      final fireStoreService = FireStorageService();
      final user = await fireStoreService.searchUser(
        "$preNumber${phoneNumberController.text}",
      );

      if (user != null) {
        setState(() {
          showEnterPassWord = true;
        });
      } else {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '$preNumber${phoneNumberController.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                navigateToEnterOTPScreen();
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          codeSent: (String? verficationID, int? resendToken) {
            setState(() {
              print("HiSmile verficationID: $verficationID");
              navigateToEnterOTPScreen(
                verificationCode: verficationID,
              );
            });
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            setState(() {
              print("HiSmile verficationID: $verificationID");
            });
          },
          timeout: const Duration(seconds: 120),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void navigateToEnterOTPScreen({
    String? verificationCode,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EnterPinCodePage(
          phoneNumber: "$preNumber${phoneNumberController.text}",
          verificationCode: verificationCode,
        ),
      ),
    );
  }

  void login() async {
    try {
      final fireStoreService = FireStorageService();
      final userInfo = await fireStoreService.login(
        phoneNumber: "$preNumber${phoneNumberController.text}",
        password: passwordController.text,
      );

      if (userInfo != null) {
        final isarService = IsarService();

        final user = IsarAccountEntity(
          firstName: userInfo.firstName,
          lastName: userInfo.lastName,
          address: userInfo.address,
          phoneNumber: userInfo.phoneNumber,
        );

        isarService.saveAccount(user);

        GlobalData.instance.currentUser = userInfo;
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Đã xảy ra lỗi!"),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
