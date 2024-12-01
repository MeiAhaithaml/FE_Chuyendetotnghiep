import 'package:flutter/material.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/features/profile/widget/profile_courses.dart';
import 'package:study_app/features/profile/widget/profile_list_items.dart';
import 'package:study_app/features/profile/widget/profile_widgets.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.white,
      appBar:buildGlobalAppbar(title:"Profile"),
      body:Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg5.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
              child:SizedBox(
                  width:MediaQuery.of(context).size.width,
                  child:const Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children:[
                        ProfileImageWidget(),
                        ProfileNameWidget(),
                        ProfileDescriptionWidget(),
                        ProfileCourses(),
                        ProfileListItems()
                      ]
                  )
              )
          ),
        ],
      )
    );
  }
}
