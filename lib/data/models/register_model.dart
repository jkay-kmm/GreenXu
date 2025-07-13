class RegisterModel {
  final String username;
  final String email;
  final String password;
  final String fullName;

  const RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
    'full_name': fullName,
  };
}
