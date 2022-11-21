import 'package:flutter/material.dart';

class ConditionBaseWidget extends StatelessWidget {
  const ConditionBaseWidget({
    required this.isLoading,
    required this.isSeenProgress,
    required this.myWidget,
    super.key,
  });

  final bool isLoading;
  final bool isSeenProgress;
  final Widget myWidget;

  @override
  Widget build(BuildContext context) {
    if (isLoading && isSeenProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (isLoading && !isSeenProgress) {
      return const Center();
    }
    return myWidget;
  }
}
