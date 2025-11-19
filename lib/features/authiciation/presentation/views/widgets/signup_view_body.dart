import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style_text.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import 'custom_text_form_filed.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset(Assets.imagesIconLogin),
              CustomTextFormFiled(
                iconSuffix: Icon(Icons.person, color: Colors.grey),
                textInputType: TextInputType.text,
                hintText: 'Name',
              ),
              SizedBox(height: 24),
              CustomTextFormFiled(
                iconSuffix: Icon(Icons.email, color: Colors.grey),
                textInputType: TextInputType.emailAddress,
                hintText: 'Email',
              ),
              SizedBox(height: 24),
              CustomTextFormFiled(
                iconSuffix: Icon(Icons.visibility_off, color: Colors.grey),
                textInputType: TextInputType.visiblePassword,
                hintText: 'Password',
              ),

              SizedBox(height: 100),
              CustomButton(text: 'Sign up'),

              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member ?', style: AppTextStyles.regular14),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login in',
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
