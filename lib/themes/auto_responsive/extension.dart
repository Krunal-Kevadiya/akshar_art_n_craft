part of auto_responsive;

extension SizerExt on num {
  double get s => (Constant.width / Constant.guideLineBaseWidth) * this;

  double scale({bool skipAspectRatio = false}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return (Constant.width / Constant.guideLineBaseWidth) * changeSize;
  }

  double get vs => (Constant.height / Constant.guideLineBaseHeight) * this;

  double verticalScale({bool skipAspectRatio = false}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return (Constant.height / Constant.guideLineBaseHeight) * changeSize;
  }

  double get ms => this + (s - this) * 0.5;

  double moderateScale({bool skipAspectRatio = false, double factor = 0.5}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return changeSize +
        (changeSize.scale(skipAspectRatio: skipAspectRatio) - changeSize) *
            factor;
  }

  double get mvs => this + (vs - this) * 0.5;

  double moderateVerticalScale({
    bool skipAspectRatio = false,
    double factor = 0.5,
  }) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return changeSize +
        (changeSize.verticalScale(skipAspectRatio: skipAspectRatio) -
                changeSize) *
            factor;
  }

  double get vw => (this / 100) * Constant.width;

  double viewportWidth({bool skipAspectRatio = false}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return (changeSize / 100) * Constant.width;
  }

  double get vh => (this / 100) * Constant.height;

  double viewportHeight({bool skipAspectRatio = false}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return (changeSize / 100) * Constant.height;
  }

  double get vmin => (this / 100) * Constant.shortDimension;

  double viewportMin({bool skipAspectRatio = false}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return (changeSize / 100) * Constant.shortDimension;
  }

  double get vmax => (this / 100) * Constant.longDimension;

  double viewportMax({bool skipAspectRatio = false}) {
    final changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    return (changeSize / 100) * Constant.longDimension;
  }

  double get wp => (Constant.width * this) / 100;

  double get hp => (Constant.height * this) / 100;

  double sdp({bool skipAspectRatio = false}) {
    var changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    final dimen = Constant.getAvailableWidthDimension();
    if (dimen != 0) {
      final ratio = changeSize / Constant.dimenMin;
      changeSize = ratio * dimen;
    }
    return double.parse(changeSize.toStringAsFixed(2));
  }

  double ssp({bool skipAspectRatio = false}) {
    var changeSize = skipAspectRatio
        ? toDouble()
        : Constant.guideLineBaseAspectRatioFn(toDouble());
    final dimen = Constant.getAvailableWidthDimension();
    if (dimen != 0) {
      final ratio = changeSize / Constant.dimenMin;
      changeSize = ratio * dimen;
    }
    return double.parse(changeSize.toStringAsFixed(2)) * Constant.fontScale;
  }
}
