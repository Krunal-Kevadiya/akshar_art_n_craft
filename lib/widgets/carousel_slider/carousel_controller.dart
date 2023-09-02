import 'dart:async';

import 'package:flutter/material.dart';

import './carousel_options.dart';
import './carousel_state.dart';
import './utils.dart';

abstract class CarouselController {
  factory CarouselController() => CarouselControllerImpl();
  bool get ready;

  Future<void> get onReady;

  Future<void> nextPage({Duration? duration, Curve? curve});

  Future<void> previousPage({Duration? duration, Curve? curve});

  void jumpToPage(int page);

  Future<void> animateToPage(int page, {Duration? duration, Curve? curve});

  void startAutoPlay();

  void stopAutoPlay();
}

class CarouselControllerImpl implements CarouselController {
  final Completer<void> _readyCompleter = Completer<void>();

  CarouselMultipleState? _state;

  set state(CarouselMultipleState? state) {
    _state = state;
    if (!_readyCompleter.isCompleted) {
      _readyCompleter.complete();
    }
  }

  void _setModeController(int index) =>
      _state!.changeMode[index]?.call(CarouselPageChangedReason.controller);

  @override
  bool get ready => _state != null;

  @override
  Future<void> get onReady => _readyCompleter.future;

  /// Animates the controlled [CarouselSlider] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> nextPage({
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    for (var i = 0; i < _state!.options.length; i++) {
      final isNeedResetTimer =
          _state!.options[i]!.pauseAutoPlayOnManualNavigate;
      if (isNeedResetTimer) {
        _state!.onResetTimer[i]?.call();
      }
      _setModeController(i);
      await _state!.pageController[i]
          ?.nextPage(duration: duration!, curve: curve!);
      if (isNeedResetTimer) {
        _state!.onResumeTimer[i]?.call();
      }
    }
  }

  /// Animates the controlled [CarouselSlider] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> previousPage({
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    for (var i = 0; i < _state!.options.length; i++) {
      final isNeedResetTimer =
          _state!.options[i]!.pauseAutoPlayOnManualNavigate;
      if (isNeedResetTimer) {
        _state!.onResetTimer[i]?.call();
      }
      _setModeController(i);
      await _state!.pageController[i]
          ?.previousPage(duration: duration!, curve: curve!);
      if (isNeedResetTimer) {
        _state!.onResumeTimer[i]?.call();
      }
    }
  }

  /// Changes which page is displayed in the controlled [CarouselSlider].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  @override
  void jumpToPage(int page) {
    for (var i = 0; i < _state!.options.length; i++) {
      final index = getRealIndex(
        _state!.pageController[i]!.page!.toInt(),
        _state!.realPage - _state!.initialPage,
        _state!.itemCount,
      );

      _setModeController(i);
      final pageToJump =
          _state!.pageController[i]!.page!.toInt() + page - index;
      _state!.pageController[i]?.jumpToPage(pageToJump);
    }

    final index = getRealIndex(
      _state!.pageController[0]!.page!.toInt(),
      _state!.realPage - _state!.initialPage,
      _state!.itemCount,
    );
    final pageToJump = _state!.pageController[0]!.page!.toInt() + page - index;
    return _state!.pageController[0]?.jumpToPage(pageToJump);
  }

  /// Animates the controlled [CarouselSlider] from the current page to
  /// the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> animateToPage(
    int page, {
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    for (var i = 0; i < _state!.options.length; i++) {
      final isNeedResetTimer =
          _state!.options[i]!.pauseAutoPlayOnManualNavigate;
      if (isNeedResetTimer) {
        _state!.onResetTimer[i]?.call();
      }
      final index = getRealIndex(
        _state!.pageController[i]!.page!.toInt(),
        _state!.realPage - _state!.initialPage,
        _state!.itemCount,
      );
      var smallestMovement = page - index;
      if (_state!.options[i]!.enableInfiniteScroll &&
          _state!.itemCount != null &&
          _state!.options[i]!.animateToClosest) {
        if ((page - index).abs() > (page + _state!.itemCount! - index).abs()) {
          smallestMovement = page + _state!.itemCount! - index;
        } else if ((page - index).abs() >
            (page - _state!.itemCount! - index).abs()) {
          smallestMovement = page - _state!.itemCount! - index;
        }
      }
      _setModeController(i);
      await _state!.pageController[i]!.animateToPage(
        _state!.pageController[i]!.page!.toInt() + smallestMovement,
        duration: duration!,
        curve: curve!,
      );
      if (isNeedResetTimer) {
        _state!.onResumeTimer[i]?.call();
      }
    }
  }

  /// Starts the controlled [CarouselSlider] autoplay.
  ///
  /// The carousel will only autoPlay if the [autoPlay] parameter
  /// in [CarouselOptions] is true.
  @override
  void startAutoPlay() {
    for (var i = 0; i < _state!.options.length; i++) {
      _state!.onResumeTimer[i]?.call();
    }
  }

  /// Stops the controlled [CarouselSlider] from autoplaying.
  ///
  /// This is a more on-demand way of doing this. Use the [autoPlay]
  /// parameter in [CarouselOptions] to specify the autoPlay behaviour
  /// of the carousel.
  @override
  void stopAutoPlay() {
    for (var i = 0; i < _state!.options.length; i++) {
      _state!.onResetTimer[i]?.call();
    }
  }
}
