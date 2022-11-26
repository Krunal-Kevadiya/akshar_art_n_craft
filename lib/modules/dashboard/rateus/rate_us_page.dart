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
  TextEditingController? _nameController;
  TextEditingController? _commentController;

  double _rating = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _rateUsFormKey = GlobalKey();
    _nameController = TextEditingController();
    _commentController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nameController = TextEditingController(text: '');
    _commentController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();
    _rateUsFormKey = null;
    _nameController?.dispose();
    _commentController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return StreamBuilder(
      stream: authProvider.user,
      builder: (context, snapshot) {
        final user = snapshot.data as UserModel?;
        if (user != null && _rating == 0 && !_isLoading) {
          _nameController = TextEditingController(text: user.displayName ?? '');
          _nameController?.selection = TextSelection.fromPosition(
            TextPosition(offset: _nameController?.text.length ?? 0),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(DrawerString.rateUsMenu.tr()),
            elevation: 0,
            leading: const MenuButton(),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.all(25.s),
                  child: Form(
                    key: _rateUsFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        SizedBox(height: 32.vs),
                        RoundedInput(
                          autoFocus: true,
                          controller: _nameController,
                          prefixIcon: Icons.person_rounded,
                          validator: Validations.name,
                          hintText: CatalogString.nameLabel.tr(),
                          onEditingComplete: focusScope.nextFocus,
                          enabled: !_isLoading,
                        ),
                        SizedBox(height: 16.vs),
                        RoundedInput(
                          controller: _commentController,
                          prefixIcon: Icons.description,
                          minLines: 3,
                          maxLines: 5,
                          validator: Validations.comment,
                          hintText: RateUsString.commentLabel.tr(),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: focusScope.unfocus,
                          onFieldSubmitted: (_) {
                            _isValidate(firestoreDatabase);
                          },
                          enabled: !_isLoading,
                        ),
                        SizedBox(height: 16.vs),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            RateUsString.rating.tr(),
                            textAlign: TextAlign.left,
                            style: theme.textTheme.overline?.copyWith(
                              fontSize: 15.ms,
                              fontWeight: FontWeight.w700,
                              color: isDarkTheme
                                  ? AppColors.primaryLightColor
                                  : AppColors.primaryColor,
                            ),
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 50.s,
                          glow: false,
                          allowHalfRating: true,
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
                        ),
                        SizedBox(height: 16.vs),
                        const Expanded(
                          child: Spacer(),
                        ),
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
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _isValidate(FirestoreDatabase firestoreDatabase) async {
    if (_rateUsFormKey!.currentState!.validate() && _rating != 0) {
      setState(() => _isLoading = true);
      final result = await firestoreDatabase.addTestimonial(
        FirestoreOperationType.testimonial,
        TestimonialModel(
          id: documentIdFromCurrentDate(),
          name: _nameController!.text,
          comment: _commentController!.text,
          rating: _rating,
        ),
      );
      if (!mounted) return;
      setState(() => {_isLoading = false, _rating = 0});
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        _nameController = TextEditingController();
        _commentController = TextEditingController();
      });
    }
  }
}
