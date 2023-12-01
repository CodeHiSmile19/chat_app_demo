import 'package:chat_app_demo/commons/app_colors.dart';
import 'package:chat_app_demo/commons/app_text_styles.dart';
import 'package:chat_app_demo/commons/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListUserWidget extends StatelessWidget {
  const ListUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: ListView.separated(
        itemCount: 4,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(
          width: 16,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.lightPurpleColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.textGrayColor,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    AppVectors.icPlusGray,
                    height: 24,
                    width: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "Your story",
                    style: AppTextStyles.primaryS10Normal,
                  ),
                )
              ],
            );
          }
          return SizedBox(
            width: 56,
            height: 56,
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.purpleColor,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Salsabila Salsabila",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.primaryS10Normal,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
