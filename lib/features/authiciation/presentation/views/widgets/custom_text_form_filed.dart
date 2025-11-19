import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style_text.dart';


class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.textInputType,
    this.iconSuffix,
    required this.hintText,
    this.onSaved,  this.obscureText  =false,
  });
  final TextInputType textInputType;
  final Widget? iconSuffix;
  final String hintText;
  final void Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText ,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        } else {
          return null;
        }
      },
      keyboardType: textInputType,
      decoration: InputDecoration(

        filled: true,
        suffixIcon: iconSuffix,
        hintText: hintText,
        hintStyle: AppTextStyles.semibold16.copyWith(
          color: Color(0xFF9DA5A6),
        ),
        fillColor: Color(0xFFF9FAFA),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFFEBEDED)),
    );
  }
}
