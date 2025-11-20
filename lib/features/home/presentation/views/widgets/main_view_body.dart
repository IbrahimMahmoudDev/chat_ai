import 'package:chat_ai/core/utils/app_style_text.dart';
import 'package:flutter/material.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(child: ListView()),
        TextFormFieldChat()
      ],
    );
  }
}

class TextFormFieldChat extends StatelessWidget {
  const TextFormFieldChat({super.key, this.onFieldSubmitted});
final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.teal)
          ),

          hintText: 'Ask me anything...',
          hintStyle: AppTextStyles.regular16,
          prefixIcon: Icon(Icons.add_circle_outline_outlined,color: Colors.grey.shade600,),
          suffixIcon: Icon(Icons.arrow_circle_up_outlined,size: 25,color: Colors.grey.shade600,),


        ),
      ),
    );
  }
}
