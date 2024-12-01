import 'package:flutter/material.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/routes/app_routes_names.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/widgets/text_widgets.dart';

class CourseTileWidgets extends StatelessWidget {
  final List<CourseItem> value;
  const CourseTileWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,right: 8,left: 8),
      child: ListView(
        children: [
          for(final val in value)
            Container(
              width: 325,
              height: 80,
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 1))
                  ]),
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoutesNames.COURSE_DETAIL,
                    arguments: {"id": val.id}),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: NetworkImage(
                                      "${AppConstants.IMAGE_UPLOADS_PATH}${val.thumbnail}"))),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              width: 180,
                              child: Text14Normal(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                text: val
                                    .name
                                    .toString(),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              width: 180,
                              child: Text10Normal(
                                color:
                                AppColors.primaryThirdElementText,
                                text:
                                "${val.lesson_num} Lesson",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 55,
                      child: Text14Normal(
                        text: "\$${val.price}",
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class CourseSearchWidgets extends StatelessWidget {
  final List<CourseItem> value;
  const CourseSearchWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Các phần tử khác (nếu có)
          ListView(
            shrinkWrap: true, // Giới hạn chiều cao của ListView trong parent
            physics: const NeverScrollableScrollPhysics(), // Tắt cuộn bên trong
            children: [
              for (final val in value)
                Container(
                  width: 325,
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 1))
                      ]),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        AppRoutesNames.COURSE_DETAIL,
                        arguments: {"id": val.id}),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                          "${AppConstants.IMAGE_UPLOADS_PATH}${val.thumbnail}"))),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  width: 170,
                                  child: Text14Normal(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    text: val.name.toString(),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  width: 170,
                                  child: Text10Normal(
                                    color:
                                    AppColors.primaryThirdElementText,
                                    text: "${val.lesson_num} Lesson",
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 50,
                          child: Text14Normal(
                            text: "\$${val.price}",
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );

  }
}