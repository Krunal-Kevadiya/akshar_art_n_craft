import 'package:flutter/material.dart';
import '../themes/themes.dart';

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
  final int? minLines, maxLines;
  final IconData? suffixIcon, prefixIcon;
  final Color? iconColor, backgroundColor;
  final bool obscureText, obscureTextWithSuffixIcon, autoFocus, enabled;
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
      style: theme.textTheme.overline
          ?.copyWith(fontSize: 14.ms, fontWeight: FontWeight.w400),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: widget.iconColor,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Icon(
                widget.suffixIcon,
                color: widget.iconColor,
              )
            : widget.obscureTextWithSuffixIcon
                ? GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: widget.iconColor,
                    ),
                  )
                : null,
        labelText: widget.hintText,
        contentPadding: EdgeInsets.only(
          top: isMultiLines ? 10.s : 0,
          bottom: isMultiLines ? 10.s : 0,
          right: isMultiLines ? 10.s : 0,
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
        errorBorder:
            (theme.inputDecorationTheme.errorBorder as OutlineInputBorder?)
                ?.copyWith(
          borderRadius:
              BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
        ),
        focusedErrorBorder: (theme.inputDecorationTheme.focusedErrorBorder
                as OutlineInputBorder?)
            ?.copyWith(
          borderRadius:
              BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
        ),
      ).applyDefaults(theme.inputDecorationTheme),
    );
  }
}
