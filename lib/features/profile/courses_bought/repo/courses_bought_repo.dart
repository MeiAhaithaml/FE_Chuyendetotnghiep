

import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/services/http_util.dart';

class CoursesBoughtRepo {
  static Future<CourseListResponseEntity> coursesBought() async {
    var response = await HttpUtil()
        .post("api/coursesBought");
    return CourseListResponseEntity.fromJson(response);
  }
}