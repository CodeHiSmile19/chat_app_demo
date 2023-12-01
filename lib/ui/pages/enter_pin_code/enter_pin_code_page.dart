import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/ui/pages/enter_user_information/enter_user_information_page.dart';
import 'package:chat_app_demo/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class EnterPinCodePage extends StatefulWidget {
  final String phoneNumber;

  const EnterPinCodePage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<EnterPinCodePage> createState() => _EnterPinCodePageState();
}

class _EnterPinCodePageState extends State<EnterPinCodePage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 24,
    height: 24,
    textStyle: AppTextStyles.primaryS32Bold,
    decoration: BoxDecoration(
      color: AppColors.backgroundGrayColor,
      borderRadius: BorderRadius.circular(24),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const AppBarWidget(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Enter Code",
                      style: AppTextStyles.primaryS24Bold,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We have sent you an SMS with the code\nto ${widget.phoneNumber}",
                      style: AppTextStyles.primaryS14Normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Pinput(
                crossAxisAlignment: CrossAxisAlignment.center,
                controller: pinController,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 32),
                validator: (value) {
                  return value == '2222'
                      ? null
                      : 'OTP chưa chính xác. Xin vui lòng nhập lại.';
                },
                hapticFeedbackType: HapticFeedbackType.disabled,
                onCompleted: (pin) {
                  if (pin == "2222") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EnterUserInformationPage(),
                      ),
                    );
                  }
                },
                focusedPinTheme: defaultPinTheme.copyWith(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyWith(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  textStyle: AppTextStyles.primaryS32Bold.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Text(
                "Resend Code",
                style: AppTextStyles.primaryS16SemiBold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
