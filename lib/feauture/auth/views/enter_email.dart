import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/const/role_const.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/manager/auth_state.dart';
import 'package:graduation2/feauture/auth/views/email_verified_screen.dart';
import 'package:graduation2/feauture/auth/views/enter_code_screen.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/auth/views/widgets/custom_button.dart';

class CheckEmailScreen extends StatelessWidget {
  CheckEmailScreen({super.key, required this.role});
  final String role;
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyEmailSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              //eman
              builder: (_) => EmailVerifiedScreen(
                email: emailController.text.trim(),
                role: role,
              ),

              ///eman
              // EnterCodeScreen(
              //   email: emailController.text.trim(),
              //   role: role,
              // ),
            ),
          );
        }

        if (state is AuthFailureState) {
          showErrorDialog(context, state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAF8F5),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xffBBDEFB),
                    child: Icon(
                      Icons.email_outlined,
                      color: Color(0xff1976D2),
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Welcome !',
                    style: TextStyle(
                      color: Color(0xFF3E2723),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter your email to get started",
                    style: TextStyle(
                      color: const Color(0xFF8D6E63),
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  const SizedBox(height: 32),

                  _buildLabel("Email Address"),
                  const SizedBox(height: 8),

                  _buildTextField(
                    hintText: 'Enter your email',
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    buttonText: 'Continue',
                    onTap: () {
                      context.read<AuthCubit>().verifyEmail(
                        email: emailController.text.trim(),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            color: Color(0xFFD7CCC8),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              color: Color(0xFF6C4D41),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFFD7CCC8),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // TODO: Google Login Logic
                    },
                    child: Container(
                      width: double.infinity,
                      height: heightScreen * .05,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFFD7CCC8),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/LoginScreen.png', // حطي لوجو جوجل
                            height: 22,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Login with Google',
                            style: TextStyle(
                              color: Color(0xFF6D4C41),
                              fontSize: 18,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginView();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 12),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: _inputDecoration(hintText, icon),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.error_outline, color: Colors.red),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(message, textAlign: TextAlign.center),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
