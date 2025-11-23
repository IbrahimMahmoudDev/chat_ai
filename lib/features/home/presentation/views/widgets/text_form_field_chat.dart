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

      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = controller.text.isNotEmpty;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),

          ),
          hintText: 'Ask me anything...',
          hintStyle: AppTextStyles.regular16.copyWith(color: theme.hintColor),

          prefixIcon: Icon(
            Icons.emoji_emotions_outlined,
            color: theme.iconTheme.color,
          ),

            suffixIcon: Icon(
              Icons.send,
              size: 25,
              color: hasText ? theme.iconTheme.color : theme.disabledColor,
            ),
        ),
      ),
    );
  }
}
