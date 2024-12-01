import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/common/api/course_api.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/models/user.dart';

import '../../../../global.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() => 0;

  void setIndex(int value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class HomeUserProfile extends _$HomeUserProfile {
  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

// Extend AsyncNotifier instead of Notifier
@Riverpod(keepAlive: true)
class HomeCourseList extends AsyncNotifier<List<CourseItem>?> {
  // Method to fetch the list of courses asynchronously
  Future<List<CourseItem>?> fetchCourseList() async {
    var result = await CourseAPI.courseList();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  // Override the build method with async logic
  @override
  Future<List<CourseItem>?> build() async {
    return fetchCourseList();
  }
}

@Riverpod(keepAlive: true)
class HomeMostFavoriteCourseList extends _$HomeMostFavoriteCourseList {
  Future<List<CourseItem>?> fetchMostFavoriteCourseList() async {
    var result = await CourseMostFavoriteAPI.courseMostFavoriteList();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchMostFavoriteCourseList();
  }
}

@Riverpod(keepAlive: true)
class HomeNewestCourseList extends _$HomeNewestCourseList {
  Future<List<CourseItem>?> fetchNewestCourseList() async {
    var result = await CourseNewestAPI.courseNewestList();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchNewestCourseList();
  }
}
