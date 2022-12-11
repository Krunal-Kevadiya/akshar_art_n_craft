import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
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

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
  });
  FirestoreOperationType get type => FirestoreOperationType.product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List<XFile?> _files = <XFile?>[];
  final List<String> _photoUrl = <String>[];
  bool _isLoading = false;
  int? _id;
  final bool _deleted = false;

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    final imageLength = _files.isNotEmpty
        ? _files.length + 1
        : _photoUrl.isNotEmpty
            ? _photoUrl.length + 1
            : 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerMenuString.product.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
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
      ),
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
          () => {
            _files = <XFile?>[],
          },
        );
      },
    );
  }
}

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   final arguments = ModalRoute.of(context)?.settings.arguments;
//   if (arguments != null) {
//     final _todoModel = arguments as CatalogModel;
//     _id = _todoModel.id;
//     _photoUrl = _todoModel.photoUrl;
//     _deleted = _todoModel.delete;
//     _nameController = TextEditingController(text: _todoModel.name);
//     _descriptionController =
//         TextEditingController(text: _todoModel.description);
//   }
// }
