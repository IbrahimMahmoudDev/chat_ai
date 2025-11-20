import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_style_text.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../manager/cubits/signup_cubit/signup_cubit.dart';
import 'custom_password_field.dart';
import 'custom_text_form_filed.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  late String name, email, password;
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
                onSaved: (value) {
                  name = value!;
                },
                iconSuffix: Icon(Icons.person, color: Colors.grey),
                textInputType: TextInputType.text,
                hintText: 'Name',
              ),
              SizedBox(height: 24),
              CustomTextFormFiled(
                onSaved: (value) {
                  email = value!;
                },
                iconSuffix: Icon(Icons.email, color: Colors.grey),
                textInputType: TextInputType.emailAddress,
                hintText: 'Email',
              ),
              SizedBox(height: 24),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),

              SizedBox(height: 90),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<SignupCubit>().createUserWithEmailAndPassword(
                      email,
                      password,
                      name,
                    );
                  } else {
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: 'Sign up',
              ),

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
