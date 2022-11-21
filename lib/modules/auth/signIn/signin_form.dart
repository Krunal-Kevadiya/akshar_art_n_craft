import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../providers/providers.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.navigationCallback,
    super.key,
  });
  // ignore: avoid_positional_boolean_parameters
  final void Function(String routeName, bool isRemoveUntil) navigationCallback;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState>? _signInFormKey;
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;

  @override
  void initState() {
    super.initState();
    _signInFormKey = GlobalKey();
    _focusNode = List<FocusNode>.generate(2, (int index) => FocusNode());
    _controller = List<TextEditingController>.generate(
      2,
      (int index) => TextEditingController(),
    );
    _focusNode[0].requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _signInFormKey = null;
    for (final node in _focusNode) {
      node.unfocus();
    }
    for (final input in _controller) {
      input.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _signInFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          RoundedInput(
            autoFocus: true,
            controller: _controller[0],
            focusNode: _focusNode[0],
            prefixIcon: Icons.email_rounded,
            validator: Validations.email,
            hintText: SignInString.emailHint.tr(),
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[0],
              to: _focusNode[1],
            ),
            enabled: authProvider.status != Status.authenticating,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _controller[1],
            focusNode: _focusNode[1],
            prefixIcon: Icons.lock,
            validator: Validations.password,
            hintText: SignInString.passwordHint.tr(),
            maxLines: 1,
            obscureTextWithSuffixIcon: true,
            textInputAction: TextInputAction.done,
            onEditingComplete: _focusNode[1].unfocus,
            onFieldSubmitted: (_) {
              _isValidate(authProvider);
            },
            enabled: authProvider.status != Status.authenticating,
          ),
          SizedBox(height: 16.vs),
          ConditionBaseWidget(
            isLoading: authProvider.status == Status.authenticating,
            isSeenProgress: true,
            myWidget: RoundedButton(
              title: SignInString.signInTitle.tr().toUpperCase(),
              press: () {
                _isValidate(authProvider);
              },
            ),
          ),
          SizedBox(height: 10.vs),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                if (authProvider.status != Status.authenticating) {
                  widget.navigationCallback(Routes.forgot, false);
                }
              },
              child: Text(
                SignInString.forgotPasswordLabel.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 14.ms,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          SizedBox(height: 32.vs),
          AlreadyHaveAnAccount(
            press: () {
              if (authProvider.status != Status.authenticating) {
                widget.navigationCallback(Routes.signUp, false);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_signInFormKey?.currentState?.validate() ?? false) {
      final result = await authProvider.signInWithEmailAndPassword(
        _controller[0].text,
        _controller[1].text,
      );
      if (!mounted) return;
      result.when((success) {
        if ((success.emailVerified ?? false) == true) {
          widget.navigationCallback(Routes.home, true);
        } else {
          widget.navigationCallback(Routes.verify, true);
        }
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }
}
