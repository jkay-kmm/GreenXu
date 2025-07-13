import 'package:equatable/equatable.dart';
import '../../../data/models/register_model.dart';


class RegisterEntity extends Equatable {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String fullName;

  const RegisterEntity({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.fullName,
  });

  @override
  List<Object?> get props => [username, email, password, confirmPassword, fullName];

  RegisterModel toModel() => RegisterModel(
    username: username,
    email: email,
    password: password,
    fullName: fullName,
  );
}
