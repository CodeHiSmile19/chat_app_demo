import 'package:chat_app_demo/commons/app_images.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/ui/pages/enter_phone_number/enter_phone_number_page.dart';
import 'package:chat_app_demo/ui/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 65,
                  bottom: 42,
                ),
                child: Image.asset(
                  AppImages.imgSplash,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  "Connect easily with your family and friends over countries",
                  style: AppTextStyles.primaryS24Bold,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Text(
                "Terms & Privacy Policy",
                style: AppTextStyles.primaryS14SemiBold,
              ),
              PrimaryButton(
                title: "Start Messaging",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EnterPhoneNumberPage(),
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
