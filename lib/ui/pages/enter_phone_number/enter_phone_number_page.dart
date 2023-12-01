import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/ui/pages/enter_pin_code/enter_pin_code_page.dart';
import 'package:chat_app_demo/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:chat_app_demo/ui/widgets/button/primary_button.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class EnterPhoneNumberPage extends StatefulWidget {
  const EnterPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<EnterPhoneNumberPage> createState() => _EnterPhoneNumberPageState();
}

class _EnterPhoneNumberPageState extends State<EnterPhoneNumberPage> {
  TextEditingController phoneNumberController = TextEditingController();
  String preNumber = "+84";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const AppBarWidget(),
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
              const Spacer(),
              PrimaryButton(
                title: "Continue",
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EnterPinCodePage(
                        phoneNumber: "$preNumber ${phoneNumberController.text}",
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
