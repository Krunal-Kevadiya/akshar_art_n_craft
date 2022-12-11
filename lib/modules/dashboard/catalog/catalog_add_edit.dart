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
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;
  XFile? _file;
  final String _photoUrl = '';
  bool _isLoading = false;
  int? _id;
  final bool _deleted = false;

  @override
  void initState() {
    super.initState();
    _catalogFormKey = GlobalKey();
    _focusNode = List<FocusNode>.generate(
      2,
      (int index) => FocusNode(),
    );
    _controller = List<TextEditingController>.generate(
      2,
      (int index) => TextEditingController(),
    );
    _focusNode[0].requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _file = null;
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
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.all(25.s),
            child: addEditForm(firestoreDatabase),
          ),
        ),
      ],
    );
  }

  Widget addEditForm(
    FirestoreDatabase firestoreDatabase,
  ) {
    return Form(
      key: _catalogFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          ProfileAvatar(
            file: _file,
            size: 110,
            photoUrl: _photoUrl,
            name: _controller[0].text,
            onFileSubmitted: (photo) {
              setState(() => _file = photo);
            },
            enabled: !_isLoading,
          ),
          SizedBox(height: 32.vs),
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
            enabled: !_isLoading,
          ),
          SizedBox(height: 16.vs),
          RoundedInput(
            controller: _controller[1],
            prefixIcon: Icons.description,
            minLines: 3,
            maxLines: 5,
            focusNode: _focusNode[1],
            validator: Validations.description,
            hintText: CatalogString.descriptionLabel.tr(),
            textInputAction: TextInputAction.done,
            onEditingComplete: _focusNode[1].unfocus,
            onFieldSubmitted: (_) {
              _isValidate(firestoreDatabase);
            },
            enabled: !_isLoading,
          ),
          const Spacer(),
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
    );
  }

  Future<void> _isValidate(
    FirestoreDatabase firestoreDatabase,
  ) async {
    if (_catalogFormKey!.currentState!.validate()) {
      setState(() => _isLoading = true);
      final result = _id == null
          ? await firestoreDatabase.addCatalog(
              widget.type,
              CatalogModel(
                id: documentIdFromCurrentDate(),
                name: _controller[0].text,
                description: _controller[1].text,
                photoUrl: _photoUrl,
                delete: _deleted,
              ),
              _file,
            )
          : await firestoreDatabase.updateCatalog(
              widget.type,
              CatalogModel(
                id: _id ?? documentIdFromCurrentDate(),
                name: _controller[0].text,
                description: _controller[1].text,
                photoUrl: _photoUrl,
                delete: _deleted,
              ),
              _file,
            );
      if (!mounted) return;
      setState(() => {_isLoading = false});
      result.when((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }, (success) {
        setState(
          () => {
            _file = null,
            _catalogFormKey = GlobalKey(),
            _controller = List<TextEditingController>.generate(
              2,
              (int index) => TextEditingController(),
            )
          },
        );
        _focusNode[0].requestFocus();
      });
    }
  }
}


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final arguments =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //   if (arguments != null && arguments.isNotEmpty == true) {
  //     final _todoModel = CatalogModel.fromJson(arguments);
  //     _id = _todoModel.id;
  //     _photoUrl = _todoModel.photoUrl;
  //     _deleted = _todoModel.delete;
  //     _nameController = TextEditingController(text: _todoModel.name);
  //     _descriptionController =
  //         TextEditingController(text: _todoModel.description);
  //   }
  // }