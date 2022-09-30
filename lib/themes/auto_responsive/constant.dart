part of auto_responsive;

class Constant {
  static late double width;
  static late double height;
  static late double shortDimension;
  static late double longDimension;
  static late double currentWidthDimen;
  static late Orientation orientation;
  static late double fontScale;

  static late double guideLineBaseHeight;
  static late double guideLineBaseWidth;
  static late double Function(double size) guideLineBaseAspectRatioFn;

  static void setScreenSize({
    required BoxConstraints constraints,
    required Orientation currentOrientation,
    required MediaQueryData mediaQueryData,
    bool isAppLandscape = false,
    double? guidelineBaseWidth,
    double? guidelineBaseHeight,
    double Function(double size)? guidelineAspectRatioFunction,
  }) {
    orientation = currentOrientation;
    fontScale = mediaQueryData.textScaleFactor;
    guideLineBaseWidth = guidelineBaseWidth ?? 375;
    guideLineBaseHeight = guidelineBaseHeight ?? 812;
    guideLineBaseAspectRatioFn =
        guidelineAspectRatioFunction ?? getDefaultAspectRatioFn;
    if (isAppLandscape && orientation == Orientation.portrait) {
      width = max(mediaQueryData.size.height, constraints.maxHeight);
      height = max(mediaQueryData.size.width, constraints.maxWidth);
    } else {
      width = max(mediaQueryData.size.width, constraints.maxWidth);
      height = max(mediaQueryData.size.height, constraints.maxHeight);
    }
    currentWidthDimen = 0;
    shortDimension = min(width, height);
    longDimension = max(width, height);
  }

  static double getDefaultAspectRatioFn(double size) {
    final aspectRatio = height / width;
    var newSize = 0.0;
    if (aspectRatio > 1.77) {
      newSize = size;
    } else if (aspectRatio > 1.6) {
      newSize = size * 0.97;
    } else if (aspectRatio > 1.55) {
      newSize = size * 0.95;
    } else if (aspectRatio > 1.5) {
      newSize = size * 0.93;
    } else if (aspectRatio > 1.45) {
      newSize = size * 0.91;
    } else if (aspectRatio > 1.4) {
      newSize = size * 0.89;
    } else if (aspectRatio > 1.35) {
      newSize = size * 0.87;
    } else if (aspectRatio > 1.329) {
      return size;
    } else if (aspectRatio > 1.3) {
      newSize = size * 0.85;
    } else if (aspectRatio > 1.2) {
      newSize = size * 0.84;
    } else if (aspectRatio > 1.185) {
      return size * 0.95;
    } else if (aspectRatio > 1.15) {
      return size * 0.82;
    } else {
      newSize = size * 0.6;
    }
    return newSize;
  }

  static double dimenMin = 300;
  static double dimenMax = 1080;
  static double dimenInterval = 30;

  static double getAvailableWidthDimension() {
    if (currentWidthDimen == 0) {
      var dimen = width;
      for (var i = dimenMin; i <= dimenMax; i = i + dimenInterval) {
        if (width >= i && width < i + dimenInterval) {
          dimen = i;
          break; // stop the loop
        }
      }
      currentWidthDimen = dimen;
      return dimen;
    } else {
      return currentWidthDimen;
    }
  }
}
