import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/models/entities/user_entity.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConversationPage extends StatefulWidget {
  final UserEntity userInfo;

  const ConversationPage({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late TextEditingController chatController;
  late UserEntity userInfo;

  @override
  void initState() {
    userInfo = widget.userInfo;
    chatController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPurpleColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      AppVectors.icArrowLeft,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    userInfo.fullName ?? "",
                    style: AppTextStyles.primaryS16SemiBold,
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    AppVectors.icSearchPrimary,
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    AppVectors.icMenu,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.backgroundGrayColor,
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: SvgPicture.asset(
                        AppVectors.icPlusGray,
                      ),
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        controller: chatController,
                        hintText: "Meesage",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 16,
                      ),
                      child: SvgPicture.asset(
                        AppVectors.icSend,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
