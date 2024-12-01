import 'package:flutter/material.dart';
import 'package:study_app/features/message/message_page.dart';
import 'package:study_app/features/profile/view/profile.dart';
import 'package:study_app/features/search/view/search.dart';
import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/image_res.dart';
import '../../../../common/widgets/images_widget.dart';
import '../../../favorite_page/view/favorite_page.dart';
import '../../home/view/home.dart';

var bottomAdminTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: ImageRes.message),
      activeIcon:_bottomContainer(imagePath: ImageRes.message,color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Message"),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: "assets/icons/person2.png"),
      activeIcon:_bottomContainer(imagePath: "assets/icons/person2.png",color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Profile"),

];

Widget _bottomContainer(
    {double width = 15,
      double height = 15,
      String imagePath =ImageRes.home,
      Color color = AppColors.primaryText}) {
  return SizedBox(
    width: 15,
    height: 15,
    child: appImageWithColor(
        imagePath: imagePath,
        color: color),
  );
}

Widget appScreens({int index=0}){
  List<Widget> screens=[
    const Message_Page(),
    const Profile(),
  ];
  return screens[index];
}


