import 'package:flutter/material.dart';

import './carousel_slider.dart';

class CarouselMultipleState {
  CarouselMultipleState({int size = 1}) {
    options = List<CarouselOptions?>.filled(size, null);
    onResetTimer = List<Function?>.filled(size, null);
    onResumeTimer = List<Function?>.filled(size, null);
    pageController = List<PageController?>.filled(size, null);
    // ignore: inference_failure_on_function_return_type
    changeMode = List<Function(CarouselPageChangedReason)?>.filled(size, null);
  }

  /// The [CarouselOptions] to create this state
  late List<CarouselOptions?> options;

  /// [pageController] is created using the properties passed to the constructor
  /// and can be used to control the [PageView] it is passed to.
  late List<PageController?> pageController;

  /// The actual index of the [PageView].
  ///
  /// This value can be ignored unless you know the carousel will be scrolled
  /// backwards more then 10000 pages.
  /// Defaults to 10000 to simulate infinite backwards scrolling.
  int realPage = 10000;

  /// The initial index of the [PageView] on [CarouselSlider] init.
  ///
  int initialPage = 0;

  /// The widgets count that should be shown at carousel
  int? itemCount;

  /// Will be called when using pageController to go to next page or
  /// previous page. It will clear the autoPlay timer.
  /// Internal use only
  late List<Function?> onResetTimer;

  /// Will be called when using pageController to go to next page or
  /// previous page. It will restart the autoPlay timer.
  /// Internal use only
  late List<Function?> onResumeTimer;

  /// The callback to set the Reason Carousel changed
  // ignore: inference_failure_on_function_return_type
  late List<Function(CarouselPageChangedReason)?> changeMode;
}
