import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_app/common/global_loader/global_loader.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/user.dart';
import 'package:study_app/common/widgets/popup_messages.dart';
import 'package:study_app/features/sign_in/sign_admin/repo/sign_admin_repo.dart';
import 'package:study_app/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/main.dart';

class SignAdminController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignAdmin(WidgetRef ref) async {
    String username = userNameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty) {
      toastInfo("Vui lòng nhập tên đăng nhập");
      return;
    }
    if (password.isEmpty) {
      toastInfo("Vui lòng nhập mật khẩu của bạn");
      return;
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      final response = await SignAdminRepo.login(
        username: username,
        password: password,
      );

      // Check if response has a code indicating success (200)
      if (response["code"] == 200) {
        String accessToken = response["data"]["token"]; // Access the token inside the 'data' field

        // Save token into storage
        Global.storageService.setString(
          AppConstants.STORAGE_USER_TOKEN_KEY,
          accessToken,
        );

        // Save user profile (if available)
        UserProfile userProfile = UserProfile(
          access_token: accessToken,
          token: accessToken,
          name: response["data"]["name"],
          description: response["data"]["description"],
          avatar: response["data"]["avatar"],

        );

        Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY,
          jsonEncode(userProfile.toJson()),
        );

        // Navigate to the admin application page
        navKey.currentState?.pushNamedAndRemoveUntil("/admin_application", (route) => false);

        toastInfo("Đăng nhập thành công");
      } else {
        // If the response code is not 200, display the error message
        toastInfo(response["msg"] ?? "Đăng nhập thất bại");
      }
    } catch (e) {
      print("Error: $e");
      toastInfo(e.toString());
    } finally {
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }

}
