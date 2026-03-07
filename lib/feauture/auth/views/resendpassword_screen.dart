import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;
  final String otpCode;

  ResetPasswordView({super.key, required this.email, required this.otpCode});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true;

  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF3E2723)),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitialState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Password Reset Successfully! Login now."),
                backgroundColor: Colors.green,
              ),
            );
            // الرجوع لصفحة اللوجين
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Color(0xFF3E2723),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter your new password.',
                  style: TextStyle(color: Color(0xFF8D6E63), fontSize: 16),
                ),
                const SizedBox(height: 30),
                // TextFormField(
                //   controller: passwordController,
                //   obscureText: true,
                //   validator: (val) =>
                //       val!.length < 6 ? 'Password too short' : null,
                //   decoration: InputDecoration(
                //     hintText: 'New Password',
                //     prefixIcon: const Icon(
                //       Icons.lock_outline,
                //       color: Colors.brown,
                //     ),
                //     filled: true,
                //     fillColor: Colors.white,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                // ),
                _buildTextField(
                  hintText: 'Enter your password',
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  //  obscureText: true,
                  validator: (v) => v!.length < 6 ? 'Weak password' : null,
                  obscureText: _isPasswordHidden,
                  isHidden: _isPasswordHidden,
                  onToggleVisibility: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  hintText: 'Confirm password',

                  controller: confirmPasswordController,
                  icon: Icons.lock_outline,

                  //  obscureText: true,
                  validator: (v) =>
                      v != passwordController.text ? 'Not match' : null,
                  obscureText: _isConfirmPasswordHidden,
                  isHidden: _isConfirmPasswordHidden,
                  onToggleVisibility: () {
                    setState(() {
                      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                    });
                  },
                ),

                // TextFormField(
                //   controller: confirmPasswordController,
                //   obscureText: true,
                //   validator: (val) => val != passwordController.text
                //       ? 'Passwords do not match'
                //       : null,

                //   decoration: InputDecoration(
                //     hintText: 'Confirm Password',
                //     prefixIcon: const Icon(
                //       Icons.lock_outline,
                //       color: Colors.brown,
                //     ),
                //     filled: true,
                //     fillColor: Colors.white,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 40),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return state is AuthLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().resetPassword(
                                  email: widget.email,
                                  otp: widget.otpCode,
                                  newPassword: passwordController.text.trim(),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6D4C41),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  'Change Password',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField({
  required String hintText,
  required TextEditingController controller,
  required IconData icon,
  bool obscureText = false,
  String? Function(String?)? validator,
  VoidCallback? onToggleVisibility,
  bool? isHidden,
  bool enabled = true,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      decoration: _inputDecoration(
        hintText,
        icon,
        isHidden,
        onToggleVisibility,
      ),
    ),
  );
}

InputDecoration _inputDecoration(
  String hint,
  IconData icon,
  bool? isHidden,
  VoidCallback? onToggleVisibility,
) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey),
    prefixIcon: Icon(icon, color: Colors.grey),
    suffixIcon: isHidden != null
        ? IconButton(
            icon: Icon(
              isHidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: onToggleVisibility,
          )
        : null,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    ),
  );
}
