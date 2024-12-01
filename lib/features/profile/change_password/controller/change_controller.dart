import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_app/common/global_loader/global_loader.dart';
import 'package:study_app/common/models/user.dart';
import 'package:study_app/common/widgets/popup_messages.dart';
import 'package:study_app/features/application/view/application.dart';
import 'package:study_app/features/profile/change_password/provider/change_password_notifier.dart';
import 'package:study_app/features/profile/change_password/repo/change_password_repo.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/features/profile/controller/profile_controller.dart';


class ChangePasswordController {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> handleChange(BuildContext context, WidgetRef ref) async {
    print("handleChange called");

    var profileName = ref.read(profileControllerProvider);
    var state = ref.watch(changePasswordNotifierProvider);


    if (state.confirm.isEmpty) {
      toastInfo("Vui lòng xác nhận mật khẩu của bạn");
      return;
    }
    if (state.password.isEmpty) {
      toastInfo("Vui lòng nhập mật khẩu mới");
      return;
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      final credential = await ChangePasswordRepo.changePassword(
        params: ChangeRequestEntity(
          open_id: profileName.open_id,
          password: state.password,
          password_confirmation: state.confirm,
        ),
      );

      if (credential.code == 200) {
        toastInfo("Cập nhật mật khẩu thành công");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Application()),
              (route) => false,
        );
      } else {
        toastInfo("Có lỗi xảy ra: ${credential.msg}");
      }
    } catch (e) {
      toastInfo("Lỗi khi thay đổi mật khẩu: ${e.toString()}");
    } finally {
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }


}

