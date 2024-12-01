import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/features/profile/change_password/provider/change_password_state.dart';



//StateNotifier saves state
class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  ChangePasswordNotifier() : super(ChangePasswordState());

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setConfirm(String confirm) {
    state = state.copyWith(confirm: confirm);
  }
}


final changePasswordNotifierProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
        (ref) => ChangePasswordNotifier());
