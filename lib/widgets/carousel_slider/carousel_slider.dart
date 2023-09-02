import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './carousel_controller.dart';
import './carousel_options.dart';
import './carousel_state.dart';
import './utils.dart';

export './carousel_controller.dart';
export './carousel_options.dart';
export './carousel_state.dart';

typedef ExtendedIndexedWidgetBuilder = Widget Function(
  BuildContext context,
  int index,
  int realIndex,
);

class CarouselSlider extends StatefulWidget {
  CarouselSlider({
    required this.items,
    required this.options,
    required this.carouselState,
    required this.index,
    this.disableGesture,
    CarouselController? carouselController,
    super.key,
  })  : itemBuilder = null,
        itemCount = items != null ? items.length : 0,
        _carouselController = carouselController != null
            ? carouselController as CarouselControllerImpl
            : CarouselController() as CarouselControllerImpl;

  /// The on demand item builder constructor
  CarouselSlider.builder({
    required this.itemCount,
    required this.itemBuilder,
    required this.options,
    required this.carouselState,
    required this.index,
    this.disableGesture,
    CarouselController? carouselController,
    super.key,
  })  : items = null,
        _carouselController = carouselController != null
            ? carouselController as CarouselControllerImpl
            : CarouselController() as CarouselControllerImpl;

  /// [CarouselOptions] to create a [CarouselState] with
  final CarouselOptions options;

  final bool? disableGesture;

  /// The widgets to be shown in the carousel of default constructor
  final List<Widget>? items;

  /// The widget item builder that will be used to build item on demand
  /// The third argument is the PageView's real index, can be used to cooperate
  /// with Hero.
  final ExtendedIndexedWidgetBuilder? itemBuilder;

  /// A [MapController], used to control the map.
  final CarouselControllerImpl _carouselController;

  final CarouselMultipleState carouselState;

  final int index;

  final int? itemCount;

  @override
  CarouselSliderState createState() => CarouselSliderState(_carouselController);
}

