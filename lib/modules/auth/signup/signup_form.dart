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
    super.key,
    required this.navigationCallback,
    required this.homeCallback,
  });
  final void Function(String routeName) navigationCallback;
  final VoidCallback homeCallback;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState>? _signUpFormKey;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _signUpFormKey = GlobalKey();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _signUpFormKey = null;
    _nameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _nameController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
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
            focusNode: _nameFocusNode,
            controller: _nameController,
            prefixIcon: Icons.person,
            hintText: SignUpString.nameHint.tr(),
            validator: Validations.name,
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _nameFocusNode,
              to: _emailFocusNode,
            ),
            enabled: authProvider.status != Status.registering,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _emailController,
            focusNode: _emailFocusNode,
            prefixIcon: Icons.email_rounded,
            hintText: SignInString.emailHint.tr(),
            validator: Validations.email,
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _emailFocusNode,
              to: _passwordFocusNode,
            ),
            enabled: authProvider.status != Status.registering,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _passwordController,
            prefixIcon: Icons.lock,
            maxLines: 1,
            focusNode: _passwordFocusNode,
            hintText: SignInString.passwordHint.tr(),
            obscureTextWithSuffixIcon: true,
            validator: Validations.password,
            textInputAction: TextInputAction.done,
            onEditingComplete: _passwordFocusNode.unfocus,
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
                widget.navigationCallback(Routes.signIn);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_signUpFormKey!.currentState!.validate()) {
      final result = await authProvider.registerWithEmailAndPassword(
        _nameController!.text,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ErrorString.fbVerifyEmailError.tr())),
          );
        }
      });
    }
  }
}
