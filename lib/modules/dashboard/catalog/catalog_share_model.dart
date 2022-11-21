import 'package:flutter/foundation.dart';

import '../../../models/models.dart';

class CatalogShareModel extends ChangeNotifier {
  CatalogModel? _parameter;
  CatalogModel? get parameter => _parameter;

  void passParameter(CatalogModel parameter) {
    _parameter = parameter;
    notifyListeners();
  }
}
