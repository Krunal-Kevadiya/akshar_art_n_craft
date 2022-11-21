import 'package:flutter/material.dart';

import '../themes/themes.dart';
import '../utils/utils.dart';

class RoundedInput extends StatefulWidget {
  const RoundedInput({
    super.key,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.iconColor,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.hintText = '',
    this.enabled = true,
    this.autoFocus = false,
    this.obscureText = false,
    this.obscureTextWithSuffixIcon = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final int? minLines;
  final int? maxLines;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool obscureText;
  final bool obscureTextWithSuffixIcon;
  final bool autoFocus;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<RoundedInput> createState() => _RoundedInputState();
}

class _RoundedInputState extends State<RoundedInput> {
  bool _obscureText = false;

  void _toggle() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText || widget.obscureTextWithSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final isMultiLines = widget.minLines != null && widget.maxLines != null;
    return TextFormField(
      autofocus: widget.autoFocus,
      enabled: widget.enabled,
      obscureText: _obscureText,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: widget.iconColor ??
          (isDarkTheme ? AppColors.primaryLightColor : AppColors.primaryColor),
      onFieldSubmitted: widget.onFieldSubmitted,
      textAlignVertical: TextAlignVertical.center,
      style: theme.textTheme.labelSmall
          ?.copyWith(fontSize: 14.ms, fontWeight: FontWeight.w400),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      decoration: customInputDecoration(
        theme: theme,
        isMultiLines: isMultiLines,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        iconColor: widget.iconColor,
        hintText: widget.hintText,
        obscureTextWithSuffixIcon: widget.obscureTextWithSuffixIcon,
        obscureText: _obscureText,
        toggle: _toggle,
      ).applyDefaults(theme.inputDecorationTheme),
    );
  }
}
