import 'package:flutter/material.dart';
import 'package:study_app/features/message/message_page.dart';
import 'package:study_app/features/profile/view/profile.dart';
import 'package:study_app/features/search/view/search.dart';
import '../../../../common/utils/app_colors.dart';
import '../../../favorite_page/view/favorite_page.dart';
import '../../home/view/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/home.png",
          color: AppColors.primaryFourthElementText,
        )),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/home.png",
        color: AppColors.primaryElement,
      ),
    ),
    label: "home",
    backgroundColor: AppColors.primaryBackground,
  ),
  BottomNavigationBarItem(
    icon: SizedBox(
        width: 15.w,
        height: 15.w,
        child: Image.asset(
          "assets/icons/search2.png",
          color: AppColors.primaryFourthElementText,
        )),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/search2.png",
        color: AppColors.primaryElement,
      ),
    ),
    label: "search",
    backgroundColor: AppColors.primaryBackground,
  ),
  BottomNavigationBarItem(
    icon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/heart.png",
        color: AppColors.primaryFourthElementText,
      ),
    ),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/heart.png",
        color: AppColors.primaryElement,
      ),
    ),
    label: "play",
    backgroundColor: AppColors.primaryBackground,
  ),
  BottomNavigationBarItem(
    icon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/message-circle.png",
        color: AppColors.primaryFourthElementText,
      ),
    ),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/message-circle.png",
        color: AppColors.primaryElement,
      ),
    ),
    label: "message",
    backgroundColor: AppColors.primaryBackground,
  ),
  BottomNavigationBarItem(
    icon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/person2.png",
        color: AppColors.primaryFourthElementText,
      ),
    ),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.w,
      child: Image.asset(
        "assets/icons/person2.png",
        color: AppColors.primaryElement,
      ),
    ),
    label: "person",
    backgroundColor: AppColors.primaryBackground,
  ),
];


Widget appScreens({int index=0}){
  List<Widget> screens=[
    const Home(),
    const Search(),
    const FavoritePage(),
    const Message_Page(),
    const Profile(),
  ];
  return screens[index];
}


