import 'package:flutter/material.dart';
import '../utils/app_style_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.targetPage, // الصفحة اللي هينتقل لها
    required this.text,
    this.transitionDuration = const Duration(milliseconds: 600),
  });

  final void Function()? onPressed;
  final Widget? targetPage;
  final String text;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          if (targetPage != null) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => targetPage!,
                transitionDuration: transitionDuration,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // من اليمين للشمال
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: FadeTransition(
                      opacity: animation.drive(fadeTween),
                      child: child,
                    ),
                  );
                },
              ),
            );
          } else if (onPressed != null) {
            onPressed!();
          }
        },
        child: Text(
          text,
          style: AppTextStyles.bold16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
