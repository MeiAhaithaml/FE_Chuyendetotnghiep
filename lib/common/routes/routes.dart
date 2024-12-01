import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_app/features/application/home/view/allCourse_page.dart';
import 'package:study_app/features/application/view/admin_app/admin_application.dart';
import 'package:study_app/features/course_detail/view/course_detail.dart';
import 'package:study_app/features/favorite_page/view/favorite_page.dart';
import 'package:study_app/features/lesson_detail/view/lesson_detail.dart';
import 'package:study_app/features/message/message_page.dart';
import 'package:study_app/features/message/photoview/photoview.dart';
import 'package:study_app/features/profile/change_password/change_password.dart';
import 'package:study_app/features/sign_in/forget/forget.dart';
import 'package:study_app/features/sign_in/sign_admin/view/sign_admin.dart';
import '../../features/application/home/view/home.dart';
import '../../features/application/view/application.dart';

import '../../features/author_page/view/author_page.dart';
import '../../features/buy_course/view/buy_course.dart';
import '../../features/message/chat/chat.dart';
import '../../features/profile/courses_bought/view/courses_bought.dart';
import '../../features/profile/settings/widget/settings.dart';
import '../../features/sign_in/view/sign_in.dart';
import '../../features/sign_up/view/sign_up.dart';
import '../../features/welcome/view/welcome.dart';
import '../../global.dart';
import 'app_routes_names.dart';

class AppPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path:AppRoutesNames.WELCOME, page:Welcome()),
      RouteEntity(path: AppRoutesNames.SIGN_IN, page: const SignIn()),
      RouteEntity(path: AppRoutesNames.REGISTER, page: const SignUp()),
      RouteEntity(path: AppRoutesNames.APPLICATION, page: const Application()),
      RouteEntity(path: AppRoutesNames.HOME, page: const Home()),
      RouteEntity(path: AppRoutesNames.COURSE_DETAIL, page: const CourseDetail()),
      RouteEntity(path: AppRoutesNames.LESSON_DETAIL, page: const LessonDetail()),
      RouteEntity(path: AppRoutesNames.BUY_COURSE, page: const BuyCourse()),
      RouteEntity(path: AppRoutesNames.SETTINGS, page: const Settings()),
      RouteEntity(path: AppRoutesNames.COURSES_BOUGHT, page: const CoursesBought()),
      RouteEntity(path: AppRoutesNames.AUTHOR_PAGE, page: const AuthorPage()),
      RouteEntity(path: AppRoutesNames.CHAT_PAGE, page: const Chat()),
      RouteEntity(path: AppRoutesNames.MESSAGE, page: const Message_Page()),
      RouteEntity(path: AppRoutesNames.PHOTO, page: const PhotoView()),
      RouteEntity(path: AppRoutesNames.SIGN_IN_ADMIN, page: const SignInAdmin()),
      RouteEntity(path: AppRoutesNames.All_COURSES, page: const AllCoursePage()),
      RouteEntity(path: AppRoutesNames.ADMIN_APPLIACTION, page: const AdminApplication()),
      RouteEntity(path: AppRoutesNames.CHANGE_PASSWORD, page: const ChangePassword()),
      RouteEntity(path: AppRoutesNames.FAVORITE, page: const FavoritePage()),
      RouteEntity(path: AppRoutesNames.FORGET, page: const ForgetPage()),


    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      //print("clicked route is ${settings.name}");
    }
    if(settings.name!=null){

      var result = routes().where((element) => element.path==settings.name);

      if(result.isNotEmpty){
        //if we used this is first time  or not
        bool deviceFirstTime= Global.storageService.getDeviceFirstOpen();

        if(result.first.path==AppRoutesNames.WELCOME&&deviceFirstTime){

          bool isLoggedIn = Global.storageService.isLoggedIn();
          if(isLoggedIn){
            return MaterialPageRoute(
                builder: (_) => const Application(),
                settings: settings);
          }else{
            return MaterialPageRoute(
                builder: (_) => const SignIn(),
                settings: settings);
          }

        }else{
          if (kDebugMode) {
           // print('App ran first time');
          }
          return MaterialPageRoute(
              builder: (_) => result.first.page,
              settings: settings);
        }
      }
    }
    return MaterialPageRoute(
        builder: (_) => Welcome(),
        settings: settings);
  }
}

class RouteEntity{
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}
