import 'package:flutter/cupertino.dart';
import 'package:online_food_app/model/login/login_request.dart';
import 'package:online_food_app/model/login/login_response.dart';
import 'package:online_food_app/model/spinner_model.dart';
import 'package:online_food_app/repository/user_repository.dart';
import 'package:online_food_app/utils/app_preference.dart';

class LoginController extends ChangeNotifier {
  BuildContext _context;

  UserProfileRepository _userProfileRepository = UserProfileRepository();

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;

  SpinnerModel _selectedCountry;
  SpinnerModel get selectedCountry => _selectedCountry;

  List<SpinnerModel> _countryOptionList = [
    SpinnerModel(name: "+91", id: "IN"),
    SpinnerModel(name: "+1", id: "US"),
    SpinnerModel(name: "+93", id: "AF"),
    SpinnerModel(name: "+33", id: "FR"),
    SpinnerModel(name: "+81", id: "JP"),
    SpinnerModel(name: "+64", id: "NZ"),
    SpinnerModel(name: "+31", id: "NL"),
  ];
  List<SpinnerModel> get countryOptionList => _countryOptionList;

  String _countryType;
  String get countryType =>_countryType;

  bool get isEnable => _phoneNumberController.text.trim().isNotEmpty;

  void setCountryType(values) {
    _selectedCountry = values;
    _countryType = _selectedCountry.name.replaceAll("+", "");
    notifyListeners();
  }

  void setInitialValue() {
    _selectedCountry = _countryOptionList.first;
    _countryType = _selectedCountry.name.replaceAll("+", "");
    notifyListeners();
  }

  Future<bool> login() async {
    LoginResponse response = await _userProfileRepository.postSentOTP(_context,
        LoginRequestModel(countryCode: _countryType, phoneNumber: _phoneNumberController.text.trim()));

    if (response != null) {
      await AppPreferences.setCountryCode(_countryType);
      await AppPreferences.setPhoneNumber(_phoneNumberController.text.trim());
      return true;
    } else {
      return false;
    }
  }

  void init(BuildContext context) {
    _context = context;
    setInitialValue();
    notifyListeners();
  }
}
