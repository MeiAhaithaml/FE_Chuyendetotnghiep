import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/features/buy_course/controller/buy_course_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyCourse extends ConsumerStatefulWidget {
  const BuyCourse({Key? key}) : super(key: key);

  @override
  ConsumerState<BuyCourse> createState() => _BuyCourseState();
}

class _BuyCourseState extends ConsumerState<BuyCourse> {
  late var args;
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Pay',
        onMessageReceived: (JavaScriptMessage message) {
          print("------message received------");
          print(message.message);
          Navigator.of(context).pop(message.message);
        },
      );
  }

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];
    print(args);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var courseBuy = ref.watch(buyCourseControllerProvider(index: args.toInt()));
    return Scaffold(
      appBar: AppBar(),
      body: courseBuy.when(
        data: (data) {
          if (data == null) {
            return Center(
              child: Text(
                "Order exist or something went wrong",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.cyan),
              ),
            );
          }
          return WebViewWidget(controller: webViewController..loadRequest(Uri.parse(data)));
        },
        error: (error, trace) => Center(child: Text("Error getting webview")),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
