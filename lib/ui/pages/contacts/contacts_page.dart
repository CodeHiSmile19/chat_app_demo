import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:chat_app_demo/global/global_data.dart';
import 'package:chat_app_demo/models/entities/authenticate_entity.dart';
import 'package:chat_app_demo/models/entities/user_entity.dart';
import 'package:chat_app_demo/models/enums/load_status.dart';
import 'package:chat_app_demo/services/fire_storage_service.dart';
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
  List<AccountEntity>? accounts;
  LoadStatus loadStatus = LoadStatus.initial;

  @override
  void initState() {
    searchController = TextEditingController();
    getAllAccount();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void getAllAccount() async {
    setState(() {
      loadStatus = LoadStatus.loading;
    });
    final user = GlobalData.instance.currentUser;
    try {
      final fireStoreService = FireStorageService();
      accounts = await fireStoreService.getListAccount();
      if ((accounts ?? []).isNotEmpty) {
        accounts!
            .removeWhere((element) => element.phoneNumber == user?.phoneNumber);
      }

      setState(() {
        loadStatus = LoadStatus.success;
      });
    } catch (e) {
      debugPrint("$e");
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loadStatus == LoadStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : loadStatus == LoadStatus.failure
                ? const Center(child: Text("Dữ liệu lấy về không thành công!"))
                : Column(
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
                          itemCount: accounts?.length ?? 0,
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                          itemBuilder: (context, index) {
                            final item = accounts?[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UserInfoWidget(
                                  avatar: item?.avatar,
                                  fullName:
                                      "${item?.firstName} ${item?.lastName}",
                                  subTitle: item?.address,
                                  status: false,
                                  showLastMessageNumber: false,
                                  showLastTimeOnline: false,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ConversationPage(
                                          userId: item?.uId,
                                          userName:
                                              "${item?.firstName} ${item?.lastName}",
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
