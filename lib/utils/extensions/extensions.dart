import 'package:flutter/material.dart';

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
