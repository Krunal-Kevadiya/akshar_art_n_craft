import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constants.dart';
import '../themes/themes.dart';

class MyBottomSheet {
  static Future<bool?> showSheet({
    required BuildContext context,
    required Widget widget,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.s),
          topRight: Radius.circular(20.s),
        ),
      ),
      builder: (context) {
        return Wrap(
          spacing: 20.s,
          children: [
            Container(
              height: 40.s,
              width: 100.wp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.s),
                  topRight: Radius.circular(20.s),
                ),
              ),
              child: Container(
                height: 5.s,
                width: 20.s,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(99.s)),
                ),
              ),
            ),
            SizedBox(height: 10.s),
            widget,
            SizedBox(height: 50.s),
          ],
        );
      },
    );
  }

  static Future<bool?> showImagePickerSheet({
    required BuildContext context,
    required VoidCallback pickGallery,
    required VoidCallback pickCamera,
  }) {
    final theme = Theme.of(context);
    return showSheet(
      context: context,
      widget: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: Text(
              SheetString.pickFromGalleryLabel.tr(),
              style: theme.textTheme.overline?.copyWith(fontSize: 16.ms),
            ),
            onTap: () {
              Navigator.pop(context);
              pickGallery();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: Text(
              SheetString.pickFromCameraLabel.tr(),
              style: theme.textTheme.overline?.copyWith(fontSize: 16.ms),
            ),
            onTap: () {
              Navigator.pop(context);
              pickCamera();
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: Text(
              SheetString.cancelButton.tr(),
              style: theme.textTheme.overline?.copyWith(fontSize: 16.ms),
            ),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  static Future<bool?> showPermissionSheet({
    required BuildContext context,
    required String title,
    required String message,
    String? svg,
    required String labelPositive,
    String? labelNegative,
    required VoidCallback pickPositive,
    VoidCallback? pickNegative,
  }) {
    final theme = Theme.of(context);
    return showSheet(
      context: context,
      widget: Column(
        children: [
          if (svg != null)
            Container(
              padding: EdgeInsets.all(30.s),
              decoration: const BoxDecoration(
                color: AppColors.primaryLightColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(svg),
            ),
          SizedBox(height: 26.s),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.overline
                ?.copyWith(fontSize: 16.ms, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.s),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.s),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.overline?.copyWith(
                fontSize: 16.ms,
                fontWeight: FontWeight.normal,
                color: AppColors.gray,
              ),
            ),
          ),
          SizedBox(height: 25.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  minLeadingWidth: 30.s,
                  leading: const Icon(Icons.cancel),
                  title: Text(
                    labelNegative ?? SheetString.cancelButton.tr(),
                    style: theme.textTheme.overline?.copyWith(fontSize: 16.ms),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (pickNegative != null) {
                      pickNegative();
                    }
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  minLeadingWidth: 30.s,
                  leading: const Icon(Icons.image_outlined),
                  title: Text(
                    labelPositive,
                    style: theme.textTheme.overline?.copyWith(fontSize: 16.ms),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickPositive();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
