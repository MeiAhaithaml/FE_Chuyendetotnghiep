
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
import '../../../common/models/course_entities.dart';
import '../repo/favorite_repo.dart';
part   'favorite_controller.g.dart';

@riverpod
class FavoriteController extends _$FavoriteController {
  @override
  FutureOr<List<CourseItem>?> build() async {
    return [];
  }

  Future<void> loadFavoriteCourses() async {
    state = const AsyncValue.loading();
    final response = await FavoriteCourseRepo.listFavoriteCourse();
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    } else {
      state = AsyncValue.error("Failed to load favorite courses", StackTrace.current);
      if (kDebugMode) {
        print("Failed to load favorite courses with code ${response.code}");
      }
    }
  }

  Future<void> addFavoriteCourse(int courseId) async {
    final response = await FavoriteCourseRepo.addFavoriteCourse(courseId);
    if (response.code == 200) {
      print("Added course to favorites.");
      await loadFavoriteCourses();
    } else {
      print("Failed to add favorite course: ${response.toString()}");
    }
  }

  Future<void> removeFavoriteCourse(int courseId) async {
    final response = await FavoriteCourseRepo.removeFavoriteCourse(courseId);
    if (response.code == 200) {
      print("Removed course from favorites.");
      await loadFavoriteCourses();
    } else {
      print("Failed to remove favorite course: ${response.toString()}");
    }
  }
}