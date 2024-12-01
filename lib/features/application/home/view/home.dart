import 'package:flutter/material.dart';
import 'package:study_app/common/widgets/search_widget.dart';
import 'package:study_app/features/application/home/controller/home_controller.dart';
import 'package:study_app/features/application/home/view/widgets/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController _controller;

  @override
  void didChangeDependencies() {
    _controller =
        PageController(initialPage: ref.watch(homeScreenBannerDotsProvider));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(ref),
      body: RefreshIndicator(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bghome.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const HelloText(),
                    const UserName(),
                    const SizedBox(height: 20),
                    AppSearchBar(searchFunc: (value) => print("Home page")),
                    const SizedBox(height: 20),
                    HomeBanner(ref: ref, controller: _controller),
                    menuClass(),
                  ],
                ),
              ),
            ),
          ],

        ),
        onRefresh: () {
          return ref.refresh(homeCourseListProvider.notifier).fetchCourseList();
        },
      ),
);
  }

  Widget menuClass() {
    return Container(
      height: 500,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Khoá học",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/allCourse');
                    },
                    child: const Text(
                      "Tất cả",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: Color(0xFF3933AF),
                borderRadius: BorderRadius.circular(7),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "Phổ biến"),
                Tab(text: "Yêu thích"),
                Tab(text: "Mới nhất"),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              child: TabBarView(
                children: [
                  Center(child: CourseGrid(ref: ref, watch: "homeCourseListProvider")),
                  Center(child: CourseGrid(ref: ref, watch: "homeMostFavoriteCourseListProvider")),
                  Center(child: CourseGrid(ref: ref, watch: "homeNewestCourseListProvider")),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
