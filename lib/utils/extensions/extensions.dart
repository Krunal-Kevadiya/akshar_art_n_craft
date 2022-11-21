import 'package:flutter/material.dart';

import '../../themes/themes.dart';

export './color_extension.dart';
export './file_extension.dart';
export './string_extension.dart';

void fieldFocusChange({
  required BuildContext context,
  required FocusNode from,
  required FocusNode to,
}) {
  from.unfocus();
  FocusScope.of(context).requestFocus(to);
}

InputDecoration customInputDecoration({
  required ThemeData theme,
  required String hintText,
  bool isMultiLines = false,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Color? iconColor,
  bool obscureTextWithSuffixIcon = false,
  bool obscureText = false,
  VoidCallback? toggle,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon != null
        ? Icon(
            prefixIcon,
            size: 25.s,
            color: iconColor,
          )
        : null,
    suffixIcon: suffixIcon != null
        ? Icon(
            suffixIcon,
            size: 25.s,
            color: iconColor,
          )
        : obscureTextWithSuffixIcon
            ? GestureDetector(
                onTap: toggle,
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  size: 25.s,
                  color: iconColor,
                ),
              )
            : null,
    labelText: hintText,
    contentPadding: EdgeInsets.only(
      top: isMultiLines ? 10.s : 0,
      bottom: isMultiLines ? 10.s : 0,
      right: isMultiLines ? 10.s : 0,
      left: isMultiLines
          ? 0
          : prefixIcon == null
              ? 20.s
              : 0,
    ),
    enabledBorder:
        (theme.inputDecorationTheme.enabledBorder as OutlineInputBorder?)
            ?.copyWith(
      borderRadius:
          BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
    ),
    disabledBorder:
        (theme.inputDecorationTheme.disabledBorder as OutlineInputBorder?)
            ?.copyWith(
      borderRadius:
          BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
    ),
    focusedBorder:
        (theme.inputDecorationTheme.focusedBorder as OutlineInputBorder?)
            ?.copyWith(
      borderRadius:
          BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
    ),
    errorBorder: (theme.inputDecorationTheme.errorBorder as OutlineInputBorder?)
        ?.copyWith(
      borderRadius:
          BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
    ),
    focusedErrorBorder:
        (theme.inputDecorationTheme.focusedErrorBorder as OutlineInputBorder?)
            ?.copyWith(
      borderRadius:
          BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
    ),
  );
}
