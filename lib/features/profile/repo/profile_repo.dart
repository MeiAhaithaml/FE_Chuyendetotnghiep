import 'dart:io';
import 'package:dio/dio.dart';
import 'package:study_app/common/services/http_util.dart';

class ProfileRepo {
  static Future<void> updateAvatar(File avatar) async {
    try {
      var formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(avatar.path),
      });
      var response = await HttpUtil().post(
        "api/user/update-avatar",
        data: formData,
      );
      if (response['status'] != true) {
        throw Exception("Failed to update avatar: ${response['message']}");
      }
    } catch (e) {
      throw Exception("Error updating avatar: $e");
    }
  }
}
