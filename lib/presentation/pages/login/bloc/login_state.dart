class LoginState {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  LoginState({
    required this.email,
    required this.password,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  factory LoginState.initial() {
    return LoginState(email: '', password: '');
  }
}
