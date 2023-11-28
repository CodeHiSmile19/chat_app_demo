import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/ui/pages/enter_user_information/enter_user_information_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    textStyle: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimaryColor,
    ),
    decoration: BoxDecoration(
      color: AppColors.backgroundGrayColor,
      borderRadius: BorderRadius.circular(24),
    ),
  );

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
      ),
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
                    const Text(
                      "Enter Code",
                      style: TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We have sent you an SMS with the code\nto ${widget.phoneNumber}",
                      style: const TextStyle(
                        color: AppColors.textPrimaryColor,
                      ),
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
                    )),
                submittedPinTheme: defaultPinTheme.copyWith(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    )),
                errorPinTheme: defaultPinTheme.copyWith(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                "Resend Code",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
