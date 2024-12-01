import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/common/models/user.dart';
import 'package:study_app/common/services/http_util.dart';


class SignAdminRepo {
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await HttpUtil().post(
        "api/admin/login",
        data: {
          "username": username,
          "password": password,
        },
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      if (e is DioException) {
        print("Dio error: ${e.response?.data}");
        final errorMessage =
            e.response?.data['error'] ?? "Unknown error occurred";
        throw Exception(errorMessage);
      } else {
        throw Exception("An unexpected error occurred: $e");
      }
    }
  }
}


