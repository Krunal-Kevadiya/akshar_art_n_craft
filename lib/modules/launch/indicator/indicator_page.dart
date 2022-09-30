import 'package:flutter/material.dart';

class IndicatorPage extends StatelessWidget {
  const IndicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
