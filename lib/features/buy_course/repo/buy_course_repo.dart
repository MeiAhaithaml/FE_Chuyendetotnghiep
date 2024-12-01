

import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/services/http_util.dart';

import '../../../common/models/base_entities.dart';

class BuyCourseRepo {
  static Future<BaseResponseEntity> buyCourse(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil()
        .post("api/checkout", queryParameters: params?.toJson());
    return BaseResponseEntity.fromJson(response);
  }

}