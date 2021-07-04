import 'package:flutter/cupertino.dart';
import 'package:online_food_app/model/product/product_list_response.dart';
import 'package:online_food_app/repository/product_repository.dart';
import 'package:online_food_app/repository/user_repository.dart';
import 'package:online_food_app/utils/app_preference.dart';

class HomeController extends ChangeNotifier {
  BuildContext _context;

  ProductRepository _productRepository = ProductRepository();
  UserProfileRepository _userProfileRepository = UserProfileRepository();

  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _isActive = false;
  bool get isActive => _isActive;

  bool _isHome = true;
  bool get isHome => _isHome;

  String _selectedLatitude;
  String get selectedLatitude => _selectedLatitude;

  String _selectedLongitude;
  String get selectedLongitude => _selectedLongitude;

  List<Products> _productList = [];
  List<Products> get productList => _productList;

  void setActiveStatus() {
    _isActive = !_isActive;
    notifyListeners();
  }

  Future<void> fetchProductList() async {
    ProductListResponse response = await _productRepository.getProductList(
        _context,
        latitude: _selectedLatitude,
        longitude: _selectedLongitude);
    if (response != null) {
      _productList = response.data.products ?? [];
    } else {
      _productList = [];
    }
    notifyListeners();
  }

  void setLocation(bool isHomeAddress) async {
    if (isHomeAddress) {
      _isHome = true;
      _selectedLongitude = "78.367622";
      _selectedLatitude = "17.459719";
    } else {
      _isHome = false;
      _selectedLongitude = "80.2521276";
      _selectedLatitude = "13.041241";
    }
    await fetchProductList();
    notifyListeners();
  }

  Future<bool> logout() async {
    bool result = await _userProfileRepository.signOut(_context);
    if (result) {
      await AppPreferences.logoutClearPreferences();
      return true;
    } else {
      return false;
    }
  }

  void init(BuildContext context) {
    _context = context;
    setLocation(true);
    notifyListeners();
  }
}
