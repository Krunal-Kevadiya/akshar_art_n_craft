import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({
    required this.builder,
    required this.databaseBuilder,
    super.key,
  });
  final Widget Function(BuildContext, AsyncSnapshot<UserModel?>) builder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context);
    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        final user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(value: user),
              Provider<FirestoreDatabase>(
                create: (context) => databaseBuilder(context, user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
