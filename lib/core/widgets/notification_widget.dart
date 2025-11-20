import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: ShapeDecoration(
          color: Color(0xFFEEFBED),
          shape: OvalBorder()
      ),
      child: Image.asset(Assets.imagesIconNotification),
    );
  }
}