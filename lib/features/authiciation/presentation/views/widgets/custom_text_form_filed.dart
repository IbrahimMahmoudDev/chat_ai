import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style_text.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.textInputType,
    this.iconSuffix,
    required this.hintText,
    this.onSaved,
    this.obscureText = false,
  });
  final TextInputType textInputType;
  final Widget? iconSuffix;
  final String hintText;
  final void Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'all field required';
        } else {
          return null;
        }
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: iconSuffix,
        hintText: hintText,
        hintStyle: AppTextStyles.semibold14.copyWith(color: theme.hintColor),
        fillColor: theme.inputDecorationTheme.fillColor,
        border: buildOutlineInputBorder(theme),
        enabledBorder: buildOutlineInputBorder(theme),
        focusedBorder: buildOutlineInputBorder(theme),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(ThemeData theme) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: theme.dividerColor),
    );
  }
}
