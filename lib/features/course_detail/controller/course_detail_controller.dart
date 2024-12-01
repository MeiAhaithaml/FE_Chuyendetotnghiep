import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/features/course_detail/repo/course_detail_repo.dart';

import '../../../common/models/lesson_entities.dart';
part 'course_detail_controller.g.dart';

@riverpod
Future<CourseItem?> courseDetailController(CourseDetailControllerRef ref,{required int index}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final response = await CourseDetailRepo.courseDetail(params: courseRequestEntity);
  if (response.code == 200) {
    return response.data;
  } else {
    print('request failed ${response.code}');
  }
  return null;
}
@riverpod
Future<List<LessonItem>?> courseLessonListController(
    CourseLessonListControllerRef ref, {required int index}) async {

  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response =
  await CourseDetailRepo.courseLessonList(params: lessonRequestEntity);
  if (response.code == 200) {
    return response.data;
  } else {
    print('request failed ${response.code}');
  }
  return null;
}
