import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/common/widgets/app_shadow.dart';
import 'package:study_app/common/widgets/images_widget.dart';
import 'package:study_app/features/application/home/controller/home_controller.dart';
import 'package:study_app/features/course_detail/view/course_detail.dart';
import '../../../../../common/widgets/text_widgets.dart';
import '../../../../../global.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
          text: Global.storageService.getUserProfile().name!,
          fontWeight: FontWeight.bold),
    );
  }
}

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
          text: "Xin chào,",
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold),
    );
  }
}

class HomeBanner extends StatelessWidget {
  final PageController controller;
  final WidgetRef ref;

  const HomeBanner({super.key, required this.ref, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 325,
          height: 160,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              print(index);
              ref.read(homeScreenBannerDotsProvider.notifier).setIndex(index);
            },
            children: [
              bannerContainer(imagePath: ImageRes.banner1),
              bannerContainer(imagePath: ImageRes.banner2),
              bannerContainer(imagePath: ImageRes.banner3),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        //dots
        DotsIndicator(
          position: ref.watch(homeScreenBannerDotsProvider),
          dotsCount: 3,
          mainAxisAlignment: MainAxisAlignment.center,
          decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(24.0, 8.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        ),
      ],
    );
  }
}

Widget bannerContainer({required String imagePath}) {
  return Container(
    width: 325,
    height: 160,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
  );
}

AppBar homeAppBar(WidgetRef ref) {
  var profileState = ref.watch(homeUserProfileProvider);
  return AppBar(
    title: Container(
      margin: const EdgeInsets.only(left: 7, right: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppImage(imagePath: ImageRes.menu, width: 18, height: 12),

        ],
      ),
    ),
  );
}

class CourseGrid extends StatelessWidget {
  final WidgetRef ref;
  final String watch;
  const CourseGrid({super.key, required this.ref, required this.watch});

  @override
  Widget build(BuildContext context) {
    final courseState = _getProvider(ref, watch);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 18),
      child: courseState.when(
        data: (data) {
          final limitedData = data?.take(6).toList();
          return GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 8,
              childAspectRatio: 0.6,
            ),
            itemCount: limitedData?.length ?? 0,
            itemBuilder: (_, int index) {
              return SizedBox(
                height: 160,
                width: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBoxDecorationImage(
                      imagePath:
                      "${AppConstants.IMAGE_UPLOADS_PATH}${limitedData![index].thumbnail!}",
                      fit: BoxFit.cover,
                      width: 160,
                      height: 180,
                      courseItem: limitedData[index],
                      func: () {
                        Navigator.of(context).pushNamed(
                          "/course_detail",
                          arguments: {"id": limitedData[index].id!},
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: FadeText(
                            text: limitedData[index].name!,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 0),
                          child: FadeText(
                            text: "${limitedData[index].lesson_num!} bài học",
                            color: AppColors.primarySecondaryElementText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          print(error.toString());
          print(stackTrace.toString());
          return const Center(
            child: Text("Lỗi"),
          );
        },
        loading: () => const Center(
          child: Text("Loading..."),
        ),
      ),
    );
  }
  }
  // Phương thức trả về provider tương ứng với giá trị `watch`
  AsyncValue<List<CourseItem>?> _getProvider(WidgetRef ref, String watch) {
    switch (watch) {
      case "homeCourseListProvider":
        return ref.watch(homeCourseListProvider);
      case "homeMostFavoriteCourseListProvider":
        return ref.watch(homeMostFavoriteCourseListProvider);
      case "homeNewestCourseListProvider":
        return ref.watch(homeNewestCourseListProvider);
      default:
        throw Exception("Unknown provider: $watch");
    }
  }
