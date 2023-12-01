import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/models/entities/user_entity.dart';
import 'package:chat_app_demo/ui/components/user_info_widget.dart';
import 'package:chat_app_demo/ui/pages/conversation/conversation_page.dart';
import 'package:chat_app_demo/ui/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
                    "Contacts",
                    style: AppTextStyles.primaryS16SemiBold,
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    AppVectors.icPlusPrimary,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: TextFieldWidget(
                controller: searchController,
                hintText: "Search",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SvgPicture.asset(
                    AppVectors.icSearchGray,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listUser.length,
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                itemBuilder: (context, index) {
                  final item = listUser[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserInfoWidget(
                        avatar: item.avatar,
                        fullName: item.fullName,
                        subTitle: item.lastTimeOnline,
                        status: item.status,
                        showLastMessageNumber: false,
                        showLastTimeOnline: false,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ConversationPage(
                                userInfo: item,
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 12,
                          bottom: 16,
                        ),
                        color: AppColors.backgroundGrayColor,
                        height: 1,
                        width: double.infinity,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
