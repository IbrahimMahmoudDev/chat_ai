import 'package:flutter/material.dart';

class AiTypingIndicator extends StatelessWidget {
  const AiTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              dot(),
              SizedBox(width: 4),
              dot(),
              SizedBox(width: 4),
              dot(),
            ],
          ),
        ),
      ],
    );
  }

  Widget dot() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.3, end: 1),
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      onEnd: () {},
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
