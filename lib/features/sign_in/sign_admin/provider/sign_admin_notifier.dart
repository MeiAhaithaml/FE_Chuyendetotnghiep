import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/features/sign_in/sign_admin/provider/sign_admin_state.dart';



class SignAdminNotifier extends StateNotifier<SignAdminState> {
  SignAdminNotifier() : super(const SignAdminState());

  void onUserNameChange(String username) {
    state = state.copyWith(username: username);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }
}

final signAdminNotifierProvider =
    StateNotifierProvider<SignAdminNotifier, SignAdminState>(
        (ref) => SignAdminNotifier());
