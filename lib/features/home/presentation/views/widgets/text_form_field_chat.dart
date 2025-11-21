import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style_text.dart';

class TextFormFieldChat extends StatefulWidget {
  const TextFormFieldChat({super.key, this.onFieldSubmitted, this.controller});
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;

  @override
  State<TextFormFieldChat> createState() => _TextFormFieldChatState();
}

class _TextFormFieldChatState extends State<TextFormFieldChat> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // امسح الـ controller الداخلي فقط لو هو داخلي
      controller.dispose();
    }
    super.dispose();
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
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
            Icons.send,
            size: 25,
            color: hasText ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
