import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/services/http_util.dart';

import '../../../common/models/lesson_entities.dart';

class CourseDetailRepo {
  static Future<CourseDetailResponseEntity> courseDetail({
    CourseRequestEntity? params
  }) async {
    var response = await HttpUtil().post("api/courseDetail",queryParameters: params?.toJson());
  return  CourseDetailResponseEntity.fromJson(response);
  }

  static Future<LessonListResponseEntity> courseLessonList(
      {LessonRequestEntity? params}) async {
    var response = await HttpUtil()
        .post("api/lessonList", queryParameters: params?.toJson());
    return LessonListResponseEntity.fromJson(response);
  }
}