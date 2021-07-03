import 'package:flutter/cupertino.dart';
import 'package:online_food_app/model/spinner_model.dart';

class LoginController extends ChangeNotifier {
  BuildContext _context;

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

  void setCountryType(values) {
    _selectedCountry = values;
    notifyListeners();
  }

  void setInitialValue() {
    _selectedCountry = _countryOptionList.first;
    notifyListeners();
  }

  void init(BuildContext context) {
    _context = context;
    setInitialValue();
    notifyListeners();
  }
}
