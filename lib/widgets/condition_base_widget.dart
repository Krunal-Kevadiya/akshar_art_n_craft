import 'package:flutter/material.dart';

class ConditionBaseWidget extends StatelessWidget {
  const ConditionBaseWidget(
      {super.key,
      required this.isLoading,
      required this.isSeenProgress,
      required this.myWidget,});

  final bool isLoading, isSeenProgress;
  final Widget myWidget;

  @override
  Widget build(BuildContext context) {
    if (isLoading && isSeenProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (isLoading && !isSeenProgress) {
      return const Center(
        
      );
    }
    return myWidget;
  }
}
