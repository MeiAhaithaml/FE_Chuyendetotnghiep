import 'dart:io';
import 'package:dio/dio.dart';
import 'package:study_app/common/models/base_entities.dart';
import 'package:study_app/common/models/chat.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/services/http_util.dart';
import 'package:study_app/common/services/storage.dart';


class ChatAPI {

  static Future<BaseResponseEntity> bind_fcmtoken(
      {BindFcmTokenRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'api/bind_fcmtoken',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> call_notifications(
      {CallRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'api/send_notice',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> call_token(
      {CallTokenRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'api/get_rtc_token',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> send_message(
      {ChatRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'api/message',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> upload_img({File? file}) async {
    if (file == null) {
      throw Exception("File cannot be null");
    }

    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    try {
      StorageService storageService = StorageService();
      await storageService.init();
      String token = storageService.getUserToken();
      if (token.isEmpty) {
        throw Exception("Authorization token is missing.");
      }
      var response = await Dio().post(
        '${AppConstants.SERVER_API_URL}api/upload-photo',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Xử lý response
      return BaseResponseEntity.fromJson(response.data);
    } catch (e) {
      // Xử lý lỗi
      throw Exception("Error uploading file: $e");
    }
  }




  static Future<SyncMessageResponseEntity> sync_message(
      {SyncMessageRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'api/sync_message',
      queryParameters: params?.toJson(),
    );
    return SyncMessageResponseEntity.fromJson(response);
  }


}
