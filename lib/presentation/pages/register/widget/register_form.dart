import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/register/register_entity.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("🎉 Đăng ký thành công")),
          );
          context.go('/login');
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ ${state.message}")),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          left: 20,
          right: 20,
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    label: "Tên đăng nhập",
                    controller: usernameController,
                    icon: Icons.person,
                    validator: (value) =>
                    value == null || value.isEmpty ? "Không được bỏ trống" : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: "Email",
                    controller: emailController,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Email không được để trống";
                      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                      return emailRegex.hasMatch(value) ? null : "Email không hợp lệ";
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(
                    label: "Mật khẩu",
                    controller: passwordController,
                    obscure: _obscurePassword,
                    toggleObscure: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Không được bỏ trống";
                      return value.length >= 6
                          ? null
                          : "Mật khẩu phải ít nhất 6 ký tự";
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(
                    label: "Xác nhận mật khẩu",
                    controller: confirmPasswordController,
                    obscure: _obscureConfirm,
                    toggleObscure: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Không được bỏ trống";
                      return value == passwordController.text
                          ? null
                          : "Mật khẩu không khớp";
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: "Họ và tên",
                    controller: fullNameController,
                    icon: Icons.person_outline,
                    validator: (value) =>
                    value == null || value.isEmpty ? "Không được bỏ trống" : null,
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final entity = RegisterEntity(
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          fullName: fullNameController.text,
                        );

                        context
                            .read<RegisterBloc>()
                            .add(RegisterSubmitted(entity));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      disabledBackgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 90),
                    ),
                    child: const Text("Đăng ký"),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: const Text.rich(
                      TextSpan(
                        text: "Đã có tài khoản? ",
                        children: [
                          TextSpan(
                            text: "Đăng nhập",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleObscure,
        ),
      ),
    );
  }
}
