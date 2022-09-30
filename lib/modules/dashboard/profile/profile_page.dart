import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './profile_form.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProfileString.profileTitle.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.vs),
            Row(
              children: const [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: ProfileForm(),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
