import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    super.key,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  XFile? _file;
  GlobalKey<FormState>? _profileFormKey;
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;

  @override
  void initState() {
    super.initState();
    _profileFormKey = GlobalKey();
    _focusNode = List<FocusNode>.generate(5, (int index) => FocusNode());
    _controller = List<TextEditingController>.generate(
      5,
      (int index) => TextEditingController(),
    );
    _focusNode[0].requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _file = null;
    _profileFormKey = null;
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

    return StreamBuilder(
      stream: authProvider.user,
      builder: (context, snapshot) {
        final user = snapshot.data as UserModel?;
        if (user != null && authProvider.status != Status.profiling) {
          updateControllers(user);
        }
        return Form(
          key: _profileFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              ProfileAvatar(
                file: _file,
                size: 110,
                photoUrl: user?.photoUrl,
                name: user?.displayName ?? '',
                onFileSubmitted: (photo) {
                  setState(() => _file = photo);
                },
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 32.vs),
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
                enabled: authProvider.status != Status.profiling,
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
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 16.vs),
              RoundedInput(
                controller: _controller[2],
                focusNode: _focusNode[2],
                prefixIcon: Icons.phone,
                hintText: ProfileString.phoneHint.tr(),
                validator: Validations.phone,
                onEditingComplete: () => fieldFocusChange(
                  context: context,
                  from: _focusNode[2],
                  to: _focusNode[3],
                ),
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 16.vs),
              RoundedInput(
                controller: _controller[3],
                prefixIcon: Icons.lock,
                maxLines: 1,
                focusNode: _focusNode[3],
                hintText: SignInString.passwordHint.tr(),
                obscureTextWithSuffixIcon: true,
                validator: Validations.changePassword,
                onEditingComplete: () => fieldFocusChange(
                  context: context,
                  from: _focusNode[3],
                  to: _focusNode[4],
                ),
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 16.vs),
              RoundedInput(
                controller: _controller[4],
                prefixIcon: Icons.lock_outline,
                maxLines: 1,
                focusNode: _focusNode[4],
                hintText: ProfileString.confirmPasswordHint.tr(),
                obscureTextWithSuffixIcon: true,
                validator: Validations.confirmPassword(_controller[3].text),
                textInputAction: TextInputAction.done,
                onEditingComplete: _focusNode[4].unfocus,
                onFieldSubmitted: (_) {
                  _isValidate(authProvider);
                },
                enabled: authProvider.status != Status.profiling,
              ),
              const Spacer(),
              SizedBox(height: 16.vs),
              ConditionBaseWidget(
                isLoading: authProvider.status == Status.profiling,
                isSeenProgress: true,
                myWidget: RoundedButton(
                  title: ProfileString.saveButton.tr().toUpperCase(),
                  press: () {
                    _isValidate(authProvider);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void updateControllers(UserModel user) {
    _controller[0] = TextEditingController(text: user.displayName ?? '');
    _controller[0].selection = TextSelection.fromPosition(
      TextPosition(offset: _controller[0].text.length),
    );
    _controller[1] = TextEditingController(text: user.email ?? '');
    _controller[1].selection = TextSelection.fromPosition(
      TextPosition(offset: _controller[1].text.length),
    );
    _controller[2] = TextEditingController(text: user.phoneNumber ?? '');
    _controller[2].selection = TextSelection.fromPosition(
      TextPosition(offset: _controller[2].text.length),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_profileFormKey?.currentState?.validate() ?? false) {
      final result = await authProvider.updateProfile(
        _controller[0].text,
        _controller[1].text,
        _controller[2].text,
        _controller[3].text,
        _file,
      );
      if (!mounted) return;
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ProfileString.msgUpdatedProfile.tr())),
        );
        setState(() => _file = null);
        _focusNode[0].requestFocus();
      });
    }
  }
}
