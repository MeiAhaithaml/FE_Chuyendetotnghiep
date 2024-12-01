import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/images_widget.dart';
import 'package:study_app/common/widgets/text_widgets.dart';
import 'package:study_app/features/profile/controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/models/contants.dart';




class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileImage = ref.watch(profileControllerProvider);
        print(profileImage.avatar);
        return Container(
          alignment: Alignment.bottomRight,
          width: 80.w,
          height: 80.h,
          decoration: profileImage.avatar == null
              ? BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20.w),
              image: const DecorationImage(
                  image: AssetImage(ImageRes.headPic)))
              : BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              image: DecorationImage(
                  image: NetworkImage(
                    "${AppConstants.IMAGE_UPLOADS_PATH}${profileImage.avatar}?t=${DateTime.now().millisecondsSinceEpoch}",
                  ),
              )),
          child: GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                File avatarFile = File(image.path);
                await ref.read(profileControllerProvider.notifier).updateAvatar(avatarFile);
              }
            },
            child: AppImage(
              width: 25.w,
              height: 25.h,
              imagePath: ImageRes.editImage,
            ),
          ),
        );
      },
    );
  }
}


class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        return Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Text13Normal(
              text: profileName.name != null ? "${profileName.name}" : ""),
        );
      },
    );
  }
}

class ProfileDescriptionWidget extends StatelessWidget {
  const ProfileDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          margin: EdgeInsets.only(top: 5.h, bottom: 10),
          child: Text13Normal(
            text: profileName.description != null
                ? "${profileName.description}"
                : "Xin chào tôi là ${profileName.name}",
            color: AppColors.primarySecondaryElementText,),
        );
      },
    );
  }
}
