import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../providers/providers.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.navigationCallback,
    super.key,
  });
  // ignore: avoid_positional_boolean_parameters
  final void Function(String routeName, bool isRemoveUntil) navigationCallback;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState>? _signUpFormKey;
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;

  @override
  void initState() {
    super.initState();
    _signUpFormKey = GlobalKey();
    _focusNode = List<FocusNode>.generate(3, (int index) => FocusNode());
    _controller = List<TextEditingController>.generate(
      3,
      (int index) => TextEditingController(),
    );
    _focusNode[0].requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _signUpFormKey = null;
    for (final node in _focusNode) {
      node.unfocus();
    }
    for (final input in _controller) {
      input.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _signUpFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          RoundedInput(
            autoFocus: true,
            focusNode: _focusNode[0],
            controller: _controller[0],
            prefixIcon: Icons.person,
            hintText: SignUpString.nameHint.tr(),
            validator: Validations.name,
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[0],
              to: _focusNode[1],
            ),
            enabled: authProvider.status != Status.registering,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _controller[1],
            focusNode: _focusNode[1],
            prefixIcon: Icons.email_rounded,
            hintText: SignInString.emailHint.tr(),
            validator: Validations.email,
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[1],
              to: _focusNode[2],
            ),
            enabled: authProvider.status != Status.registering,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _controller[2],
            prefixIcon: Icons.lock,
            maxLines: 1,
            focusNode: _focusNode[2],
            hintText: SignInString.passwordHint.tr(),
            obscureTextWithSuffixIcon: true,
            validator: Validations.password,
            textInputAction: TextInputAction.done,
            onEditingComplete: _focusNode[2].unfocus,
            onFieldSubmitted: (_) {
              _isValidate(authProvider);
            },
            enabled: authProvider.status != Status.registering,
          ),
          SizedBox(height: 16.vs),
          ConditionBaseWidget(
            isLoading: authProvider.status == Status.registering,
            isSeenProgress: true,
            myWidget: RoundedButton(
              title: SignUpString.signUpTitle.tr().toUpperCase(),
              press: () {
                _isValidate(authProvider);
              },
            ),
          ),
          SizedBox(height: 16.vs),
          AlreadyHaveAnAccount(
            signin: false,
            press: () {
              if (authProvider.status != Status.registering) {
                widget.navigationCallback(Routes.signIn, false);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_signUpFormKey?.currentState?.validate() ?? false) {
      final result = await authProvider.registerWithEmailAndPassword(
        _controller[0].text,
        _controller[1].text,
        _controller[2].text,
      );
      if (!mounted) return;
      result.when((success) {
        if ((success.emailVerified ?? false) == true) {
          widget.navigationCallback(Routes.home, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ErrorString.fbVerifyEmail.tr())),
          );
        }
      }, (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }
}
