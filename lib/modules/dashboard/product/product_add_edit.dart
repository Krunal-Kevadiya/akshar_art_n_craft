import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import './product_form.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ProductAddEdit extends StatefulWidget {
  const ProductAddEdit({
    required this.type,
    required this.navBarState,
    super.key,
  });
  final FirestoreOperationType type;
  final CurvedNavigationBarState? navBarState;

  @override
  State<ProductAddEdit> createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  late List<XFile?> _files = <XFile?>[];
  final List<String> _photoUrl = <String>[];
  bool _isLoading = false;
  int? _id;
  final bool _deleted = false;

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);
    final imageLength = _files.isNotEmpty
        ? _files.length + 1
        : _photoUrl.isNotEmpty
            ? _photoUrl.length + 1
            : 1;
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              SizedBox(height: 16.vs),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 30.hp,
                  viewportFraction: 0.9,
                  enableInfiniteScroll: false,
                ),
                itemCount: imageLength,
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 7.s),
                    child: ProfileAvatar(
                      file: _files.isNotEmpty && itemIndex < _files.length
                          ? _files[itemIndex]
                          : null,
                      photoUrl:
                          _photoUrl.isNotEmpty && itemIndex < _photoUrl.length
                              ? _photoUrl[itemIndex]
                              : null,
                      onFileSubmitted: (file) {
                        setState(() {
                          if (itemIndex < _files.length) {
                            _files.setAll(itemIndex, [file]);
                          } else {
                            _files.add(file);
                          }
                        });
                      },
                      name: '',
                      enabled: !_isLoading,
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(25.s),
                child: ProductForm(
                  isLoading: _isLoading,
                  isValidate: (ProductModel model) {
                    _isValidate(
                      firestoreDatabase,
                      model,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _isValidate(
    FirestoreDatabase firestoreDatabase,
    ProductModel model,
  ) async {
    setState(() => _isLoading = true);

    final result = _id == null
        ? await firestoreDatabase.addProduct(
            widget.type,
            ProductModel(
              id: documentIdFromCurrentDate(),
              name: model.name,
              category: model.category,
              subCategory: model.subCategory,
              brand: model.brand,
              fabric: model.fabric,
              price: model.price,
              piece: model.piece,
              size: model.size,
              weight: model.weight,
              moq: model.moq,
              gst: model.gst,
              description: model.description,
              photoUrl: _photoUrl,
              delete: _deleted,
            ),
            _files,
          )
        : await firestoreDatabase.updateProduct(
            widget.type,
            ProductModel(
              id: _id ?? documentIdFromCurrentDate(),
              name: model.name,
              category: model.category,
              subCategory: model.subCategory,
              brand: model.brand,
              fabric: model.fabric,
              price: model.price,
              piece: model.piece,
              size: model.size,
              weight: model.weight,
              moq: model.moq,
              gst: model.gst,
              description: model.description,
              photoUrl: _photoUrl,
              delete: _deleted,
            ),
            _files,
          );
    if (!mounted) return;
    setState(() => _isLoading = false);
    result.when(
      (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      },
      (success) {
        setState(
          () => _files = <XFile?>[],
        );
      },
    );
  }
}
