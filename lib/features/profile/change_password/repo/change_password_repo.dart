import 'package:dio/dio.dart';
import 'package:study_app/common/models/user.dart';
import '../../../../common/services/http_util.dart';

class ChangePasswordRepo {
  static Future<UserLoginResponseEntity> changePassword({ChangeRequestEntity? params}) async {
    try {
      print("Sending request with params: ${params?.toJson()}");
      var response = await HttpUtil().post(
        "api/user/update",
        data: params?.toJson(),
      );
      print("Response: $response");
      return UserLoginResponseEntity.fromJson(response);
    } catch (e) {
      print("Error during request: $e");
      if (e is DioException) {
        print("Dio error: ${e.response?.data}");
        throw Exception("Error during password update: ${e.response?.data['message'] ?? 'Unknown error'}");
      } else {
        throw Exception("An unexpected error occurred: $e");
      }
    }
  }
}

