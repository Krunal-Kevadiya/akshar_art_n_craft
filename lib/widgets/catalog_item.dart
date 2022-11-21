import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import './profile_avatar.dart';
import '../constants/constants.dart';
import '../themes/themes.dart';
import '../utils/utils.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({
    required this.index,
    required this.isDelete,
    required this.enabled,
    required this.name,
    super.key,
    this.startPressed,
    this.endPressed,
    this.onClicked,
    this.photoUrl,
    this.description,
  });
  final int index;
  final String name;
  final bool isDelete;
  final bool enabled;
  final VoidCallback? onClicked;
  final String? photoUrl;
  final String? description;
  final void Function(BuildContext)? startPressed;
  final void Function(BuildContext)? endPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        key: ValueKey(index),
        enabled: enabled,
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              startPressed?.call(context);
            },
          ),
          children: [
            SlidableAction(
              onPressed: startPressed,
              backgroundColor: AppColors.green,
              foregroundColor: AppColors.white,
              icon: Icons.edit,
              label: CatalogString.editButton.tr(),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              endPressed?.call(context);
            },
          ),
          children: [
            SlidableAction(
              onPressed: endPressed,
              backgroundColor: isDelete ? AppColors.red : AppColors.yellow,
              foregroundColor: AppColors.white,
              icon: isDelete ? Icons.delete : Icons.undo,
              label: isDelete
                  ? CatalogString.deleteButton.tr()
                  : CatalogString.undoButton.tr(),
            ),
          ],
        ),
        child: InkWell(
          onTap: onClicked,
          borderRadius: BorderRadius.circular(
            10.s,
          ),
          child: IgnorePointer(
            child: mainCard(theme),
          ),
        ),
      ),
    );
  }

  Widget mainCard(
    ThemeData theme,
  ) {
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Stack(
      children: [
        ProfileAvatar(
          photoUrl: photoUrl,
          name: name,
          enabled: false,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: (isDarkTheme ? AppColors.white : AppColors.black)
                  .withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.s),
                bottomRight: Radius.circular(10.s),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.s,
              vertical: 5.vs,
            ),
            child: titleAndDescription(theme),
          ),
        ),
      ],
    );
  }

  Widget titleAndDescription(
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name.trim().capitalize(),
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13.ms,
          ),
        ),
        Text(
          description?.trim().capitalize() ?? '',
          maxLines: 2,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.ms,
          ),
        )
      ],
    );
  }
}
