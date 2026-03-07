import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/manager/auth_state.dart';
import 'package:graduation2/feauture/auth/views/register_screen.dart';
import 'package:graduation2/feauture/auth/views/widgets/custom_button.dart';

import '../manager/auth_cubit.dart';

class EnterCodeScreen extends StatelessWidget {
  final String email;
  final String role;
  EnterCodeScreen({super.key, required this.email, required this.role});

  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CheckOtpSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SignUpView(role: role, email: email),
            ),
          );
        }

        if (state is AuthFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAF8F5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Colors.brown),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xffCE93D8),
                    child: Icon(
                      Icons.lock_outline,
                      color: Color(0xff7B1FA2),
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Enter code',
                    style: TextStyle(
                      color: Color(0xFF3E2723),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "We sent a code to $email",
                    style: TextStyle(
                      color: const Color(0xFF8D6E63),
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 45,
                        height: 55,
                        child: TextField(
                          controller: controllers[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomButton(
                    buttonText: 'Verify code',
                    onTap: () {
                      final otp = controllers.map((c) => c.text).join();

                      context.read<AuthCubit>().checkEmailOtp(
                        email: email,
                        otp: otp,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  CustomButton(
                    buttonText: 'Resend code',
                    onTap: () {
                      context.read<AuthCubit>().verifyEmail(email: email);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
