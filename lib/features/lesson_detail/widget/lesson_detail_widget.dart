import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_shadow.dart';
import 'package:study_app/common/widgets/images_widget.dart';
import 'package:study_app/common/widgets/text_widgets.dart';
import 'package:study_app/features/lesson_detail/controller/lesson_controller.dart';

import '../../../common/models/contants.dart';
import '../../../common/models/lesson_entities.dart';

class LessonVideos extends StatelessWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function(int index) syncVideoIndex;

  const LessonVideos({
    Key? key,
    required this.lessonData,
    required this.ref,
    required this.syncVideoIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lessonData.length,
        itemBuilder: (_, index){
          return Container(
            margin: EdgeInsets.only(top:10.h,left: 8,right: 8),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            width: 325.w,
            height: 80.h,
            decoration: appBoxShadow(
                radius: 10,
                sR: 2,
                bR: 3,
                color: const Color.fromRGBO(255, 255, 255, 1)

            ),
            child: InkWell(
              onTap: (){
                syncVideoIndex(index);
                var vidUrl = lessonData[index].url;
                ref.read(lessonDataControllerProvider.notifier).playNextVid(vidUrl!);
              },
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBoxDecorationImage(
                    width: 60.w,
                    height: 60.w,
                    imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${lessonData[index].thumbnail}",
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text13Normal(text: lessonData[index].name),
                      ],
                    ),
                  ),
                  // Expanded(child:Container()),
                  const AppImage(imagePath: ImageRes.arrowRight,width: 24, height: 24,)
                ],
              ),
            ),
          );
        });
  }
}
class LessonVideosLand extends StatelessWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function(int index) syncVideoIndex;

  const LessonVideosLand({
    Key? key,
    required this.lessonData,
    required this.ref,
    required this.syncVideoIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lessonData.length,
        itemBuilder: (_, index){
          return Container(
            margin: EdgeInsets.only(top:10.h,left: 4,right: 4,bottom: 4),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            width: 325.w,
            height: 80.h,
            decoration: appBoxShadow(
                radius: 10,
                sR: 2,
                bR: 3,
                color: const Color.fromRGBO(255, 255, 255, 1)

            ),
            child: InkWell(
              onTap: (){
                syncVideoIndex(index);
                var vidUrl = lessonData[index].url;
                ref.read(lessonDataControllerProvider.notifier).playNextVid(vidUrl!);
              },
              child: Row(
                children: [
                  AppBoxDecoration(
                    width: 40.w,
                    height: 40.w,
                    imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${lessonData[index].thumbnail}",
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text10Normal(text: "${lessonData[index].name}"),
                      ],
                    ),
                  ),
                  // Expanded(child:Container()),
                  const AppImage(imagePath: ImageRes.arrowRight,width: 24, height: 24,)
                ],
              ),
            ),
          );
        });
  }
}
