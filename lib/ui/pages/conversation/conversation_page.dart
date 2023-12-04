import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/global/global_data.dart';
import 'package:chat_app_demo/models/entities/user_entity.dart';
import 'package:chat_app_demo/services/fire_storage_service.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConversationPage extends StatefulWidget {
  final String? userId;
  final String? userName;

  const ConversationPage({
    Key? key,
    this.userId,
    this.userName,
  }) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late TextEditingController chatController;
  final currentUser = GlobalData.instance.currentUser;

  @override
  void initState() {
    chatController = TextEditingController();
    super.initState();
    FireStorageService().getListMessage(
      senderId: currentUser?.uId ?? '',
      receiveId: widget.userId ?? '',
    );
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
                    widget.userName ?? "",
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
                    InkWell(
                      onTap: () async {
                        final fireStoreService = FireStorageService();
                        await fireStoreService.createMessage(
                          senderId: currentUser?.uId ?? '',
                          receiveId: widget.userId ?? '',
                          content: chatController.text,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 16,
                        ),
                        child: SvgPicture.asset(
                          AppVectors.icSend,
                        ),
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
