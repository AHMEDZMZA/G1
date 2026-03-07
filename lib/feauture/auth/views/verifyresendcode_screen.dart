import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/auth/views/resendpassword_screen.dart';

import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  final String email;
  VerifyResetCodeScreen({super.key, required this.email});

  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CheckOtpSuccessState) {
          // الانتقال لصفحة تغيير الباسورد
          final authCubit = context.read<AuthCubit>();
          final otp = controllers.map((c) => c.text).join();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: authCubit,
                child: ResetPasswordView(email: email, otpCode: otp),
              ),
            ),
          );
        } else if (state is AuthFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffFAF8F5),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const BackButton(color: Colors.brown),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter Code',
                      style: TextStyle(
                        color: Color(0xFF3E2723),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We sent a code to $email",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF8D6E63),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 40,
                          height: 50,
                          child: TextField(
                            controller: controllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5)
                                FocusScope.of(context).nextFocus();
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    state is AuthLoadingState
                        ? const CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              final otp = controllers.map((c) => c.text).join();
                              if (otp.length == 6) {
                                context.read<AuthCubit>().checkEmailOtp(
                                  email: email,
                                  otp: otp,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please enter complete code"),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6D4C41),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Center(
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
