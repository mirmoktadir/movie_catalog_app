import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashContainer extends StatelessWidget {
  const SplashContainer(
      {super.key,
      required this.child,
      required this.radius,
      required this.onPressed});

  final Widget child;
  final Function() onPressed;
  final int radius;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(radius.r),
      child: InkWell(
        splashColor: theme.primaryColor.withOpacity(.3),
        splashFactory: InkSplash.splashFactory,
        highlightColor: theme.primaryColor.withOpacity(.3),
        borderRadius: BorderRadius.circular(radius.r),
        radius: 60.r,
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            color: theme.canvasColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
