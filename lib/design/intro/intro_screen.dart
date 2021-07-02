import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:online_food_app/controllers/intro_screen_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:online_food_app/locale/localizations.dart';
import 'package:online_food_app/ui_utils/string_resources.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/utils/route_constant.dart';
import 'package:online_food_app/widget/common_button.dart';
import 'package:online_food_app/widget/space.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreen();
}

class _IntroScreen extends State<IntroScreen> {
  IntroScreenController _controller;

  @override
  void initState() {
    _controller = IntroScreenController();
    _controller.init(context);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
            body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView(
                  children: [_carouselSlider],
                )),
                _sliderDescription,
                Space(),
                _actionButton,
                Space()
              ],
            )
          ],
        )));
  }

  Widget get _carouselSlider => Column(
        children: [
          CarouselSlider(
            carouselController: CarouselController(),
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.6,
                viewportFraction: 1,
                autoPlay: true,
                initialPage: _controller.currentSliderIndex,
                autoPlayInterval: const Duration(seconds: 2),
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  _controller.setCurrentIndex(index);
                }),
            items: _carouselWidgets(),
          ),
          Space(),
          _carouselDots
        ],
      );

  List<Widget> _carouselWidgets() {
    List<Widget> widgets = [];
    for (int i = 0; i < _controller.sliderImageList.length; i++) {
      widgets.add(
        Image.asset(
          _controller.sliderImageList[i],
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      );
    }
    return widgets;
  }

  Widget get _carouselDots => Container(
      height: UIDimens.size12,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _controller.sliderImageList?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(UIDimens.size2),
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: UIDimens.size10,
                    width: UIDimens.size10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(UIDimens.size25),
                      color: index == _controller.currentSliderIndex
                          ? UIColors.redColor
                          : UIColors.backgroundGrey,
                    )));
          }));

  Widget get _sliderDescription => Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIDimens.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.currentSliderIndex == 0) ...[
              Text(Translations.of(context).text(StringResources.getExpress),
                  style: Styles.boldStyle),
              Space(customValue: UIDimens.size2),
              Text(Translations.of(context).text(StringResources.fastDelivery),
                  style: Styles.boldStyle)
            ],
            if (_controller.currentSliderIndex == 1) ...[
              Text(Translations.of(context).text(StringResources.find),
                  style: Styles.boldStyle),
              Space(customValue: UIDimens.size2),
              Text(Translations.of(context).text(StringResources.favouriteMeat),
                  style: Styles.boldStyle)
            ],
            if (_controller.currentSliderIndex == 2) ...[
              Text(Translations.of(context).text(StringResources.getDeliveries),
                  style: Styles.boldStyle),
              Space(customValue: UIDimens.size2),
              Text(Translations.of(context).text(StringResources.doorstep),
                  style: Styles.boldStyle)
            ],
            Space(customValue: UIDimens.size5),
            Text(Translations.of(context).text(StringResources.introDesc),
                style: Styles.appBarTitle)
          ],
        ),
      );

  Widget get _actionButton => Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIDimens.size20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CommonButton(
                width: MediaQuery.of(context).size.width,
                showBorder: true,
                style: Styles.boldStyle.copyWith(
                    fontSize: UIDimens.size13, color: UIColors.redColor),
                title: Translations.of(context)
                    .text(StringResources.login)
                    .toUpperCase(),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
              ),
            ),
            HorizontalSpace(),
            Expanded(
              child: CommonButton(
                width: MediaQuery.of(context).size.width,
                showBorder: true,
                style: Styles.boldStyle
                    .copyWith(fontSize: UIDimens.size13, color: Colors.white),
                title: Translations.of(context)
                    .text(StringResources.doorstep)
                    .toUpperCase(),
                backgroundColor: UIColors.redColor,
                onPressed: () {},
              ),
            )
          ],
        ),
      );
}
