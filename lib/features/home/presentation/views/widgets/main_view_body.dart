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
  const TextFormFieldChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal)
          ),

          hintText: 'Send Message...',
          prefixIcon: Icon(Icons.arrow_circle_up_outlined),
          suffixIcon: Icon(Icons.send, color: Colors.teal,),


        ),
      ),
    );
  }
}
