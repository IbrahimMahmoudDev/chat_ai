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

class TextFormFieldChat extends StatefulWidget {
  const TextFormFieldChat({super.key, this.onFieldSubmitted});
  final void Function(String)? onFieldSubmitted;

  @override
  State<TextFormFieldChat> createState() => _TextFormFieldChatState();
}

class _TextFormFieldChatState extends State<TextFormFieldChat> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {}); // تحديث الواجهة عند تغيّر النص
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = controller.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.teal),
          ),
          hintText: 'Ask me anything...',
          hintStyle: AppTextStyles.regular16,

          prefixIcon: Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.grey.shade600,
          ),

          suffixIcon: Icon(
            Icons.send_outlined,
            size: 25,
            color: hasText ? Colors.black : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
