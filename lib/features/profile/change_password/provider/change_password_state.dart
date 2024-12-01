class ChangePasswordState {
  final String confirm;
  final String password;

  const ChangePasswordState({this.confirm = "", this.password = ""});

  ChangePasswordState copyWith({String? confirm, String? password}) {
    return ChangePasswordState(
      confirm: confirm ?? this.confirm,
      password: password ?? this.password,
    );
  }
}

