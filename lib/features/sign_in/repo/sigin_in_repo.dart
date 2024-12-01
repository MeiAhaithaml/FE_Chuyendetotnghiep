import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/models/user.dart';
import '../../../common/services/http_util.dart';

class SignInRepo{

  static Future<UserCredential> firebaseSignIn(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
    return credential;
  }
  static Future<UserLoginResponseEntity> login({LoginRequestEntity? params}) async {
    try {
      var response = await HttpUtil().post(
          "api/login",
          data: params?.toJson()
      );
      return UserLoginResponseEntity.fromJson(response);
    } catch (e) {
      if (e is DioException) {
        print("Dio error: ${e.response?.data}");
        throw Exception("Error during login: ${e.response?.data['message'] ?? 'Unknown error'}");
      } else {
        throw Exception("An unexpected error occurred: $e");
      }
    }
  }

}

