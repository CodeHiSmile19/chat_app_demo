import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/helpers/string_helper.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String? avatar;
  final String? fullName;
  final String? subTitle;
  final String? lastTimeOnline;
  final bool? status;
  final int? mustReadMessageNumber;
  final bool showLastTimeOnline, showLastMessageNumber;
  final Function? onTap;

  const UserInfoWidget({
    Key? key,
    this.showLastTimeOnline = true,
    this.showLastMessageNumber = true,
    this.fullName,
    this.avatar,
    this.lastTimeOnline,
    this.mustReadMessageNumber,
    this.subTitle,
    this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: 56,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                (avatar ?? '').isNotEmpty
                    ? Container(
                        width: 56,
                        height: 56,
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                avatar ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 56,
                        height: 56,
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.blueColor,
                          ),
                          child: Center(
                            child: Text(
                              StringHelper.getFirstName(
                                fullName ?? '',
                              ),
                              style: AppTextStyles.whiteS14Bold,
                            ),
                          ),
                        ),
                      ),
                Visibility(
                  visible: status ?? false,
                  child: Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          fullName ?? '',
                          style: AppTextStyles.primaryS14SemiBold,
                        ),
                      ),
                      if (showLastTimeOnline)
                        Text(
                          lastTimeOnline ?? '',
                          style: AppTextStyles.primaryS10Normal.copyWith(
                            color: AppColors.textGray2Color,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subTitle ?? '',
                          style: AppTextStyles.primaryS10Normal,
                        ),
                      ),
                      if (showLastMessageNumber)
                        if ((mustReadMessageNumber ?? 0) > 0) ...[
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.brandColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                "1",
                                style: AppTextStyles.primaryS10SemiBold,
                              ),
                            ),
                          ),
                        ],
                    ],
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
