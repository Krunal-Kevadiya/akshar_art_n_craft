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
        handleTap(context);
      },
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.zero, // Border width
            height: onFileSubmitted != null ? 110.s : double.infinity,
            width: onFileSubmitted != null ? 110.s : double.infinity,
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.5),
              borderRadius:
                  BorderRadius.circular(onFileSubmitted != null ? 55.s : 10.s),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(onFileSubmitted != null ? 55.s : 10.s),
              child: file?.path != null
                  ? Image.file(
                      File(file!.path),
                      fit: BoxFit.fill,
                    )
                  : file?.path == null && photoUrl != null && photoUrl != ''
                      ? Image.network(
                          photoUrl ?? '',
                          fit: BoxFit.fill,
                        )
                      : Center(
                          child: Text(
                            name.asInitialCharacter(),
                            style: theme.textTheme.caption?.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: onFileSubmitted != null ? 35.ms : 25.ms,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
            )
        ],
      ),
    );
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
          onFileSubmitted!(photo);
        },
        pickCamera: () async {
          final photo = await MediaSelection.pickImage(
            context: context,
            source: ImageSource.camera,
          );
          onFileSubmitted!(photo);
        },
      );
    }
  }
}
