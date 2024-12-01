import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/lesson_entities.dart';
import 'package:study_app/features/lesson_detail/repo/lesson_repo.dart';


import 'package:video_player/video_player.dart';

part 'lesson_controller.g.dart';

VideoPlayerController? videoPlayerController;

@riverpod
Future<void> lessonDetailController(LessonDetailControllerRef ref,
    {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response = await LessonRepo.courseLessonDetail(params: lessonRequestEntity);
  print("Response từ API: ${response.data}");
  if (response.code == 200) {
    var url =
        "${AppConstants.SERVER_API_URL}${response.data!.elementAt(0).url}";
    videoPlayerController = VideoPlayerController.network(url);
    print("URL video từ API: $url");
    var initializeVideoPlayerFuture = videoPlayerController?.initialize();
    LessonVideo vidInstance = LessonVideo(
        lessonItem: response.data!,
        isPlay: true,
        initializeVideoPlayer: initializeVideoPlayerFuture,
        url: url);
    videoPlayerController?.play();
    ref
        .read(lessonDataControllerProvider.notifier)
        .updateLessonData(vidInstance);
  } else {
    print('request failed ${response.code}');
  }
}

@riverpod
class LessonDataController extends _$LessonDataController {
  @override
  FutureOr<LessonVideo> build() async {
    return LessonVideo();
  }

  @override
  set state(AsyncValue<LessonVideo> newState) {
    // TODO: implement state
    super.state = newState;
  }

  void updateLessonData(LessonVideo lessons) {
    update((data) => lessons);
  }

  void playPause(bool isPlay) {
    update((data) => data.copyWith(isPlay: isPlay));
  }

  void playNextVid(String url) async {
    if (videoPlayerController != null) {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }
    update((data) => data.copyWith(
      isPlay: false,
      initializeVideoPlayer: null,
    ));

    var vidUrl = "${AppConstants.SERVER_API_URL}$url";
     print(vidUrl.toString());

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(vidUrl));
    var initializeVideoPlayerFuture =
    videoPlayerController?.initialize().then((value) {
      videoPlayerController?.seekTo(const Duration(seconds: 0));
      videoPlayerController?.play();
    });

    update((data) => data.copyWith(
        initializeVideoPlayer: initializeVideoPlayerFuture,
        isPlay: true,
        url: vidUrl));
  }
}
