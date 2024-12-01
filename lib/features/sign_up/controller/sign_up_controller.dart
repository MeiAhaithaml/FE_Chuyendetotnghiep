import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/global_loader/global_loader.dart';
import '../../../common/widgets/popup_messages.dart';
import '../provider/register_notifier.dart';
import '../repo/sign_up_repo.dart';


class SignUpController{
  final WidgetRef ref;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotifierProvider);

    String name = state.userName;
    String email = state.email;

    String password = state.password;
    String rePassword = state.rePassword;
    if(state.userName.isEmpty || name.isEmpty){
      toastInfo("Vui lòng điền tên người dùng");
      return;
    }

    if(state.userName.length<6 || name.length<6){
      toastInfo("Tên người dùng quá ngắn");
      return;
    }

    if(state.email.isEmpty || email.isEmpty){
      toastInfo("Vui lòng điền Email");
      return;
    }
    if((state.password.isEmpty||state.rePassword.isEmpty)||password.isEmpty||rePassword.isEmpty){
      toastInfo("Vui lòng điền mật khẩu");
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    var context = Navigator.of(ref.context);
    try{

      final credential = await SignUpRep.firebaseSignUp(email, password);

      if (kDebugMode) {
        print(credential);
      }

      if(credential.user!=null){

        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);
        String photoUrl = "uploads/default.png";
        await credential.user?.updatePhotoURL(photoUrl);

        toastInfo("Vui lòng xác nhận Email");
        context.pop();
      }


    }on FirebaseAuthException catch(e){
       if(e.code=='weak-password'){
         toastInfo("Mật khẩu yếu");
       }else if(e.code=='email-already-in-use'){
         toastInfo("Email này đã được dùng");
       }else if(e.code=='user-not-found'){
         toastInfo("Không tìm thấy người dùng");
       }
      print(e.code);
    }catch(e){
      if (kDebugMode) {
        print(" Lỗi ${e.toString()}");
      }
    }
    ref.watch(appLoaderProvider.notifier).setLoaderValue(false);

  }


}