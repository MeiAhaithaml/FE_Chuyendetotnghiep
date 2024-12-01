
import '../../../common/models/course_entities.dart';
import '../../../common/services/http_util.dart';


class FavoriteCourseRepo {
  static Future<CourseListResponseEntity> listFavoriteCourse() async{
    var response = await HttpUtil()
        .post("api/coursesFavorite");
    return CourseListResponseEntity.fromJson(response);
  }
  static Future<CourseRequestEntity> addFavoriteCourse(int courseId) async{
    var response = await HttpUtil()
        .post("api/favorites/add",  data: {"course_id": courseId});
    return CourseRequestEntity.fromJson(response);
  }
  static Future<CourseRequestEntity> removeFavoriteCourse(int courseId) async {
    var response = await HttpUtil().post("api/favorites/remove", data: {"course_id": courseId});
    return CourseRequestEntity.fromJson(response);
  }
}