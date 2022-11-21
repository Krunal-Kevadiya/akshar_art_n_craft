import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../providers/providers.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        isFullScreen: true,
        title: VerifyEmailString.verifyEmailTitle.tr(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Background(
              bottomImage: Images.mainBottom,
              bottomLeft: 0,
              topLeft: 0,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.s),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Vectors.verify,
                      height: 50.hp,
                      width: 100.hp,
                    ),
                    Text(
                      ErrorString.fbVerifyEmail.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontSize: 15.ms,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20.vs),
                    ConditionBaseWidget(
                      isLoading: _isLoading,
                      isSeenProgress: true,
                      myWidget: RoundedButton(
                        title: VerifyEmailString.resentEmailButton.tr(),
                        backgroundColor: AppColors.primaryLightColor,
                        press: () {
                          _isValidate(authProvider);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _isValidate(AuthProvider authProvider) async {
    final result = await authProvider.sendEmailVerification();
    if (!mounted) return;
    result.when(
      (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      },
      (success) {},
    );
  }
}
