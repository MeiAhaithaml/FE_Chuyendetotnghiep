import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/contants.dart';
import '../../../common/models/course_entities.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/image_res.dart';
import '../../../common/widgets/app_shadow.dart';
import '../../../common/widgets/images_widget.dart';
import '../../../common/widgets/text_widgets.dart';


class AuthorMenu extends StatelessWidget {
  const AuthorMenu({super.key, required this.authorInfo});

  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  MediaQuery.of(context).size.width,
      height: 220.h,
      child: Stack(
        children: [
          Container(
            width:  MediaQuery.of(context).size.width,
            height: 160.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.h),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      ImageRes.background,
                    ))),
          ),
          Positioned(
              bottom: 0,
              left: 16,
              child: Container(
                width: 325.w,
                child: Row(
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.w),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${AppConstants.IMAGE_UPLOADS_PATH}${authorInfo.avatar}"))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 6.w),
                            child: Text14Normal(
                              text: '${authorInfo.name}',fontWeight: FontWeight.bold,color: Colors.black,
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 6.w),
                            child: Text11Normal(
                              text: authorInfo.job ?? "Giáo viên",color: AppColors.primaryThirdElementText,
                            )),
                        SizedBox(
                          height: 5.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AuthorTextAndIcon(
                                text: "10", icon: ImageRes.people, first: true),
                            AuthorTextAndIcon(
                                text: "90", icon: ImageRes.star, first: false),
                            AuthorTextAndIcon(
                                text: "12",
                                icon: ImageRes.downloadDetail,
                                first: false)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class AuthorTextAndIcon extends StatelessWidget {
  const AuthorTextAndIcon(
      {super.key, required this.text, required this.icon, required this.first});

  final String text;
  final String icon;
  final bool first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: first == true ? 3.w : 20.w),
      child: Row(
        children: [
          AppImage(imagePath: icon),
          Text11Normal(
            text: text,
            color: AppColors.primaryThirdElementText,
          )
        ],
      ),
    );
  }
}

class AuthorDescription extends StatelessWidget {
  const AuthorDescription({super.key, required this.authorInfo});

  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text16Normal(
            text: "Mô tả",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text14Normal(
              text: authorInfo.description ??
                  "Tôi thích khám phá thiên nhiên, con người",
              color: AppColors.primaryThirdElementText,
            ),
          )
        ],
      ),
    );
  }
}
class CourseAuthorList extends StatelessWidget {
  final List<CourseItem> courseData;
  const CourseAuthorList({super.key, required this.courseData, });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8.0,bottom: 8),
      child: Container(
        margin: const EdgeInsets.only(top: 20,bottom: 10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            courseData.isNotEmpty?const Text16Normal(
              text: "Danh sách khoá học",
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ):const  Text16Normal(
              text: "Bài giảng trống",
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,),
            SizedBox(height: 10.h,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: courseData.length,
                itemBuilder: (_, index){
                  return InkWell(
                    onTap: (){
                      print(courseData[index].id!);
                      Navigator.of(context).pushNamed("/course_detail", arguments: {
                        "id":courseData[index].id!
                      }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4,right: 4),
                      child: Container(
                        color: Color(0xFFE8EAF6),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BoderDecorationImage(
                                width: 80.w,
                                height: 80.w,
                                imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${courseData[index].thumbnail}",
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(width: 8,),
                              Container(
                                width: 240,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text16Normal(text: courseData[index].name,color: AppColors.primaryText,fontWeight: FontWeight.bold,),
                                    Text13Normal(text: " Khoá học với ${courseData[index].lesson_num} bài giảng",maxLines: 2,color: AppColors.primaryThirdElementText,fontWeight: FontWeight.normal,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                })
          ],
        ),
      ),
    );
  }
}