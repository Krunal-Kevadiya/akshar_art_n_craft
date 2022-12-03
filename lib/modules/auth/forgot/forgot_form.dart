import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../providers/providers.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ForgotForm extends StatefulWidget {
  const ForgotForm({
    super.key,
  });

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  GlobalKey<FormState>? _forgotFormKey;
  late FocusNode _emailFocusNode;
  TextEditingController? _emailController;

  @override
  void initState() {
    super.initState();
    _forgotFormKey = GlobalKey();
    _emailFocusNode = FocusNode();
    _emailController = TextEditingController();
    _emailFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _forgotFormKey = null;
    _emailFocusNode.unfocus();
    _emailController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _forgotFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          RoundedInput(
            autoFocus: true,
            controller: _emailController,
            focusNode: _emailFocusNode,
            prefixIcon: Icons.email_rounded,
            hintText: SignInString.emailHint.tr(),
            validator: Validations.email,
            textInputAction: TextInputAction.done,
            onEditingComplete: _emailFocusNode.unfocus,
            onFieldSubmitted: (_) {
              _isValidate(authProvider);
            },
            enabled: authProvider.status != Status.forgetting,
          ),
          SizedBox(height: 16.vs),
          ConditionBaseWidget(
            isLoading: authProvider.status == Status.forgetting,
            isSeenProgress: true,
            myWidget: RoundedButton(
              title:
                  ForgotPasswordString.forgotPasswordTitle.tr().toUpperCase(),
              press: () {
                _isValidate(authProvider);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_forgotFormKey!.currentState!.validate()) {
      final result =
          await authProvider.sendPasswordResetEmail(_emailController!.text);
      if (!mounted) return;
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        Navigator.of(context).pop();
      });
    }
  }
}
