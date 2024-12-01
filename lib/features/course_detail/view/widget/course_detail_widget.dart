import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_shadow.dart';
import 'package:study_app/common/widgets/images_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/features/profile/courses_bought/repo/courses_bought_repo.dart';
import '../../../../common/models/lesson_entities.dart';
import '../../../../common/routes/app_routes_names.dart';
import '../../../../common/widgets/button_widgets.dart';
import '../../../../common/widgets/text_widgets.dart';
import '../../../favorite_page/controller/favorite_controller.dart';
import '../../../lesson_detail/controller/lesson_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseDetailThumbnail extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailThumbnail({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppBoxDecorationImage(
        imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${courseItem.thumbnail}",
        width: 325.w,
        height: 80.h,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class CourseDetailIConText extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIConText({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: 325.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("token : ${courseItem.token}");
              print("id : ${courseItem.id}");
              Navigator.of(context).pushNamed(AppRoutesNames.AUTHOR_PAGE,
                  arguments: {"token": courseItem.token});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: appBoxShadow(radius: 7),
              child: const Text13Normal(
                text: "Tác giả",
                color: AppColors.primaryElementText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(
              children: [
                const AppImage(imagePath: ImageRes.people),
                Text13Normal(
                  text: courseItem.follow == 0 ? "0"
                      : "${courseItem.follow}",
                  color: AppColors.primaryThirdElementText,
                  fontWeight: FontWeight.normal,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(
              children: [
                const AppImage(
                  imagePath: ImageRes.star, width: 16, height: 16,),
                Text13Normal(
                  text: courseItem.score == null
                      ? "0"
                      : courseItem.score.toString(),
                  color: AppColors.primaryThirdElementText,
                  fontWeight: FontWeight.normal,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CourseDetailDescription extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailDescription({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text16Normal(
            text: courseItem.name == null ? "No name found" : courseItem.name!,
            color: Colors.black,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 4.h,),
          Text14Normal(
            text: courseItem.description ?? "No description found",
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

// Hàm lưu trạng thái yêu thích vào SharedPreferences
Future<void> saveFavoriteStatus(int courseId, bool isFavorite) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('favorite_$courseId', isFavorite);
}


Future<bool> loadFavoriteStatus(int courseId) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('favorite_$courseId') ?? false;
}

class CourseDetailGoBuyButton extends ConsumerStatefulWidget {
  final CourseItem courseItem;

  const CourseDetailGoBuyButton({Key? key, required this.courseItem}) : super(key: key);

  @override
  _CourseDetailGoBuyButtonState createState() => _CourseDetailGoBuyButtonState();
}

class _CourseDetailGoBuyButtonState extends ConsumerState<CourseDetailGoBuyButton> {
  bool isFavorite = false;
  bool isPurchased = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _checkPurchaseStatus();
  }


  Future<void> _loadFavoriteStatus() async {
    final favoriteStatus = await loadFavoriteStatus(widget.courseItem.id!);
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  Future<void> _checkPurchaseStatus() async {
    try {
      final courseListResponse = await CoursesBoughtRepo.coursesBought();
      setState(() {
        isPurchased = courseListResponse.data != null &&
            courseListResponse.data!.any((course) => course.id == widget.courseItem.id);
      });
    } catch (e) {
      print("Error calling coursesBought API: $e");
      setState(() {
        isPurchased = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: isPurchased
              ? null
              : () {

            Navigator.of(context).pushNamed("/buy_course", arguments: {"id": widget.courseItem.id});
          },
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
            child: AppButton(
              buttonName: isPurchased ? "Đã mua" : "Mua khoá học", // Change button name
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: IconButton(
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });

              await saveFavoriteStatus(widget.courseItem.id!, isFavorite);

              final favoriteController = ref.read(favoriteControllerProvider.notifier);
              if (isFavorite) {
                print("Added to favorites");
                await favoriteController.addFavoriteCourse(widget.courseItem.id!);
              } else {
                print("Removed from favorites");
                await favoriteController.removeFavoriteCourse(widget.courseItem.id!);
              }
            },
            icon: Icon(
              isFavorite ? Icons.bookmark : Icons.bookmark_border_outlined,
              color: Colors.redAccent,
              size: 45,
            ),
          ),
        ),
      ],
    );
  }
}



class CourseDetailIncludes extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIncludes({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text16Normal(
            text: "Khoá học bao gồm",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 12.w,
          ),
          CourseInfo(
            imagePath: ImageRes.videoDetail,
            length: courseItem.video_len,
            infoText: "Giờ",
          ),
          SizedBox(
            height: 16.w,
          ),
          CourseInfo(
            imagePath: ImageRes.fileDetail,
            length: courseItem.lesson_num,
            infoText: "Số lượng file",
          ),
          SizedBox(
            height: 16.w,
          ),
          CourseInfo(
            imagePath: ImageRes.downloadDetail,
            length: courseItem.down_num,
            infoText: "Số lượng để download",
          ),
        ],
      ),
    );
  }
}

class CourseInfo extends StatelessWidget {
  final String imagePath;
  final int? length;
  final String? infoText;

  const CourseInfo(
      {super.key, required this.imagePath, this.length, this.infoText = "item"});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: AppImage(
            imagePath: imagePath,
            width: 30,
            height: 30,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: Text13Normal(
            color: AppColors.primarySecondaryElementText,
            text: length == null ? "0 $infoText" : "$length $infoText",
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}

class LessonInfo extends StatelessWidget {
  final List<LessonItem> lessonData;
  final WidgetRef ref;

  const LessonInfo({super.key, required this.lessonData, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lessonData.isNotEmpty ? const Text16Normal(
            text: "Danh sách bài giảng",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ) : const Text16Normal(
            text: "Danh sách bài giảng trống",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,),
          SizedBox(height: 10.h,),
          ListView.builder(
              shrinkWrap: true,
              itemCount: lessonData.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    print(lessonData[index].id!);
                    ref.watch(lessonDetailControllerProvider(
                        index: lessonData[index].id!));
                    Navigator.of(context).pushNamed(
                        "/lesson_detail", arguments: {
                      "id": lessonData[index].id!
                    }
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoderDecorationImage(
                          width: 80.w,
                          height: 80.w,
                          imagePath: "${AppConstants
                              .IMAGE_UPLOADS_PATH}${lessonData[index]
                              .thumbnail}",
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(width: 8,),
                        Container(
                          width: 240,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text16Normal(text: lessonData[index].name,
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,),
                              Text13Normal(text: lessonData[index].description!,
                                maxLines: 2,
                                color: AppColors.primaryThirdElementText,
                                fontWeight: FontWeight.normal,),
                            ],
                          ),
                        ),
                        Container(
                            child: const AppImage(
                              imagePath: ImageRes.arrowRight,
                              width: 16,
                              height: 16,))
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

