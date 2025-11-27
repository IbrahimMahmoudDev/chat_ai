import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../manager/cubits/signup_cubit/signup_cubit.dart';
import 'already_have_an_account.dart';
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
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: buildForm(isDark, context),
      ),
    );
  }

  Form buildForm(bool isDark, BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          Image.asset(isDark ? Assets.imagesAiChat : Assets.imagesIconLogin),
          SizedBox(height: 15),
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

          SizedBox(height: 60),
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

          const SizedBox(height: 15),
          const AlreadyHaveAnAccount(),
        ],
      ),
    );
  }
}
