import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    required this.controller,
    required this.icon,
    this.validator,   // ← خليته external
  });

  final String? hintText;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;  // ← هنا

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * .012,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,     // ← هنا
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.brown),
          hintStyle: const TextStyle(
            color: Color(0xFFBCAAA4),
            fontSize: 13,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffBCAAA4)),
            borderRadius: BorderRadius.circular(18),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffBCAAA4)),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomFormTextField extends StatelessWidget {
//   CustomFormTextField({
//     this.onChanged,
//     super.key,
//     this.hintText,
//     this.obscureText = false,
//     required this.controller,
//     required this.icon,
//   });
//   String? hintText;
//   bool? obscureText;
//   IconData icon;
//   Function(String)? onChanged;
//   final TextEditingController controller;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).size.height * .012,
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText!,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please confirm your password';
//           }
//           if (value != controller.text) {
//             return 'Passwords do not match';
//           }
//           return null;

//           // if (data!.isEmpty) {
//           //   return 'field is required';
//           // }
//         },
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           hintText: hintText,
//           prefixIcon: Icon(icon, color: Colors.brown),
//           hintStyle: TextStyle(
//             color: const Color(0xFFBCAAA4),
//             fontSize: 13,
//             fontFamily: 'Arimo',
//             fontWeight: FontWeight.w400,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffBCAAA4)),
//             borderRadius: BorderRadius.circular(18),
//           ),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffBCAAA4)),
//             borderRadius: BorderRadius.circular(18),
//           ),
//         ),
//       ),
//     );
//   }
// }
