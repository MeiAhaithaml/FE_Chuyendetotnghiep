import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../common/global_loader/global_loader.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/image_res.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/app_textfields.dart';
import '../../../common/widgets/button_widgets.dart';
import '../../../common/widgets/text_widgets.dart';
import '../controller/sign_up_controller.dart';
import '../provider/register_notifier.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    _controller = SignUpController(ref: ref);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);
    //regProvider.
    final loader = ref.watch(appLoaderProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: "Đăng nhập"),
            backgroundColor: Colors.white,
            body: loader == false
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        //more login options message
                         const Center(
                            child:  Text14Normal(
                                text:
                                    "Vui lòng nhập thông tin cá nhân để tiến hành đăng ký")),
                        SizedBox(
                          height: 50.h,
                        ),
                        //user name text box
                        appTextField(
                          text: "Tên người dùng",
                          iconName: ImageRes.user,
                          hintText: "Nhập tên",
                          func: (value) => ref
                              .read(registerNotifierProvider.notifier)
                              .onUserNameChange(value),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //email text box
                        appTextField(
                          text: "Email",
                          iconName:  ImageRes.user,
                          hintText: "Vui lòng nhập Email",
                          func: (value) => ref
                              .read(registerNotifierProvider.notifier)
                              .onUserEmailChange(value),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //password text box
                        appTextField(
                          text: "Mật khẩu",
                          iconName:  ImageRes.lock,
                          hintText: "Vui lòng nhập mật khẩu",
                          obscureText: true,
                          func: (value) => ref
                              .read(registerNotifierProvider.notifier)
                              .onUserPasswordChange(value),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //password text box
                        appTextField(
                            text: "Xác nhận mật khẩu",
                            iconName:  ImageRes.lock,
                            hintText: "Xác nhận",
                            func: (value) => ref
                                .read(registerNotifierProvider.notifier)
                                .onUserRePasswordChange(value),
                            obscureText: true),
                        SizedBox(
                          height: 20.h,
                        ),
                        //forgot text
                        Container(
                            margin: EdgeInsets.only(left: 25.w),
                            child: const Text14Normal(
                                text:
                                    "")),
                        SizedBox(
                          height: 100.h,
                        ),

                        Center(
                            child: AppButton(
                                buttonName: "Đăng ký",
                                isLogin: true,
                                context: context,
                                func: () => _controller.handleSignUp()))
                        //app register button
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: AppColors.primaryElement,
                    ),
                  )),
      ),
    );
  }
}
