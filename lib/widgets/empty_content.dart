import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    required this.topImage,
    required this.title,
    required this.message,
    required this.press,
    super.key,
  });
  final String title;
  final String message;
  final String topImage;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(25.s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              topImage,
              width: 30.wp,
              height: 35.wp,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 40.vs),
            Text(
              title,
              style: theme.textTheme.labelSmall
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.ms),
            ),
            SizedBox(height: 10.vs),
            Text(
              message,
              style: theme.textTheme.labelSmall
                  ?.copyWith(fontWeight: FontWeight.w300, fontSize: 14.ms),
            ),
            const Spacer(),
            SizedBox(height: 10.vs),
            RoundedButton(
              title: CatalogString.addButton.tr().toUpperCase(),
              press: press,
            ),
          ],
        ),
      ),
    );
  }
}
