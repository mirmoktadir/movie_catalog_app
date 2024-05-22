// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/theme/light_theme_colors.dart';
// import '../../modules/auth/controllers/auth_controller.dart';
//
// class AuthTextField extends StatelessWidget {
//   const AuthTextField({
//     super.key,
//     required this.textEditingController,
//     required this.controller,
//     required this.theme,
//     required this.type,
//     required this.hint,
//     required this.prefixIcon,
//   });
//
//   final TextEditingController textEditingController;
//   final AuthController controller;
//   final ThemeData theme;
//   final String type;
//   final String hint;
//   final IconData prefixIcon;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: textEditingController,
//       obscureText: false,
//       onSaved: (value) {
//         textEditingController.text = value!;
//       },
//       validator: (value) {
//         if (textEditingController.text.isEmpty) {
//           return "$type is required!";
//         }
//         return null;
//         // return type == "Email"
//         //     ? controller.validateEmail(value!)
//         //     : controller.validatePassword(value!);
//       },
//       keyboardType: type == "String"
//           ? TextInputType.text
//           : type == "Email"
//               ? TextInputType.emailAddress
//               : type == "Phone"
//                   ? TextInputType.phone
//                   : TextInputType.number,
//       textInputAction:
//           type == "String" ? TextInputAction.done : TextInputAction.done,
//       cursorColor: LightThemeColors.primaryColor,
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           prefixIcon,
//           color: Colors.black,
//         ),
//         filled: true,
//         fillColor: LightThemeColors.fillColor,
//         hintText: hint,
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(
//             width: 1,
//             color: Colors.red,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(
//             width: 1,
//             color: Colors.red,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }
