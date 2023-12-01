import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_images.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "More",
                    style: AppTextStyles.primaryS16SemiBold,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGrayColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppVectors.icUserPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Almayra Zamzamy',
                          style: AppTextStyles.primaryS14SemiBold,
                        ),
                        Text(
                          '+62 1309 - 1710 - 1920',
                          style: AppTextStyles.grayS12Normal.copyWith(
                            color: AppColors.textGrayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    AppVectors.icArrowRight,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