class CarouselSliderState extends State<CarouselSlider>
    with TickerProviderStateMixin {
  CarouselSliderState(this.carouselController);
  final CarouselControllerImpl carouselController;
  Timer? timer;

  CarouselOptions get options => widget.options;

  /// mode is related to why the page is being changed
  CarouselPageChangedReason mode = CarouselPageChangedReason.controller;

  void changeMode(CarouselPageChangedReason mode) {
    mode = mode;
  }

  @override
  void didUpdateWidget(CarouselSlider oldWidget) {
    widget.carouselState.options.insert(widget.index, options);
    widget.carouselState.itemCount = widget.itemCount;

    // pageController needs to be re-initialized to respond to state changes
    widget.carouselState.pageController.insert(
      widget.index,
      PageController(
        viewportFraction: options.viewportFraction,
        initialPage: widget.carouselState.realPage,
      ),
    );

    // handle autoplay when state changes
    handleAutoPlay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    widget.carouselState.onResetTimer.insert(widget.index, clearTimer);
    widget.carouselState.onResumeTimer.insert(widget.index, resumeTimer);
    widget.carouselState.changeMode.insert(widget.index, changeMode);
    widget.carouselState.options.insert(widget.index, options);
    widget.carouselState.options.insert(widget.index, options);

    widget.carouselState.itemCount = widget.itemCount;
    carouselController.state = widget.carouselState;
    widget.carouselState.initialPage = widget.options.initialPage;
    widget.carouselState.realPage = options.enableInfiniteScroll
        ? widget.carouselState.realPage + widget.carouselState.initialPage
        : widget.carouselState.initialPage;
    handleAutoPlay();

    widget.carouselState.pageController.insert(
      widget.index,
      PageController(
        viewportFraction: options.viewportFraction,
        initialPage: widget.carouselState.realPage,
      ),
    );
  }

  Timer? getTimer() {
    return widget.options.autoPlay
        ? Timer.periodic(widget.options.autoPlayInterval, (_) {
            if (!mounted) {
              clearTimer();
              return;
            }

            final route = ModalRoute.of(context);
            if (route?.isCurrent == false) {
              return;
            }

            final previousReason = mode;
            changeMode(CarouselPageChangedReason.timed);
            var nextPage = widget
                    .carouselState.pageController[widget.index]!.page!
                    .round() +
                1;
            final itemCount = widget.itemCount ?? widget.items!.length;

            if (nextPage >= itemCount &&
                widget.options.enableInfiniteScroll == false) {
              if (widget.options.pauseAutoPlayInFiniteScroll) {
                clearTimer();
                return;
              }
              nextPage = 0;
            }

            widget.carouselState.pageController[widget.index]!
                .animateToPage(
                  nextPage,
                  duration: widget.options.autoPlayAnimationDuration,
                  curve: widget.options.autoPlayCurve,
                )
                .then((_) => changeMode(previousReason));
          })
        : null;
  }

  void clearTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void resumeTimer() {
    timer ??= getTimer();
  }

  void handleAutoPlay() {
    final autoPlayEnabled = widget.options.autoPlay;

    if (autoPlayEnabled && timer != null) return;

    clearTimer();
    if (autoPlayEnabled) {
      resumeTimer();
    }
  }

  Widget getGestureWrapper(Widget child) {
    Widget wrapper;
    if (widget.options.height != null) {
      wrapper = SizedBox(height: widget.options.height, child: child);
    } else {
      wrapper =
          AspectRatio(aspectRatio: widget.options.aspectRatio, child: child);
    }

    if (true == widget.disableGesture) {
      return NotificationListener(
        onNotification: (Notification notification) {
          if (widget.options.onScrolled != null &&
              notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(
              widget.carouselState.pageController[widget.index]!.page,
            );
          }
          return false;
        },
        child: wrapper,
      );
    }

    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        _MultipleGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_MultipleGestureRecognizer>(
                _MultipleGestureRecognizer.new,
                (_MultipleGestureRecognizer instance) {
          instance.onStart = (_) {
            onStart();
          };
          instance.onDown = (_) {
            onPanDown();
          };
          instance.onEnd = (_) {
            onPanUp();
          };
          instance.onCancel = onPanUp;
        }),
      },
      child: NotificationListener(
        onNotification: (Notification notification) {
          if (widget.options.onScrolled != null &&
              notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(
              widget.carouselState.pageController[widget.index]!.page,
            );
          }
          return false;
        },
        child: wrapper,
      ),
    );
  }

  Widget getCenterWrapper(Widget child) {
    if (widget.options.disableCenter) {
      return Container(
        child: child,
      );
    }
    return Center(child: child);
  }

  Widget getEnlargeWrapper(
    Widget? child, {
    required double itemOffset,
    double? width,
    double? height,
    double? scale,
  }) {
    if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.height) {
      return SizedBox(width: width, height: height, child: child);
    }
    if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.zoom) {
      late Alignment alignment;
      final horizontal = options.scrollDirection == Axis.horizontal;
      if (itemOffset > 0) {
        alignment = horizontal ? Alignment.centerRight : Alignment.bottomCenter;
      } else {
        alignment = horizontal ? Alignment.centerLeft : Alignment.topCenter;
      }
      return Transform.scale(scale: scale, alignment: alignment, child: child);
    }
    return Transform.scale(
      scale: scale,
      child: SizedBox(width: width, height: height, child: child),
    );
  }

  void onStart() {
    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanDown() {
    if (widget.options.pauseAutoPlayOnTouch) {
      clearTimer();
    }

    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanUp() {
    if (widget.options.pauseAutoPlayOnTouch) {
      resumeTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    clearTimer();
  }

  @override
  Widget build(BuildContext context) {
    return getGestureWrapper(
      PageView.builder(
        padEnds: widget.options.padEnds,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        clipBehavior: widget.options.clipBehavior,
        physics: widget.options.scrollPhysics,
        scrollDirection: widget.options.scrollDirection,
        pageSnapping: widget.options.pageSnapping,
        controller: widget.carouselState.pageController[widget.index],
        reverse: widget.options.reverse,
        itemCount:
            widget.options.enableInfiniteScroll ? null : widget.itemCount,
        key: widget.options.pageViewKey,
        onPageChanged: (int index) {
          final currentPage = getRealIndex(
            index + widget.carouselState.initialPage,
            widget.carouselState.realPage,
            widget.itemCount,
          );
          if (widget.options.onPageChanged != null) {
            widget.options.onPageChanged?.call(currentPage, mode);
          }
        },
        itemBuilder: (BuildContext context, int idx) {
          final index = getRealIndex(
            idx + widget.carouselState.initialPage,
            widget.carouselState.realPage,
            widget.itemCount,
          );

          return AnimatedBuilder(
            animation: widget.carouselState.pageController[widget.index]!,
            child: (widget.items != null)
                ? (widget.items!.isNotEmpty
                    ? widget.items![index]
                    : Container())
                : widget.itemBuilder!(context, index, idx),
            builder: (BuildContext context, child) {
              var distortionValue = 1.0;
              // if `enlargeCenterPage` is true, we must calculate the carousel
              //item's height to display the visual effect
              var itemOffset = 0.0;
              if (widget.options.enlargeCenterPage != null &&
                  widget.options.enlargeCenterPage == true) {
                //pageController.page can only be accessed after the first build
                // so in the first build we calculate the itemoffset manually
                final position =
                    widget.carouselState.pageController[widget.index]?.position;
                if (position != null &&
                    position.hasPixels &&
                    position.hasContentDimensions) {
                  final page =
                      widget.carouselState.pageController[widget.index]?.page;
                  if (page != null) {
                    itemOffset = page - idx;
                  }
                } else {
                  final storageContext = widget
                      .carouselState
                      .pageController[widget.index]!
                      .position
                      .context
                      .storageContext;
                  final previousSavedPosition = PageStorage.of(storageContext)
                      ?.readState(storageContext) as double?;
                  if (previousSavedPosition != null) {
                    itemOffset = previousSavedPosition - idx.toDouble();
                  } else {
                    itemOffset = widget.carouselState.realPage.toDouble() -
                        idx.toDouble();
                  }
                }

                final enlargeFactor = options.enlargeFactor.clamp(0.0, 1.0);
                final num distortionRatio =
                    (1 - (itemOffset.abs() * enlargeFactor)).clamp(0.0, 1.0);
                distortionValue =
                    Curves.easeOut.transform(distortionRatio as double);
              }

              final height = widget.options.height ??
                  MediaQuery.of(context).size.width *
                      (1 / widget.options.aspectRatio);

              if (widget.options.scrollDirection == Axis.horizontal) {
                return getCenterWrapper(
                  getEnlargeWrapper(
                    child,
                    height: distortionValue * height,
                    scale: distortionValue,
                    itemOffset: itemOffset,
                  ),
                );
              } else {
                return getCenterWrapper(
                  getEnlargeWrapper(
                    child,
                    width: distortionValue * MediaQuery.of(context).size.width,
                    scale: distortionValue,
                    itemOffset: itemOffset,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _MultipleGestureRecognizer extends PanGestureRecognizer {}
