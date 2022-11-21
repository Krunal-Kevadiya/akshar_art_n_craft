import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../widgets/widgets.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerString.testimonialsMenu.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: StreamBuilder(
        stream: firestoreDatabase
            .getAllTestimonial(FirestoreOperationType.testimonial),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lists = (snapshot.data ?? []) as List<TestimonialModel>;
            if (lists.isNotEmpty) {
              return ListView.separated(
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(lists[index].name),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 0.5);
                },
              );
            } else {
              return EmptyContent(
                topImage: Images.mainTop,
                title: FirestoreOperationType.testimonial.name,
                message: FirestoreOperationType.testimonial.name,
                press: () {},
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContent(
              topImage: Images.mainTop,
              title: FirestoreOperationType.testimonial.name,
              message: FirestoreOperationType.testimonial.name,
              press: () {},
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
