import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class RateUsPage extends StatefulWidget {
  const RateUsPage({
    super.key,
  });

  @override
  State<RateUsPage> createState() => _RateUsPageState();
}

class _RateUsPageState extends State<RateUsPage> {
  GlobalKey<FormState>? _rateUsFormKey;
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;

  double _rating = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _rateUsFormKey = GlobalKey();
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
    _rateUsFormKey = null;
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
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);
    final theme = Theme.of(context);

    return StreamBuilder(
      stream: authProvider.user,
      builder: (context, snapshot) {
        final user = snapshot.data as UserModel?;
        if (user != null && _rating == 0 && !_isLoading) {
          _controller[0] = TextEditingController(text: user.displayName ?? '');
          _controller[0].selection = TextSelection.fromPosition(
            TextPosition(offset: _controller[0].text.length),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(DrawerMenuString.rateUs.tr()),
            elevation: 0,
            leading: const MenuButton(),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.all(25.s),
                  child: rateUsForm(
                    theme: theme,
                    firestoreDatabase: firestoreDatabase,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget rateUsForm({
    required ThemeData theme,
    required FirestoreDatabase firestoreDatabase,
  }) {
    return Form(
      key: _rateUsFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: 32.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[0],
            focusNode: _focusNode[0],
            prefixIcon: Icons.person_rounded,
            validator: Validations.name,
            hintText: CatalogString.nameLabel.tr(),
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[0],
              to: _focusNode[1],
            ),
            enabled: !_isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _controller[1],
            focusNode: _focusNode[1],
            prefixIcon: Icons.description,
            //minLines: 3,
            //maxLines: 5,
            validator: Validations.comment,
            hintText: RateUsString.commentHint.tr(),
            textInputAction: TextInputAction.done,
            onEditingComplete: _focusNode[1].unfocus,
            onFieldSubmitted: (_) {
              _isValidate(firestoreDatabase);
            },
            enabled: !_isLoading,
          ),
          SizedBox(height: 16.vs),
          ratingTitle(theme: theme),
          ratingView(),
          const Spacer(),
          SizedBox(height: 16.vs),
          ConditionBaseWidget(
            isLoading: false,
            isSeenProgress: true,
            myWidget: RoundedButton(
              title: CatalogString.addButton.tr().toUpperCase(),
              press: () {
                _isValidate(firestoreDatabase);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget ratingTitle({required ThemeData theme}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        RateUsString.ratingLabel.tr(),
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 15.ms,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget ratingView() {
    return RatingBar.builder(
      itemSize: 50.s,
      glow: false,
      allowHalfRating: true,
      unratedColor: AppColors.gray,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return const Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return const Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return const Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return const Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
        }
      },
      onRatingUpdate: (value) {
        setState(() => _rating = value);
      },
    );
  }

  Future<void> _isValidate(FirestoreDatabase firestoreDatabase) async {
    if ((_rateUsFormKey?.currentState?.validate() ?? false) && _rating != 0) {
      setState(() => _isLoading = true);
      final result = await firestoreDatabase.addTestimonial(
        FirestoreOperationType.testimonial,
        TestimonialModel(
          id: documentIdFromCurrentDate(),
          name: _controller[0].text,
          comment: _controller[1].text,
          rating: _rating,
        ),
      );
      if (!mounted) return;
      setState(() => {_isLoading = false, _rating = 0});
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        _controller = List<TextEditingController>.generate(
          2,
          (int index) => TextEditingController(),
        );
        _focusNode[0].requestFocus();
      });
    }
  }
}
