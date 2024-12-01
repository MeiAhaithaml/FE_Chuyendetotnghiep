
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/features/search/repo/courses_search_repos.dart';


class CoursesSearchController extends AutoDisposeAsyncNotifier<List<CourseItem>?>{

  @override
  FutureOr<List<CourseItem>?> build() async {
    final response = await CoursesSearchRepos.coursesDefaultSearch();
    if(response.code==200){
      return response.data;
    }
    // TODO: implement build
    return [];
  }

  searchData (String search) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search  = search;
    var response = await CoursesSearchRepos.coursesSearch(params: searchRequestEntity);
    if(response.code==200){
      state = AsyncValue.data(response.data);

    }else{
      state = AsyncValue.data([]);
    }
  }

}


final coursesSearchControllerProvider =
AutoDisposeAsyncNotifierProvider<CoursesSearchController, List<CourseItem>?>(CoursesSearchController.new);
