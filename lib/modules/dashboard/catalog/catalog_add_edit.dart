import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import './catalog_share_model.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class CatalogAddEdit extends StatefulWidget {
  const CatalogAddEdit({
    required this.type,
    required this.navBarState,
    super.key,
  });
  final FirestoreOperationType type;
  final CurvedNavigationBarState? navBarState;

  @override
  State<CatalogAddEdit> createState() => _CatalogAddEditState();
}

class _CatalogAddEditState extends State<CatalogAddEdit> {
  GlobalKey<FormState>? _catalogFormKey;
  late List<FocusNode> _focusNode;
  late List<TextEditingController> _controller;
  XFile? _file;
  String _photoUrl = '';
  bool _isLoading = false;
  CatalogModel? _model;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final catalogShareModel = Provider.of<CatalogShareModel>(context);
    _model ??= catalogShareModel.parameter;
    _photoUrl = _model?.photoUrl ?? '';
    _controller[0].text = _model?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

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
              title: _model?.id == null
                  ? CatalogString.addButton.tr().toUpperCase()
                  : CatalogString.editButton.tr().toUpperCase(),
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
    if (_catalogFormKey?.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      final result = _model?.id == null
          ? await firestoreDatabase.addCatalog(
              widget.type,
              CatalogModel(
                id: documentIdFromCurrentDate(),
                name: _controller[0].text,
                description: _controller[1].text,
                photoUrl: _photoUrl,
                delete: false,
              ),
              _file,
            )
          : await firestoreDatabase.updateCatalog(
              widget.type,
              CatalogModel(
                id: _model?.id ?? documentIdFromCurrentDate(),
                name: _controller[0].text,
                description: _controller[1].text,
                photoUrl: _photoUrl,
                delete: _model?.delete ?? false,
              ),
              _file,
            );
      if (!mounted) return;
      setState(() => _isLoading = false);
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
            ),
          },
        );
        _focusNode[0].requestFocus();
      });
    }
  }
}
