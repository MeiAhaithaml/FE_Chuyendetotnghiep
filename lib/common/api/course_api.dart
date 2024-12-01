import '../models/course_entities.dart';
import '../services/http_util.dart';

class CourseAPI{
  static Future<CourseListResponseEntity> courseList() async{
  var response=  await HttpUtil().post(
      'api/courseList'
    );
  return CourseListResponseEntity.fromJson(response);}}
class CourseMostFavoriteAPI{
  static Future<CourseListResponseEntity> courseMostFavoriteList() async{
  var response=  await HttpUtil().post(
      'api/coursesMostFavorite'
    );
  return CourseListResponseEntity.fromJson(response);}}
class CourseNewestAPI{
  static Future<CourseListResponseEntity> courseNewestList() async{
    var response=  await HttpUtil().post(
        'api/coursesNewest'
    );
    return CourseListResponseEntity.fromJson(response);}}