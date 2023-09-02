import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../themes/themes.dart';
import '../utils/utils.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.name,
    required this.enabled,
    super.key,
    this.file,
    this.photoUrl,
    this.size,
    this.onFileSubmitted,
  });
  final double? size;
  final bool enabled;
  final XFile? file;
  final String? photoUrl;
  final String name;
  final ValueChanged<XFile?>? onFileSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(
        size != null ? (size! / 2).s : 10.s,
      ),
      onTap: () {
        handleTap(context);
      },
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.zero, // Border width
            height: size != null ? size!.s : double.infinity,
            width: size != null ? size!.s : double.infinity,
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(
                size != null ? (size! / 2).s : 10.s,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                size != null ? (size! / 2).s : 10.s,
              ),
              child: imageView(theme),
            ),
          ),
          if (onFileSubmitted != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 32.s,
                width: 32.s,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16.s),
                ),
                child: Icon(
                  Icons.edit,
                  size: 20.s,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget imageView(ThemeData theme) {
    if (file?.path != null) {
      return Image.file(
        File(file!.path),
        fit: BoxFit.fill,
      );
    } else if (photoUrl != null && photoUrl != '') {
      return CachedNetworkImage(
        imageUrl: photoUrl ?? '',
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.image),
        fadeInDuration: const Duration(seconds: 3),
        fit: BoxFit.fill,
      );
    } else {
      return Center(
        child: Text(
          name.asInitialCharacter(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: size != null ? (size! / 2 - 20).ms : 25.ms,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  void handleTap(BuildContext context) {
    if (enabled) {
      MyBottomSheet.showImagePickerSheet(
        context: context,
        pickGallery: () async {
          final photo = await MediaSelection.pickImage(
            context: context,
            source: ImageSource.gallery,
          );
          onFileSubmitted?.call(photo);
        },
        pickCamera: () async {
          final photo = await MediaSelection.pickImage(
            context: context,
            source: ImageSource.camera,
          );
          onFileSubmitted?.call(photo);
        },
      );
    }
  }
}
