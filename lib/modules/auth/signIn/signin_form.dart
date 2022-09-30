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
    super.key,
    required this.navigationCallback,
    required this.homeCallback,
  });
  final void Function(String routeName) navigationCallback;
  final VoidCallback homeCallback;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState>? _signInFormKey;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _signInFormKey = GlobalKey();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _signInFormKey = null;
    _emailController?.dispose();
    _passwordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final focusScope = FocusScope.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _signInFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          RoundedInput(
            autoFocus: true,
            controller: _emailController,
            prefixIcon: Icons.email_rounded,
            validator: Validations.email,
            hintText: SignInString.emailHint.tr(),
            onEditingComplete: focusScope.nextFocus,
            enabled: authProvider.status != Status.authenticating,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _passwordController,
            prefixIcon: Icons.lock,
            validator: Validations.password,
            hintText: SignInString.passwordHint.tr(),
            maxLines: 1,
            obscureTextWithSuffixIcon: true,
            textInputAction: TextInputAction.done,
            onEditingComplete: focusScope.unfocus,
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
                  widget.navigationCallback(Routes.forgot);
                }
              },
              child: Text(
                SignInString.forgotPasswordLabel.tr(),
                style: theme.textTheme.overline?.copyWith(
                  fontSize: 14.ms,
                  fontWeight: FontWeight.w300,
                  color: isDarkTheme
                      ? AppColors.primaryLightColor
                      : AppColors.primaryColor,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          SizedBox(height: 32.vs),
          AlreadyHaveAnAccount(
            press: () {
              if (authProvider.status != Status.authenticating) {
                widget.navigationCallback(Routes.signUp);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_signInFormKey!.currentState!.validate()) {
      final result = await authProvider.signInWithEmailAndPassword(
        _emailController!.text,
        _passwordController!.text,
      );
      if (!mounted) return;
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        if (success.emailVerified == true) {
          widget.homeCallback();
        } else {
          authProvider.sendEmailVerification();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ErrorString.fbVerifyEmailError.tr())),
          );
        }
      });
    }
  }
}
