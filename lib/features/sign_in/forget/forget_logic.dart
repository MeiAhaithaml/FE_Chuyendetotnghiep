import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/common/widgets/popup_messages.dart';
import 'package:study_app/features/sign_in/forget/notifiers/forget_notifier.dart';

class ForgetLogic {
  final WidgetRef ref;

  ForgetLogic({
    required this.ref,
  });

  handleEmailForgot() async {
    final state = ref.read(ForgetProvider);
    String emailAddress = state.email;
    if (emailAddress.isEmpty) {
      toastInfo("Email không được để trống!");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      toastInfo(
        "Một email đã được gửi đến địa chỉ email của bạn. Vui lòng mở liên kết trong email để đặt lại mật khẩu.",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Mật khẩu được cung cấp quá yếu.');
        toastInfo("Mật khẩu được cung cấp quá yếu.");
      } else if (e.code == 'email-already-in-use') {
          print('Tài khoản đã tồn tại với email này.');
        toastInfo("Tài khoản đã tồn tại với email này.");
      }
    } catch (e) {
      print(e);
    }
  }
}
