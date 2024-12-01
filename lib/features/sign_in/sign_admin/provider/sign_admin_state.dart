class SignAdminState {
  final String username;
  final String password;

  const SignAdminState({this.username = "", this.password = ""});

  SignAdminState copyWith({String? username, String? password}) {
    return SignAdminState(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

