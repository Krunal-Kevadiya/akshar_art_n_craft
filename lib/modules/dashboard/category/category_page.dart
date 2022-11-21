import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop By Category'),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: const Center(
        child: Text(
          'Back Panel',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
