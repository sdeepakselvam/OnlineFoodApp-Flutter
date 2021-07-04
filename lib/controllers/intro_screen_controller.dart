import 'package:flutter/cupertino.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';

class IntroScreenController extends ChangeNotifier {
  BuildContext _context;

  List<String> _sliderImageList = [
    AppAssets.sliderOneIcon,
    AppAssets.sliderTwoIcon,
    AppAssets.sliderThreeIcon
  ];
  List<String> get sliderImageList => _sliderImageList;

  int _currentSliderIndex = 0;
  int get currentSliderIndex => _currentSliderIndex;

  void setCurrentIndex(int index) {
    _currentSliderIndex = index;
    notifyListeners();
  }

  void init(BuildContext context) {
    _context = context;
    notifyListeners();
  }
}
