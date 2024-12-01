import 'package:study_app/common/services/http_util.dart';

import '../../../common/models/lesson_entities.dart';

class LessonRepo {

  static Future<LessonDetailResponseEntity> courseLessonDetail(
      {LessonRequestEntity? params}) async {
    var response = await HttpUtil()
        .post("api/lessonDetail", queryParameters: params?.toJson());
    return LessonDetailResponseEntity.fromJson(response);
  }

}