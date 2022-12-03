import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  GlobalKey<FormState>? _catalogFormKey;
  late FocusNode _nameFocusNode;
  late FocusNode _categoryFocusNode;
  late FocusNode _subcategoryFocusNode;
  late FocusNode _brandFocusNode;
  late FocusNode _fabricFocusNode;
  late FocusNode _perPiecePriceFocusNode;
  late FocusNode _totalDesignFocusNode;
  late FocusNode _sizeFocusNode;
  late FocusNode _weightFocusNode;
  late FocusNode _moqFocusNode;
  late FocusNode _gstFocusNode;
  late FocusNode _descriptionFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _perPiecePriceController;
  TextEditingController? _totalDesignController;
  TextEditingController? _sizeController;
  TextEditingController? _weightController;
  TextEditingController? _moqController;
  TextEditingController? _gstController;
  TextEditingController? _descriptionController;
  TextEditingController? _dropdownSearchController;

  XFile? _file;
  final String _photoUrl = '';
  bool _isLoading = false;
  int? _id;
  final bool _deleted = false;
  CatalogModel? _selectedCategory;
  CatalogModel? _selectedSubCategory;
  CatalogModel? _selectedBrand;
  CatalogModel? _selectedFabric;

  @override
  void initState() {
    super.initState();
    _catalogFormKey = GlobalKey();
    _nameFocusNode = FocusNode();
    _categoryFocusNode = FocusNode();
    _subcategoryFocusNode = FocusNode();
    _brandFocusNode = FocusNode();
    _fabricFocusNode = FocusNode();
    _perPiecePriceFocusNode = FocusNode();
    _totalDesignFocusNode = FocusNode();
    _sizeFocusNode = FocusNode();
    _weightFocusNode = FocusNode();
    _moqFocusNode = FocusNode();
    _gstFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    _nameController = TextEditingController();
    _perPiecePriceController = TextEditingController();
    _totalDesignController = TextEditingController();
    _sizeController = TextEditingController();
    _weightController = TextEditingController();
    _moqController = TextEditingController();
    _gstController = TextEditingController();
    _descriptionController = TextEditingController();
    _dropdownSearchController = TextEditingController();
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

  @override
  void dispose() {
    super.dispose();
    _file = null;
    _catalogFormKey = null;
    _nameFocusNode.unfocus();
    _categoryFocusNode.unfocus();
    _subcategoryFocusNode.unfocus();
    _brandFocusNode.unfocus();
    _fabricFocusNode.unfocus();
    _perPiecePriceFocusNode.unfocus();
    _totalDesignFocusNode.unfocus();
    _sizeFocusNode.unfocus();
    _weightFocusNode.unfocus();
    _moqFocusNode.unfocus();
    _gstFocusNode.unfocus();
    _descriptionFocusNode.unfocus();
    _nameController?.dispose();
    _perPiecePriceController?.dispose();
    _totalDesignController?.dispose();
    _sizeController?.dispose();
    _weightController?.dispose();
    _moqController?.dispose();
    _gstController?.dispose();
    _descriptionController?.dispose();
    _dropdownSearchController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusScope = FocusScope.of(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

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
            child: Padding(
              padding: EdgeInsets.all(25.s),
              child: Form(
                key: _catalogFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    ProfileAvatar(
                      file: _file,
                      size: 110,
                      photoUrl: _photoUrl,
                      name: _nameController?.text ?? '',
                      onFileSubmitted: (photo) {
                        setState(() => _file = photo);
                      },
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 32.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      prefixIcon: Icons.category,
                      validator: Validations.name,
                      hintText: CatalogString.nameLabel.tr(),
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _nameFocusNode,
                        to: _categoryFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme: theme,
                      prefixIcon: Icons.style,
                      hintText: DrawerMenuString.category.tr(),
                      firestoreDatabase: firestoreDatabase,
                      selectedValue: _selectedCategory,
                      type: FirestoreOperationType.category,
                      focusNode: _categoryFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _categoryFocusNode,
                        to: _subcategoryFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme: theme,
                      prefixIcon: Icons.widgets,
                      hintText: DrawerMenuString.subCategory.tr(),
                      firestoreDatabase: firestoreDatabase,
                      selectedValue: _selectedSubCategory,
                      type: FirestoreOperationType.subCategory,
                      focusNode: _subcategoryFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _subcategoryFocusNode,
                        to: _brandFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme: theme,
                      prefixIcon: Icons.sell,
                      hintText: DrawerMenuString.brand.tr(),
                      firestoreDatabase: firestoreDatabase,
                      selectedValue: _selectedBrand,
                      type: FirestoreOperationType.brand,
                      focusNode: _brandFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _brandFocusNode,
                        to: _fabricFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme: theme,
                      prefixIcon: Icons.dns,
                      hintText: DrawerMenuString.fabric.tr(),
                      firestoreDatabase: firestoreDatabase,
                      selectedValue: _selectedFabric,
                      type: FirestoreOperationType.fabric,
                      focusNode: _fabricFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _fabricFocusNode,
                        to: _perPiecePriceFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _perPiecePriceController,
                      prefixIcon: Icons.price_check,
                      validator: Validations.digit,
                      hintText: ProductString.perPiecePriceHint.tr(),
                      focusNode: _perPiecePriceFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _perPiecePriceFocusNode,
                        to: _totalDesignFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _totalDesignController,
                      prefixIcon: Icons.confirmation_number,
                      validator: Validations.digit,
                      hintText: ProductString.totalDesignHint.tr(),
                      focusNode: _totalDesignFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _totalDesignFocusNode,
                        to: _sizeFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _sizeController,
                      prefixIcon: Icons.format_size,
                      validator: Validations.size,
                      hintText: ProductString.sizeHint.tr(),
                      focusNode: _sizeFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _sizeFocusNode,
                        to: _weightFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _weightController,
                      prefixIcon: Icons.line_weight,
                      validator: Validations.weight,
                      hintText: ProductString.weightHint.tr(),
                      focusNode: _weightFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _weightFocusNode,
                        to: _moqFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _moqController,
                      prefixIcon: Icons.category,
                      validator: Validations.moq,
                      hintText: ProductString.moqHint.tr(),
                      focusNode: _moqFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _moqFocusNode,
                        to: _gstFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _gstController,
                      prefixIcon: Icons.category,
                      validator: Validations.digit,
                      hintText: ProductString.gstHint.tr(),
                      focusNode: _gstFocusNode,
                      onEditingComplete: () => fieldFocusChange(
                        context: context,
                        from: _gstFocusNode,
                        to: _descriptionFocusNode,
                      ),
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      controller: _descriptionController,
                      prefixIcon: Icons.description,
                      minLines: 3,
                      maxLines: 5,
                      validator: Validations.description,
                      hintText: CatalogString.descriptionLabel.tr(),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _descriptionFocusNode.unfocus,
                      onFieldSubmitted: (_) {
                        _isValidate(firestoreDatabase);
                      },
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    ConditionBaseWidget(
                      isLoading: _isLoading,
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
              ),
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
    CatalogModel? selectedValue,
  }) {
    print(selectedValue);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return StreamBuilder(
      stream: firestoreDatabase.getAllCatalog(type: type),
      builder: (context, snapshot) {
        final list = (snapshot.data ?? []) as List<CatalogModel>;
        return DropdownButtonFormField2<CatalogModel>(
          focusNode: focusNode,
          decoration: customInputDecoration(
            theme: theme,
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
          isExpanded: true,
          dropdownWidth: 85.wp,
          offset: const Offset(-45, 0),
          icon: Icon(
            Icons.arrow_drop_down,
            size: 25.s,
            color: isDarkTheme
                ? AppColors.primaryLightColor
                : AppColors.primaryColor,
          ),
          buttonHeight: 48.s,
          buttonSplashColor: AppColors.transparent,
          buttonHighlightColor: AppColors.transparent,
          buttonPadding: EdgeInsets.only(right: 10.s),
          dropdownDecoration: BoxDecoration(
            color: AppColors.primaryLightColor,
            borderRadius: BorderRadius.circular(15.s),
          ),
          searchController: _dropdownSearchController,
          searchInnerWidget: Padding(
            padding: EdgeInsets.only(
              top: 20.vs,
              right: 10.s,
              left: 10.s,
            ),
            child: TextFormField(
              controller: _dropdownSearchController,
              decoration: customInputDecoration(
                theme: theme,
                hintText:
                    ProductString.searchLabel.tr(namedArgs: {'type': hintText}),
              ).applyDefaults(theme.inputDecorationTheme),
            ),
          ),
          searchMatchFn: (DropdownMenuItem<dynamic> item, String searchValue) {
            return item.value.toString().contains(searchValue);
          },
          items: list
              .map(
                (item) => DropdownMenuItem<CatalogModel>(
                  value: item,
                  child: Text(
                    item.name,
                    style: theme.textTheme.overline?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.ms,
                      color: AppColors.black,
                    ),
                  ),
                ),
              )
              .toList(),
          value: selectedValue,
          onChanged: enabled ? (CatalogModel? value) {} : null,
          onMenuStateChange: (bool isOpen) {
            if (!isOpen) {
              _dropdownSearchController?.clear();
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
          onSaved: (CatalogModel? value) {
            switch (type) {
              case FirestoreOperationType.category:
                setState(() => _selectedCategory = value);
                onEditingComplete();
                break;
              case FirestoreOperationType.subCategory:
                setState(() => _selectedSubCategory = value);
                onEditingComplete();
                break;
              case FirestoreOperationType.brand:
                setState(() => _selectedBrand = value);
                onEditingComplete();
                break;
              case FirestoreOperationType.fabric:
                setState(() => _selectedFabric = value);
                onEditingComplete();
                break;
              // ignore: no_default_cases
              default:
                break;
            }
          },
        );
      },
    );
  }

  Future<void> _isValidate(FirestoreDatabase firestoreDatabase) async {
    if (_catalogFormKey!.currentState!.validate()) {
      setState(() => _isLoading = true);
      final result = _id == null
          ? await firestoreDatabase.addCatalog(
              widget.type,
              CatalogModel(
                id: documentIdFromCurrentDate(),
                name: _nameController!.text,
                description: _descriptionController!.text,
                photoUrl: _photoUrl,
                delete: _deleted,
              ),
              _file,
            )
          : await firestoreDatabase.updateCatalog(
              widget.type,
              CatalogModel(
                id: _id ?? documentIdFromCurrentDate(),
                name: _nameController!.text,
                description: _descriptionController!.text,
                photoUrl: _photoUrl,
                delete: _deleted,
              ),
              _file,
            );
      if (!mounted) return;
      setState(() => _isLoading = false);
      result.when(
        (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
        (success) {},
      );
    }
  }
}
