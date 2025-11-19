import 'package:chat_ai/core/utils/app_style_text.dart';
import 'package:chat_ai/core/widgets/custom_button.dart';
import 'package:chat_ai/features/authiciation/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/assets.dart';
import '../signup_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {

  String ? email , password ;
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
              SizedBox(height: 80),
              Image.asset(Assets.imagesIconLogin),
              SizedBox(height: 10),
              CustomTextFormFiled(
                onSaved: (value) {
                  email = value;
                },
                iconSuffix: Icon(Icons.email, color: Colors.grey),
                textInputType: TextInputType.emailAddress,
                hintText: 'Enter your email',
              ),
              SizedBox(height: 24),
              CustomTextFormFiled(
                onSaved: (value) {
                  password = value;
                },
                iconSuffix: Icon(Icons.visibility_off, color: Colors.grey),
                textInputType: TextInputType.visiblePassword,
                hintText: 'Password',
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget password ?',
                  style: AppTextStyles.regular14.copyWith(color: Colors.teal),
                ),
              ),
              SizedBox(height: 100),
              CustomButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      formKey.currentState!.save();
                      print(email);
                      print(password);
                    }else {
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {

                      });
                    }
                  },
                  text: 'Login'),

              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New member ?', style: AppTextStyles.regular14),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupView.routeName);
                    },
                    child: Text(
                      ' Register now',
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
