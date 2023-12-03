import 'package:chat_app_demo/commons/app_images.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/global/global_data.dart';
import 'package:chat_app_demo/services/fire_storage_service.dart';
import 'package:chat_app_demo/services/isar_service.dart';
import 'package:chat_app_demo/ui/pages/enter_phone_number/enter_phone_number_page.dart';
import 'package:chat_app_demo/ui/pages/main/main_page.dart';
import 'package:chat_app_demo/ui/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    _checkAccountSaved();
  }

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
                  _checkAccountSaved();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAccountSaved() async {
    /// Mở Isar service
    final isarService = IsarService();
    final fireStorageService = FireStorageService();

    ///Lấy về user đã lưu trong database
    final accounts = await isarService.getAccount();

    ///Nếu danh sách lấy về không rỗng (có user đã đăng nhập) => Vào màn Home
    ///Nếu danh sách trống (Chưa đăng nhập) => Vào màn nhập SDT
    if (accounts.isNotEmpty) {
      final user = await fireStorageService.searchUser(
        accounts[0].phoneNumber!,
      );
      GlobalData.instance.currentUser = user;

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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const EnterPhoneNumberPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
