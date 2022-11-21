import 'package:flutter/material.dart';
import '../assets/assets.dart';
import '../themes/themes.dart';

class Background extends StatelessWidget {
  const Background({
    required this.child,
    super.key,
    this.topImage = Images.mainTop,
    this.topLeft,
    this.topRight,
    this.bottomImage = Images.signinBottom,
    this.bottomLeft,
    this.bottomRight,
    this.alignment = Alignment.center,
    this.bottomImageWidthFactor,
  });

  final Widget child;
  final AlignmentGeometry alignment;
  final String topImage;
  final String bottomImage;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;
  final double? bottomImageWidthFactor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.wp,
      height: 100.hp,
      child: Stack(
        alignment: alignment,
        children: <Widget>[
          Positioned(
            top: 0,
            left: topLeft,
            right: topRight,
            child: Image.asset(
              topImage,
              width: 30.wp,
              height: 35.wp,
              fit: BoxFit.fill,
              color: AppColors.primaryLightColor,
            ),
          ),
          Positioned(
            bottom: 0,
            left: bottomLeft,
            right: bottomRight,
            child: Image.asset(
              bottomImage,
              width: bottomImageWidthFactor?.wp ?? 25.wp,
              height: 30.wp,
              fit: BoxFit.fill,
              color: AppColors.primaryLightColor,
            ),
          ),
          Positioned(child: child),
        ],
      ),
    );
  }
}
