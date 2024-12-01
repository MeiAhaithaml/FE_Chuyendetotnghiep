import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/lesson_entities.dart';
import 'package:study_app/common/widgets/app_shadow.dart';
import 'package:study_app/features/lesson_detail/controller/lesson_controller.dart';
import 'package:study_app/features/lesson_detail/widget/lesson_detail_widget.dart';
import 'package:video_player/video_player.dart';


class LessonDetail extends ConsumerStatefulWidget {
  const LessonDetail({super.key});

  @override
  ConsumerState<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends ConsumerState<LessonDetail> {
  late var args;
  int videoIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lessonData = ref.watch(lessonDataControllerProvider);

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: isLandscape
          ? null
          : AppBar(
        title: const Text("Khoá học"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg7.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: lessonData.value == null
                ? Column(
              children: const [
                Text("Không có video"),
              ],
            )
                : lessonData.when(
              data: (data) {
                return isLandscape
                    ? _buildLandscapeLayout(context, data)
                    : _buildPortraitLayout(context, data);
              },
              error: (e, t) => const Text("Lỗi"),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, LessonVideo data) {
    return Column(
      children: [
        // Video Player Container
        Container(
          width: 325.w,
          height: 200.h,
          child: Stack(
            children: [
              FutureBuilder(
                future: data.initializeVideoPlayer,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTap: () {
                        if (videoPlayerController!.value.isPlaying) {
                          videoPlayerController?.pause();
                        } else {
                          videoPlayerController?.play();
                        }
                      },
                      child: VideoPlayer(videoPlayerController!),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                  },
                  child: const Icon(Icons.fullscreen, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          height: 400,
          child: LessonVideos(
            lessonData: data.lessonItem,
            ref: ref,
            syncVideoIndex: (index) {
              setState(() {
                videoIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, LessonVideo data) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              FutureBuilder(
                future: data.initializeVideoPlayer,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTap: () {
                        if (videoPlayerController!.value.isPlaying) {
                          videoPlayerController?.pause();
                        } else {
                          videoPlayerController?.play();
                        }
                      },
                      child: VideoPlayer(videoPlayerController!),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    print("exit");
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                  },
                  child: const Icon(Icons.fullscreen_exit, color: Colors.red, size: 40),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  videoPlayerController!,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: LessonVideosLand(
            lessonData: data.lessonItem,
            ref: ref,
            syncVideoIndex: (index) {
              setState(() {
                videoIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
