import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/widgets/button_widgets.dart';
import 'package:study_app/features/sign_in/forget/forget.dart';
import 'package:study_app/features/sign_in/view/widgets/sign_in_widgets.dart';
import '../../../common/global_loader/global_loader.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/image_res.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/app_textfields.dart';
import '../../../common/widgets/text_widgets.dart';
import '../controller/sign_in_controller.dart';
import '../provider/sign_in_notifier.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late SignInController _controller;

  @override
  void didChangeDependencies() {
    _controller = SignInController();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = ref.watch(signInNotifierProvider);
    final loader = ref.watch(appLoaderProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: "Đăng nhập"),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgwelcome.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                loader == false
                    ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     thirdPartyLogin(),
                      const Center(
                          child: Text14Normal(
                              text: "Hoặc sử dụng Email của bạn")),
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: Consumer(
                          builder: (_, WidgetRef ref, child) {
                            return appTextField(
                              controller: _controller.emailController,
                              text: "Email",
                              iconName: ImageRes.user,
                              hintText: "Vui lòng nhập email",
                              func: (value) => ref
                                  .read(signInNotifierProvider.notifier)
                                  .onUserEmailChange(value),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      appTextField(
                          controller: _controller.passwordController,
                          text: "Mật khẩu",
                          iconName: ImageRes.lock,
                          hintText: "Nhập mật khẩu",
                          obscureText: true,
                          func: (value) => ref
                              .read(signInNotifierProvider.notifier)
                              .onUserPasswordChange(value)),
                      SizedBox(
                        height: 20.h,
                      ),
                      //forgot text
                      Container(
                        margin: EdgeInsets.only(left: 25.w),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgetPage()),
                              );
                            },
                            child: const Text14Normal(text: "Quên mật khẩu?",color: Colors.redAccent,)),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Center(
                          child: AppButton(
                            buttonName: "Đăng nhập",
                            func: () => _controller.handleSignIn(ref),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                          child: AppButton(
                              buttonName: "Đăng ký",
                              isLogin: false,
                              context: context,
                              func: () =>
                                  Navigator.pushNamed(context, "/register"))),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 180, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/sign_in_admin');
                          },
                          child: const Text14Normal(
                            text: "Bạn không phải học viên?",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    color: AppColors.primaryElement,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
