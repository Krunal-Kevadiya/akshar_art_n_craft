import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../themes/themes.dart';
import '../utils/utils.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.file,
    this.photoUrl,
    required this.name,
    this.onFileSubmitted,
    required this.enabled,
  });
  final bool enabled;
  final XFile? file;
  final String? photoUrl;
  final String name;
  final ValueChanged<XFile?>? onFileSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        MyBottomSheet.showImagePickerSheet(
          context: context,
          pickGallery: () async {
            if (enabled) {
              final photo = await MediaSelection.pickImage(
                context: context,
                source: ImageSource.gallery,
              );
              onFileSubmitted!(photo);
            }
          },
          pickCamera: () async {
            if (enabled) {
              final photo = await MediaSelection.pickImage(
                context: context,
                source: ImageSource.camera,
              );
              onFileSubmitted!(photo);
            }
          },
        );
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 55.s,
            backgroundColor: AppColors.gray.withOpacity(0.5),
            backgroundImage: file?.path != null
                ? FileImage(File(file!.path))
                : photoUrl != null
                    ? NetworkImage(photoUrl ?? '') as ImageProvider
                    : null,
            child: file?.path == null && photoUrl == null
                ? Text(
                    name.asInitialCharacter(),
                    style: theme.textTheme.caption?.copyWith(
                      color: AppColors.primaryLightColor,
                      fontSize: 35.ms,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
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
          )
        ],
      ),
    );
  }
}
