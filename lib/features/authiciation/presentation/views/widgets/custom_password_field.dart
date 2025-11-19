import 'package:flutter/material.dart';

import 'custom_text_form_filed.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onSaved});
  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormFiled(
      obscureText: obscureText,
      onSaved: widget.onSaved,
      textInputType: TextInputType.visiblePassword,
      hintText: 'Password',
      iconSuffix: GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: obscureText
            ? Icon(Icons.visibility, color: Color(0xFFCBD0D1))
            : Icon(Icons.visibility_off, color: Color(0xFFCBD0D1)),
      ),
    );
  }
}
