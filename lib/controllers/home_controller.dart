import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  BuildContext _context;

  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _isActive = false;
  bool get isActive => _isActive;

  void setActiveStatus() {
    _isActive = !_isActive;
    notifyListeners();
  }

  void init(BuildContext context) {
    _context = context;
    notifyListeners();
  }
}
