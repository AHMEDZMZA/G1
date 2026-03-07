// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/auth/views/register_screen.dart';
// import 'package:graduation2/feauture/splash_screen/presentation/view/splash.dart';

// class LoginView extends StatelessWidget {
//   LoginView({super.key});
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;
//     final _formKey = GlobalKey<FormState>();
//     return Scaffold(
//       backgroundColor: const Color(0xffFAF8F5),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//                Container(
//                     height: heightScreen * .2,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/Container-4.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: widthScreen * .07,
//                   vertical: heightScreen * .03,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Welcome Back',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: const Color(0xFF3E2723),
//                         fontSize: 22,
//                         fontFamily: 'Arimo',
//                         fontWeight: FontWeight.w700,
//                         // height: 1.33,
//                       ),
//                     ),
//                     SizedBox(height: heightScreen * .01),
//                     Text(
//                       'Sign in to continue crafting',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: const Color(0xFF8D6E63),
//                         fontSize: 14,
//                         fontFamily: 'Arimo',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(height: heightScreen * .03),

//                    _buildLabel('Email Address'),
//                     _buildTextField(
//                       hintText: 'Enter your email',
//                       controller: emailController,
//                       icon: Icons.email_outlined,
//                     ),
//                      _buildLabel('Password'),
//                     _buildTextField(
//                       hintText: 'Enter your password',
//                       obscureText: true,
//                       controller: passwordController,
//                       icon: Icons.lock_outline,
//                     ),
//                     Align(
//                       alignment: AlignmentGeometry.topRight,
//                       child: Text(
//                         'Forgot Password?',
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                           color: const Color(0xFFC9A875),
//                           fontSize: 14,
//                           fontFamily: 'Arimo',
//                           fontWeight: FontWeight.w400,
//                           height: 1.43,
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: heightScreen * .08),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         decoration: ShapeDecoration(
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1.5,
//                               color: const Color(0xFFD7CCC8),
//                             ),
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * .05,
//                         child: Center(
//                           child: Text(
//                             'login',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Color(0xFF6D4C41),
//                               fontSize: 18,
//                               fontFamily: 'Arimo',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         decoration: ShapeDecoration(
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1.5,
//                               color: const Color(0xFFD7CCC8),
//                             ),
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * .05,
//                         child: Center(
//                           child: Text(
//                             'Continue Guest',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Color(0xFF6D4C41),
//                               fontSize: 18,
//                               fontFamily: 'Arimo',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 14),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Don't have an account? ",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: const Color(0xFF8D6E63),
//                             fontSize: 13,
//                             fontFamily: 'Arimo',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return SplashView();
//                                 },
//                               ),
//                             );
//                           },
//                           child: Text(
//                             'Sign Up',
//                             style: TextStyle(
//                               color: const Color(0xFF6D4C41),
//                               fontSize: 12.25,
//                               fontFamily: 'Arimo',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//   Widget _buildLabel(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 8, top: 12),
//         child: Text(text,
//             style: const TextStyle(fontWeight: FontWeight.w600)),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String hintText,
//     required TextEditingController controller,
//     required IconData icon,
//     bool obscureText = false,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       validator: validator,
//       decoration: InputDecoration(
//         hintText: hintText,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/manager/auth_state.dart';
import 'package:graduation2/feauture/auth/views/forget_password.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';
import 'package:graduation2/feauture/typeof%20person/view/type_of_person.dart';
import '../../../core/services/api_services.dart';
import '../../../generated/locale_keys.g.dart';
import '../../product_screens/presentation/view/addprodect_screen/creatprodect.dart';
import '../../product_screens/presentation/view/explore_prodect/widget/custom_navigationbar.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

   bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: BlocProvider(
        create: (context) => AuthCubit(ApiService()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            } else if (state is AuthSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login Successful! Welcome ${state.user.userName ?? ''}',
                  ),
                ),
              );

             Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MainWrapper(),
                ),
              );
              //  UserProfileModel user=   context.read<UserProfileRepo>().getCurrentUser(

              //         );
             // Navigator.push(
               // context,
               // MaterialPageRoute(
                 // builder: (_) => BlocProvider(
                  //  create: (_) =>
                      //  UserProfileCubit(UserProfileRepo())..fetchProfile(),
                   // child: const Profile(),
                //  ),
               // ),
             // );
              // هنا ممكن تعمل Navigate للصفحة الرئيسية
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: heightScreen * .2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Container-4.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widthScreen * .07,
                        vertical: heightScreen * .03,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            LocaleKeys.welcomback.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF3E2723),
                              fontSize: 22,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: heightScreen * .01),
                          const Text(
                            'Sign in to continue crafting',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF8D6E63),
                              fontSize: 14,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: heightScreen * .03),
                          _buildLabel('Email Address'),
                          _buildTextField(
                            hintText: 'Enter your email',
                            controller: emailController,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          _buildLabel('Password'),
                          _buildTextField(
                            hintText: 'Enter your password',
                           // obscureText: true,
                            controller: passwordController,
                            icon: Icons.lock_outline,
                              obscureText: _isPasswordHidden,
                          isHidden: _isPasswordHidden,
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                // هنا ممكن تحط نافيغيت لصفحة نسيت كلمة المرور
                              },
                              child: GestureDetector(
                                onTap: () {
                                  // 1. نجيب نسخة الـ Cubit الحالية
                                  final authCubit = context.read<AuthCubit>();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        // 2. نمرر نفس النسخة للصفحة الجديدة
                                        return BlocProvider.value(
                                          value: authCubit,
                                          child: ForgetPasswordView(),
                                        );
                                      },
                                    ),
                                  );
                                },

                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color(0xFFC9A875),
                                    fontSize: 14,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w400,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: heightScreen * .025),
                          state is AuthLoadingState
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.login(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF6C4D41),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1.5,
                                          color: Color(0xFF6C4D41),
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: heightScreen * .05,
                                    child: const Center(
                                      child: Text(
                                        'Login',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 18,
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    color: Color(
                                      0xFFE0E0E0,
                                    ), // لون الخط الفاتح زي الصورة
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 14,
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFE0E0E0),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthCubit>().signInWithGoogle(
                                role: 'Customer',
                              );
                            },

                            // أو Expert
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

                          SizedBox(height: 16),

                          GestureDetector(
                            onTap: () {
                              // Continue as guest
                            },
                            child: Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1.5,
                                    color: Color(0xFFD7CCC8),
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              width: double.infinity,
                              height: heightScreen * .05,
                              child: const Center(
                                child: Text(
                                  'Continue Guest',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6D4C41),
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF8D6E63),
                                  fontSize: 13,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RoleSelectionScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFF6D4C41),
                                    fontSize: 12.25,
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
}
//   Widget _buildTextField({
//     required String hintText,
//     required TextEditingController controller,
//     required IconData icon,
//     bool obscureText = false,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         validator: validator,
//         decoration: _inputDecoration(hintText, icon),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(String hint, IconData icon) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(color: Colors.grey),
//       prefixIcon: Icon(icon, color: Colors.grey),
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(24),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

// InputDecoration _dropdownDecoration(String hint) {
//   return InputDecoration(
//     hintText: hint,
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(24),
//       borderSide: BorderSide.none,
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(24),
//       borderSide: BorderSide.none,
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(24),
//       borderSide: BorderSide.none,
//     ),
//     suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//   );
 
// }
