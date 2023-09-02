import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({
    super.key,
  });
  FirestoreOperationType get type => FirestoreOperationType.testimonial;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerMenuString.testimonials.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: StreamBuilder(
        stream: firestoreDatabase.getAllTestimonial(type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lists = (snapshot.data ?? []) as List<TestimonialModel>;
            if (lists.isNotEmpty) {
              return ListView.builder(
                itemCount: lists.length,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.s, vertical: 10.vs),
                itemBuilder: (context, index) {
                  return commentTile(theme, lists[index]);
                },
              );
            } else {
              return EmptyContent(
                topImage: Images.mainTop,
                title: type.name,
                message: type.name,
                press: () {},
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContent(
              topImage: Images.mainTop,
              title: type.name,
              message: type.name,
              press: () {},
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget commentTile(ThemeData theme, TestimonialModel model) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.s, vertical: 10.vs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CatalogString.nameLabel.tr(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 14.ms,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            Text(
              model.name,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 13.ms,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: 5.vs),
            Text(
              RateUsString.commentHint.tr(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 14.ms,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            Text(
              model.comment ?? '',
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 13.ms,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: 5.vs),
            ratingView(model),
          ],
        ),
      ),
    );
  }

  Widget ratingView(TestimonialModel model) {
    return Align(
      alignment: Alignment.centerRight,
      child: RatingBar.builder(
        itemSize: 30.s,
        glow: false,
        initialRating: model.rating ?? 0,
        allowHalfRating: true,
        ignoreGestures: true,
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
        onRatingUpdate: (value) {},
      ),
    );
  }
}
