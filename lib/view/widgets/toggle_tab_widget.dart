import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/constants/app_colors.dart';
import 'my_text_widget.dart';

class ToggleTab extends StatelessWidget {
  final String tab;
  final bool isSelected;
  final VoidCallback onTap;
  const ToggleTab({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: Get.height,
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: isSelected ? kSecondaryColor : kSecondaryColor.withOpacity(0.23),
        borderRadius: BorderRadius.circular(26),
      ),
      child: MyRippleEffect(
        onTap: onTap,
        radius: 26,
        child: Center(
          child: MyText(
            text: tab,
            size: 12,
            color: isSelected ? kPrimaryColor : kBlackColor1,
            weight: isSelected ? FontWeight.w600 : FontWeight.w400,
            paddingRight: 16,
            paddingLeft: 16,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyRippleEffect extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  Color? splashColor;
  double? radius;
  MyRippleEffect({
    super.key,
    required this.child,
    required this.onTap,
    this.splashColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor ?? kPrimaryColor.withOpacity(0.1),
        highlightColor: splashColor ?? kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(radius ?? 8),
        child: child,
      ),
    );
  }
}
