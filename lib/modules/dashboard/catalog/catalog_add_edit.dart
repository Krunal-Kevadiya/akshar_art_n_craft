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

class CatalogAddEdit extends StatefulWidget {
  const CatalogAddEdit({
    super.key,
    required this.type,
  });
  final FirestoreOperationType type;

  @override
  State<CatalogAddEdit> createState() => _CatalogAddEditState();
}

class _CatalogAddEditState extends State<CatalogAddEdit> {
  GlobalKey<FormState>? _catalogFormKey;
  TextEditingController? _nameController;
  TextEditingController? _descriptionController;
  XFile? _file;
  bool _isLoading = false;
  String? _id;

  @override
  void initState() {
    super.initState();
    _catalogFormKey = GlobalKey();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _todoModel =
        ModalRoute.of(context)?.settings.arguments as CatalogModel?;
    _id = _todoModel?.id;
    _nameController = TextEditingController(text: _todoModel?.name ?? '');
    _descriptionController =
        TextEditingController(text: _todoModel?.description ?? '');
  }

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
    final focusScope = FocusScope.of(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return SingleChildScrollView(
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 8,
            child: Form(
              key: _catalogFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 32.vs),
                  ProfileAvatar(
                    file: _file,
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
                  SizedBox(height: 32.vs),
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
          const Spacer(),
        ],
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
                delete: false,
              ),
            )
          : await firestoreDatabase.updateCatalog(
              widget.type,
              CatalogModel(
                id: _id ?? documentIdFromCurrentDate(),
                name: _nameController!.text,
                description: _descriptionController!.text,
                delete: false,
              ),
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
