import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({
    required this.isLoading,
    required this.isValidate,
    super.key,
  });
  final bool isLoading;
  final void Function(ProductModel model) isValidate;

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  GlobalKey<FormState>? _catalogFormKey;
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;
  late final List<int?> _selectedId = <int?>[-1, -1, -1, -1];

  @override
  void initState() {
    super.initState();
    _catalogFormKey = GlobalKey();
    _focusNode = List<FocusNode>.generate(12, (int index) => FocusNode());
    _controller = List<TextEditingController>.generate(
      9,
      (int index) => TextEditingController(),
    );
    _focusNode[0].requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _catalogFormKey = null;
    for (final node in _focusNode) {
      node.unfocus();
    }
    for (final input in _controller) {
      input.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

    return Form(
      key: _catalogFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          RoundedInput(
            autoFocus: true,
            controller: _controller[0],
            focusNode: _focusNode[0],
            prefixIcon: Icons.category,
            validator: Validations.name,
            hintText: CatalogString.nameLabel.tr(),
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[0],
              to: _focusNode[1],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          dropDown(
            theme: theme,
            prefixIcon: Icons.style,
            hintText: DrawerMenuString.category.tr(),
            firestoreDatabase: firestoreDatabase,
            type: FirestoreOperationType.category,
            focusNode: _focusNode[1],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[1],
              to: _focusNode[2],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          dropDown(
            theme: theme,
            prefixIcon: Icons.widgets,
            hintText: DrawerMenuString.subCategory.tr(),
            firestoreDatabase: firestoreDatabase,
            type: FirestoreOperationType.subCategory,
            focusNode: _focusNode[2],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[2],
              to: _focusNode[3],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          dropDown(
            theme: theme,
            prefixIcon: Icons.sell,
            hintText: DrawerMenuString.brand.tr(),
            firestoreDatabase: firestoreDatabase,
            type: FirestoreOperationType.brand,
            focusNode: _focusNode[3],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[3],
              to: _focusNode[4],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          dropDown(
            theme: theme,
            prefixIcon: Icons.dns,
            hintText: DrawerMenuString.fabric.tr(),
            firestoreDatabase: firestoreDatabase,
            type: FirestoreOperationType.fabric,
            focusNode: _focusNode[4],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[4],
              to: _focusNode[5],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[1],
            prefixIcon: Icons.price_check,
            validator: Validations.digit,
            hintText: ProductString.perPiecePriceHint.tr(),
            focusNode: _focusNode[5],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[5],
              to: _focusNode[6],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[2],
            prefixIcon: Icons.confirmation_number,
            validator: Validations.digit,
            hintText: ProductString.totalDesignHint.tr(),
            focusNode: _focusNode[6],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[6],
              to: _focusNode[7],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[3],
            prefixIcon: Icons.format_size,
            validator: Validations.size,
            hintText: ProductString.sizeHint.tr(),
            focusNode: _focusNode[7],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[7],
              to: _focusNode[8],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[4],
            prefixIcon: Icons.line_weight,
            validator: Validations.weight,
            hintText: ProductString.weightHint.tr(),
            focusNode: _focusNode[8],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[8],
              to: _focusNode[9],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[5],
            prefixIcon: Icons.category,
            validator: Validations.moq,
            hintText: ProductString.moqHint.tr(),
            focusNode: _focusNode[9],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[9],
              to: _focusNode[10],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            autoFocus: true,
            controller: _controller[6],
            prefixIcon: Icons.category,
            validator: Validations.digit,
            hintText: ProductString.gstHint.tr(),
            focusNode: _focusNode[10],
            onEditingComplete: () => fieldFocusChange(
              context: context,
              from: _focusNode[10],
              to: _focusNode[11],
            ),
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _controller[7],
            prefixIcon: Icons.description,
            minLines: 3,
            maxLines: 5,
            focusNode: _focusNode[11],
            validator: Validations.description,
            hintText: CatalogString.descriptionLabel.tr(),
            textInputAction: TextInputAction.done,
            onEditingComplete: _focusNode[11].unfocus,
            onFieldSubmitted: (_) {
              _isValidate(firestoreDatabase);
            },
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 16.vs),
          ConditionBaseWidget(
            isLoading: widget.isLoading,
            isSeenProgress: true,
            myWidget: RoundedButton(
              title: CatalogString.addButton.tr().toUpperCase(),
              press: () {
                _isValidate(firestoreDatabase);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDown({
    required ThemeData theme,
    required IconData prefixIcon,
    required String hintText,
    required FirestoreDatabase firestoreDatabase,
    required FirestoreOperationType type,
    required FocusNode focusNode,
    required VoidCallback onEditingComplete,
    required bool enabled,
  }) {
    final isDarkTheme = theme.brightness == Brightness.dark;
    return StreamBuilder(
      stream: firestoreDatabase.getAllCatalog(type: type),
      builder: (context, snapshot) {
        final list = (snapshot.data ?? <CatalogModel>[]) as List<CatalogModel>;
        return DropdownButtonFormField2<CatalogModel>(
          focusNode: focusNode,
          decoration: customInputDecoration(
            theme: theme,
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            width: 85.wp,
            offset: Offset(3.s, 0),
            decoration: BoxDecoration(
              color: AppColors.primaryLightColor,
              borderRadius: BorderRadius.circular(15.s),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            height: 48.s,
            padding: EdgeInsets.only(right: 10.s),
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: _controller[8],
            searchInnerWidgetHeight: 48.s,
            searchInnerWidget: Padding(
              padding: EdgeInsets.only(
                top: 20.vs,
                right: 10.s,
                left: 10.s,
              ),
              child: TextFormField(
                controller: _controller[8],
                decoration: customInputDecoration(
                  theme: theme,
                  hintText: ProductString.searchLabel
                      .tr(namedArgs: {'type': hintText}),
                ).applyDefaults(theme.inputDecorationTheme),
              ),
            ),
            searchMatchFn:
                (DropdownMenuItem<dynamic> item, String searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              size: 25.s,
              color: isDarkTheme
                  ? AppColors.primaryLightColor
                  : AppColors.primaryColor,
            ),
          ),
          items: list
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.name,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.ms,
                      color: AppColors.black,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (CatalogModel? value) {
            switch (type) {
              case FirestoreOperationType.category:
                setState(() => _selectedId[0] = value?.id);
                onEditingComplete();
                break;
              case FirestoreOperationType.subCategory:
                setState(() => _selectedId[1] = value?.id);
                onEditingComplete();
                break;
              case FirestoreOperationType.brand:
                setState(() => _selectedId[2] = value?.id);
                onEditingComplete();
                break;
              case FirestoreOperationType.fabric:
                setState(() => _selectedId[3] = value?.id);
                onEditingComplete();
                break;
              // ignore: no_default_cases
              default:
                break;
            }
          },
          onMenuStateChange: (bool isOpen) {
            if (!isOpen) {
              _controller[8].clear();
            }
          },
          validator: (CatalogModel? value) {
            if (value == null) {
              switch (type) {
                case FirestoreOperationType.category:
                  return ErrorString.emptyCategory.tr();
                case FirestoreOperationType.subCategory:
                  return ErrorString.emptySubCategory.tr();
                case FirestoreOperationType.brand:
                  return ErrorString.emptyBrand.tr();
                case FirestoreOperationType.fabric:
                  return ErrorString.emptyFabric.tr();
                // ignore: no_default_cases
                default:
                  return ErrorString.emptyDropdown.tr();
              }
            }
            return null;
          },
        );
      },
    );
  }

  void _isValidate(FirestoreDatabase firestoreDatabase) {
    if (_catalogFormKey?.currentState?.validate() ?? false) {
      widget.isValidate(
        ProductModel(
          id: documentIdFromCurrentDate(),
          name: _controller[0].text,
          category: _selectedId[0] ?? -1,
          subCategory: _selectedId[1] ?? -1,
          brand: _selectedId[2] ?? -1,
          fabric: _selectedId[3] ?? -1,
          price: _controller[1].text,
          piece: _controller[2].text,
          size: _controller[3].text,
          weight: _controller[4].text,
          moq: _controller[5].text,
          gst: _controller[6].text,
          description: _controller[7].text,
          photoUrl: <String>[],
          delete: false,
        ),
      );
    }
  }
}
