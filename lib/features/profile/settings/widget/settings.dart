import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/routes/app_routes_names.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_bar.dart';

import '../../../../common/models/contants.dart';
import '../../../../global.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGlobalAppbar(title: "Cài đặt"),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Xác nhận"),
                    content: const Text("Bạn có muốn đăng xuất không?"),
                    actions: [
                      TextButton(
                        child: const Text("Huỷ"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Đồng ý"),
                        onPressed: () {
                          Global.storageService
                              .remove(AppConstants.STORAGE_USER_PROFILE_KEY);
                          Global.storageService
                              .remove(AppConstants.STORAGE_USER_TOKEN_KEY);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutesNames.SIGN_IN, (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  );
                });
          },
          child: Container(
            height: 100.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageRes.logOut), fit: BoxFit.fitHeight)),
          ),
        ),
      ),
    );
  }
}
