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
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _profileFormKey = GlobalKey();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _file = null;
    _profileFormKey = null;
    _nameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _phoneFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
    _nameController?.dispose();
    _emailController?.dispose();
    _phoneController?.dispose();
    _passwordController?.dispose();
    _confirmPasswordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder(
      stream: authProvider.user,
      builder: (context, snapshot) {
        final user = snapshot.data as UserModel?;
        updateControllers(user);

        return Form(
          key: _profileFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 32.vs),
              ProfileAvatar(
                file: _file,
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
                enabled: authProvider.status != Status.profiling,
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
                  to: _phoneFocusNode,
                ),
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 16.vs),
              RoundedInput(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                prefixIcon: Icons.phone,
                hintText: ProfileString.phoneHint.tr(),
                validator: Validations.phone,
                onEditingComplete: () => fieldFocusChange(
                  context: context,
                  from: _phoneFocusNode,
                  to: _passwordFocusNode,
                ),
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 16.vs),
              RoundedInput(
                controller: _passwordController,
                prefixIcon: Icons.lock,
                maxLines: 1,
                focusNode: _passwordFocusNode,
                hintText: SignInString.passwordHint.tr(),
                obscureTextWithSuffixIcon: true,
                validator: Validations.changePassword,
                onEditingComplete: () => fieldFocusChange(
                  context: context,
                  from: _passwordFocusNode,
                  to: _confirmPasswordFocusNode,
                ),
                enabled: authProvider.status != Status.profiling,
              ),
              SizedBox(height: 16.vs),
              RoundedInput(
                controller: _confirmPasswordController,
                prefixIcon: Icons.lock_outline,
                maxLines: 1,
                focusNode: _confirmPasswordFocusNode,
                hintText: ProfileString.confirmPasswordHint.tr(),
                obscureTextWithSuffixIcon: true,
                validator:
                    Validations.confirmPassword(_passwordController?.text),
                textInputAction: TextInputAction.done,
                onEditingComplete: _confirmPasswordFocusNode.unfocus,
                onFieldSubmitted: (_) {
                  _isValidate(authProvider);
                },
                enabled: authProvider.status != Status.profiling,
              ),
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

  void updateControllers(UserModel? user) {
    _nameController?.text = user?.displayName ?? '';
    _nameController?.selection = TextSelection.fromPosition(
      TextPosition(offset: _nameController?.text.length ?? 0),
    );
    _emailController?.text = user?.email ?? '';
    _emailController?.selection = TextSelection.fromPosition(
      TextPosition(offset: _emailController?.text.length ?? 0),
    );
    _phoneController?.text = user?.phoneNumber ?? '';
    _phoneController?.selection = TextSelection.fromPosition(
      TextPosition(offset: _phoneController?.text.length ?? 0),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    if (_profileFormKey!.currentState!.validate()) {
      final result = await authProvider.updateProfile(
        _nameController!.text,
        _emailController!.text,
        _phoneController!.text,
        _passwordController!.text,
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
      });
    }
  }
}
