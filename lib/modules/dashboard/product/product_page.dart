import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../navigators/navigators.dart';
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
  TextEditingController? _nameController;
  TextEditingController? _descriptionController;
  XFile? _file;
  final String _photoUrl = '';
  bool _isLoading = false;
  int? _id;
  final bool _deleted = false;

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _catalogFormKey = GlobalKey();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
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
    _nameController?.dispose();
    _descriptionController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusScope = FocusScope.of(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerString.productMenu.tr()),
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
                      prefixIcon: Icons.category,
                      validator: Validations.name,
                      hintText: CatalogString.nameLabel.tr(),
                      onEditingComplete: focusScope.nextFocus,
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme,
                      Icons.style,
                      'Category',
                      firestoreDatabase,
                      FirestoreOperationType.category,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme,
                      Icons.widgets,
                      'Subcategory',
                      firestoreDatabase,
                      FirestoreOperationType.subCategory,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme,
                      Icons.sell,
                      'Brand',
                      firestoreDatabase,
                      FirestoreOperationType.brand,
                    ),
                    SizedBox(height: 16.vs),
                    dropDown(
                      theme,
                      Icons.dns,
                      'Fabric',
                      firestoreDatabase,
                      FirestoreOperationType.fabric,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      prefixIcon: Icons.price_check,
                      validator: Validations.name,
                      hintText: 'Per Piece Price',
                      onEditingComplete: focusScope.nextFocus,
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      prefixIcon: Icons.confirmation_number,
                      validator: Validations.name,
                      hintText: 'Total Design',
                      onEditingComplete: focusScope.nextFocus,
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      prefixIcon: Icons.format_size,
                      validator: Validations.name,
                      hintText: 'Size',
                      onEditingComplete: focusScope.nextFocus,
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      prefixIcon: Icons.line_weight,
                      validator: Validations.name,
                      hintText: 'Weight',
                      onEditingComplete: focusScope.nextFocus,
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      prefixIcon: Icons.category,
                      validator: Validations.name,
                      hintText: 'MOQ',
                      onEditingComplete: focusScope.nextFocus,
                      enabled: !_isLoading,
                    ),
                    SizedBox(height: 16.vs),
                    RoundedInput(
                      autoFocus: true,
                      controller: _nameController,
                      prefixIcon: Icons.category,
                      validator: Validations.name,
                      hintText: 'GST',
                      onEditingComplete: focusScope.nextFocus,
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
                      onEditingComplete: focusScope.unfocus,
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

  Widget dropDown(
    ThemeData theme,
    IconData prefixIcon,
    String hintText,
    FirestoreDatabase firestoreDatabase,
    FirestoreOperationType type,
  ) {
    return StreamBuilder(
      stream: firestoreDatabase.getAllCatalog(type: type),
      builder: (context, snapshot) {
        final list = (snapshot.data ?? []) as List<CatalogModel>;
        return DropdownButtonFormField2(
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
            color: AppColors.primaryColor,
          ),
          buttonHeight: 48.s,
          buttonPadding: EdgeInsets.only(right: 10.s),
          dropdownDecoration: BoxDecoration(
            color: AppColors.primaryLightColor,
            borderRadius: BorderRadius.circular(15.s),
          ),
          items: list
              .map(
                (item) => DropdownMenuItem<CatalogModel>(
                  value: item,
                  child: Text(
                    item.name,
                    style: theme.textTheme.overline?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.ms,
                    ),
                  ),
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select gender.';
            }
            return null;
          },
          onChanged: (value) {
            //Do something when changing the item if you want.
          },
          onSaved: (value) {
            selectedValue = value.toString();
          },
        );
      },
    );
  }

  InputDecoration customInputDecoration({
    required ThemeData theme,
    bool isMultiLines = false,
    IconData? suffixIcon,
    IconData? prefixIcon,
    required String hintText,
    Color? iconColor,
  }) {
    return InputDecoration(
      isDense: false,
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              size: 25.s,
              color: iconColor,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? Icon(
              suffixIcon,
              size: 25.s,
              color: iconColor,
            )
          : null,
      labelText: hintText,
      contentPadding: EdgeInsets.only(
        top: isMultiLines ? 10.s : 0,
        bottom: isMultiLines ? 10.s : 0,
        right: isMultiLines ? 10.s : 0,
      ),
      enabledBorder:
          (theme.inputDecorationTheme.enabledBorder as OutlineInputBorder?)
              ?.copyWith(
        borderRadius:
            BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
      ),
      disabledBorder:
          (theme.inputDecorationTheme.disabledBorder as OutlineInputBorder?)
              ?.copyWith(
        borderRadius:
            BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
      ),
      focusedBorder:
          (theme.inputDecorationTheme.focusedBorder as OutlineInputBorder?)
              ?.copyWith(
        borderRadius:
            BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
      ),
      errorBorder:
          (theme.inputDecorationTheme.errorBorder as OutlineInputBorder?)
              ?.copyWith(
        borderRadius:
            BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
      ),
      focusedErrorBorder:
          (theme.inputDecorationTheme.focusedErrorBorder as OutlineInputBorder?)
              ?.copyWith(
        borderRadius:
            BorderRadius.all(Radius.circular(isMultiLines ? 20.s : 99.s)),
      ),
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
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          ModalRoute.withName(Routes.root),
        );
      });
    }
  }
}
