import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/auth/views/verifyresendcode_screen.dart';

import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyEmailSuccessState) {
            // الانتقال لصفحة الكود وتمرير الـ Cubit والإيميل
            final authCubit = context.read<AuthCubit>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: authCubit,
                  child: VerifyResetCodeScreen(email: state.email),
                ),
              ),
            );
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: heightScreen * .2,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Container-5.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: heightScreen * .035,
                          left: widthScreen * .035,
                        ),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthScreen * .07,
                      vertical: heightScreen * .03,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Color(0xFF3E2723),
                              fontSize: 24,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ),
                        SizedBox(height: heightScreen * .01),
                        const Text(
                          "No worries! Enter your email address and we'll send you a code to reset your password.",
                          style: TextStyle(
                            color: Color(0xFF8D6E63),
                            fontSize: 16,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SizedBox(height: heightScreen * .03),
                        _buildLabel('Email Address'),
                        _buildTextField(
                          hintText: 'Enter your email address',
                          controller: emailController,
                          icon: Icons.email_outlined,
                          validator: (val) {
                            if (val == null || val.isEmpty)
                              return "Email is required";
                            return null;
                          },
                        ),
                        SizedBox(height: heightScreen * .09),

                        // زرار الإرسال
                        state is AuthLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().forgetPassword(
                                      email: emailController.text.trim(),
                                    );
                                  }
                                },
                                child: Opacity(
                                  opacity: .5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      gradient: const LinearGradient(
                                        begin: Alignment(0.50, 0.00),
                                        end: Alignment(0.50, 1.00),
                                        colors: [
                                          Color(0xFF6D4C41),
                                          Color(0xFF8D6E63),
                                        ],
                                      ),
                                    ),
                                    width: widthScreen,
                                    height: heightScreen * .05,
                                    child: const Center(
                                      child: Text(
                                        'Send Code',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Remember your password?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF8D6E63),
                                fontSize: 13.5,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                            SizedBox(width: widthScreen * .03),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LoginView();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Back to Login',
                                style: TextStyle(
                                  color: const Color(0xFF6D4C41),
                                  fontSize: 13.5,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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

  //   Widget _buildTextField({
  //     required String hintText,
  //     required TextEditingController controller,
  //     required IconData icon,
  //     String? Function(String?)? validator,
  //   }) {
  //     return TextFormField(
  //       controller: controller,
  //       validator: validator,
  //       decoration: InputDecoration(
  //         hintText: hintText,
  //         prefixIcon: Icon(icon),
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //       ),
  //     );
  //   }
  // }
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
      prefixIcon: Icon(icon, color: Color(0xff8D6E63)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    );
  }
}
