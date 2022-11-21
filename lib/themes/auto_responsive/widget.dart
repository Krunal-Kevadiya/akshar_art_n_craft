part of auto_responsive;

/// Provides `Context` parameters to the builder function
typedef ResponsiveBuild = Widget Function(BuildContext context);

/// A widget that gets the device's details like orientation and constraints
/// Usage: Wrap MaterialApp with this widget
class AutoResponsive extends StatelessWidget {
  const AutoResponsive({
    required this.builder,
    super.key,
    this.isAppLandscape = false,
    this.guidelineBaseWidth,
    this.guidelineBaseHeight,
    this.guidelineAspectRatioFunction,
  });

  /// Builds the widget whenever the orientation changes
  final ResponsiveBuild builder;
  final bool isAppLandscape;
  final double? guidelineBaseWidth;
  final double? guidelineBaseHeight;
  final double Function(double size)? guidelineAspectRatioFunction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Constant.setScreenSize(
              constraints: constraints,
              currentOrientation: orientation,
              mediaQueryData: MediaQueryData.fromView(View.of(context)),
              isAppLandscape: isAppLandscape,
              guidelineBaseWidth: guidelineBaseWidth,
              guidelineBaseHeight: guidelineBaseHeight,
              guidelineAspectRatioFunction: guidelineAspectRatioFunction,
            );
            return builder(context);
          },
        );
      },
    );
  }
}
