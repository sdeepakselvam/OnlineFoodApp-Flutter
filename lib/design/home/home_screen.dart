import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_food_app/controllers/home_controller.dart';
import 'package:online_food_app/locale/localizations.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/ui_utils/string_resources.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/utils/app_constants.dart';
import 'package:online_food_app/utils/route_constant.dart';
import 'package:online_food_app/widget/common_bottom_sheet.dart';
import 'package:online_food_app/widget/common_button.dart';
import 'package:online_food_app/widget/common_icon.dart';
import 'package:online_food_app/widget/space.dart';
import 'package:online_food_app/widget/ui_textfield.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  HomeController _controller;

  @override
  void initState() {
    _controller = HomeController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.init(context));
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
            backgroundColor: UIColors.backgroundColor,
            drawer: _drawerWidget,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerWidget,
                    Space(isSmall: true),
                    _controller.productList.isNotEmpty
                        ? _productList
                        : _emptyList
                  ],
                )
              ],
            )));
  }

  Widget get _drawerWidget => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(color: UIColors.appBarColor),
            child: Center(
                child: Text(
              Translations.of(context).text(StringResources.user),
              style: Styles.appBarTitle
                  .copyWith(color: Colors.white, fontSize: UIDimens.size20),
            ))),
        ListTile(
            title: Text(Translations.of(context).text(StringResources.profile)),
            onTap: () {}),
        ListTile(
            title: Text(
                Translations.of(context).text(StringResources.notification)),
            onTap: () {}),
        ListTile(
            title: Text(Translations.of(context).text(StringResources.help)),
            onTap: () {}),
        ListTile(
            title: Text(Translations.of(context).text(StringResources.support)),
            onTap: () {}),
        ListTile(
            title: Text(Translations.of(context).text(StringResources.logout)),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.login, (Route<dynamic> route) => false);
            })
      ]));

  Widget get _headerWidget => Container(
      color: UIColors.appBarColor,
      padding: EdgeInsets.symmetric(
          horizontal: UIDimens.size18, vertical: UIDimens.size10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Space(), _addressField, Space(), _searchField, Space()]));

  Widget get _addressField => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonIcon(
                iconPath: AppAssets.pinIcon,
                iconWidth: UIDimens.size30,
                iconHeight: UIDimens.size30,
                onPressed: () async {
                  await CustomBottomSheetWidget(_controller, context: context)
                      .showBottomSheet();
                }),
            HorizontalSpace(isSmall: true),
            InkWell(
                onTap: () async {
                  await CustomBottomSheetWidget(_controller, context: context)
                      .showBottomSheet();
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller.isHome
                          ? Text(
                              Translations.of(context)
                                  .text(StringResources.home),
                              style: Styles.boldStyle
                                  .copyWith(color: Colors.white))
                          : Text(
                              Translations.of(context)
                                  .text(StringResources.work),
                              style: Styles.boldStyle
                                  .copyWith(color: Colors.white)),
                      Text(
                          _controller.isHome
                              ? "A-123,Sector, New York"
                              : "W-55, Sector-No 2",
                          softWrap: true,
                          style: Styles.boldStyle.copyWith(color: Colors.white))
                    ])),
            Spacer(),
            CommonButton(
                borderColor: Colors.white,
                width: UIDimens.size60,
                height: UIDimens.size30,
                title: Translations.of(context).text(StringResources.offers),
                padding: EdgeInsets.all(UIDimens.paddingXXXSmall),
                backgroundColor: Colors.transparent,
                onPressed: () {},
                style: Styles.appBarTitle.copyWith(color: Colors.white)),
            HorizontalSpace(isSmall: true),
            CommonIcon(
                iconPath: AppAssets.notificationIcon,
                iconWidth: UIDimens.size30,
                iconHeight: UIDimens.size30,
                iconColor: Colors.white)
          ]);

  Widget get _searchField => SizedBox(
      height: UIDimens.size50,
      child: CommonTextField(
          controller: _controller.searchController,
          style: Styles.boldStyle,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
              horizontal: UIDimens.size15, vertical: UIDimens.size15),
          borderRadius: UIDimens.size10,
          borderColor: Colors.transparent,
          fullborder: true,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: UIDimens.size20,
          ),
          hintText: Translations.of(context).text(StringResources.cravings)));

  Widget get _dealOfWeek => Container(
      padding: EdgeInsets.symmetric(
          horizontal: UIDimens.size20, vertical: UIDimens.size10),
      color: UIColors.backgroundGrey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(Translations.of(context).text(StringResources.dealOfWeek),
            style: Styles.boldStyle),
        Space(isSmall: true),
        CommonIcon(
            iconPath: AppAssets.offerIcon,
            iconWidth: MediaQuery.of(context).size.width,
            iconHeight: MediaQuery.of(context).size.height * 0.3)
      ]));

  Widget get _emptyList => Center(
        child: Padding(
          padding: const EdgeInsets.all(UIDimens.size20),
          child: Text(Translations.of(context).text(StringResources.emptyList),
              textAlign: TextAlign.center,
              style: Styles.boldStyle),
        ),
      );

  Widget get _productList => Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              _dealOfWeek,
              Space(isSmall: true),
              Container(
                  color: UIColors.lightGrey,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controller.productList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: UIDimens.size20,
                                vertical: UIDimens.size10),
                            margin: EdgeInsets.only(bottom: 5),
                            child: Column(children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          UIDimens.size10),
                                      child: CachedNetworkImage(
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover,
                                        imageUrl: _controller
                                                    .productList[index]
                                                    .productVariants
                                                    .first
                                                    .image
                                                    .file
                                                    .previewUrl !=
                                                null
                                            ? _controller
                                                .productList[index]
                                                .productVariants
                                                .first
                                                .image
                                                .file
                                                .previewUrl
                                            : " ",
                                        width: UIDimens.size90,
                                        height: UIDimens.size100,
                                        placeholder: (context, url) =>
                                            Image.asset(AppAssets.defaultIcon,
                                                fit: BoxFit.cover),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(AppAssets.defaultIcon,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                    HorizontalSpace(isSmall: true),
                                    Flexible(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: UIDimens.size100,
                                              height: UIDimens.size30,
                                              child: Card(
                                                elevation: UIDimens.size2,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color:
                                                          UIColors.lightGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          UIDimens
                                                              .paddingXXXSmall),
                                                ),
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                      Translations.of(context)
                                                          .text(StringResources
                                                              .bestSeller),
                                                      style: Styles.appBarTitle
                                                          .copyWith(
                                                              color: Colors
                                                                  .orangeAccent)),
                                                ),
                                              ),
                                            ),
                                            Space(customValue: UIDimens.size2),
                                            Text(
                                                _controller.productList[index]
                                                        .name ??
                                                    "",
                                                softWrap: true,
                                                style: Styles.boldStyle),
                                            Space(customValue: UIDimens.size5),
                                            Text(
                                                "Net wt : 1kg . Total wt : 2kg",
                                                style: Styles.appBarTitle),
                                            Space(customValue: UIDimens.size5),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    AppConstants.currentCurrency +
                                                            " " +
                                                            _controller
                                                                .productList[
                                                                    index]
                                                                .sellingPrice
                                                                .toString() ??
                                                        "",
                                                    style: Styles.boldStyle
                                                        .copyWith(
                                                            fontSize: UIDimens
                                                                .size18)),
                                                Flexible(
                                                  child: Container(
                                                    width: UIDimens.size65,
                                                    height: UIDimens.size25,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                UIDimens.size5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    UIDimens
                                                                        .size5),
                                                        color: Colors.red),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                              size: UIDimens
                                                                  .size16,
                                                            )),
                                                        HorizontalSpace(
                                                            customValue:
                                                                UIDimens.size2),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      UIDimens
                                                                          .paddingXXXSmall),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: UIDimens
                                                                  .paddingXXXSmall,
                                                              vertical: UIDimens
                                                                  .size2),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          UIDimens
                                                                              .paddingXXXSmall),
                                                              color:
                                                                  Colors.white),
                                                          child: Text('1',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: UIDimens
                                                                      .size16)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: UIDimens
                                                                    .size16))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    )
                                  ]),
                              Space(customValue: UIDimens.size5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CommonIcon(
                                      iconPath: AppAssets.deliveryIcon,
                                      iconWidth: UIDimens.size30,
                                      iconHeight: UIDimens.size20),
                                  HorizontalSpace(),
                                  Text(AppConstants.express,
                                      style: Styles.boldStyle
                                          .copyWith(fontSize: UIDimens.size15)),
                                  Spacer(),
                                  CommonButton(
                                      borderColor: Colors.red,
                                      width: UIDimens.size100,
                                      height: UIDimens.size30,
                                      title:
                                          "Today in ${_controller.productList[index].expressDeliveryIn.toString()} min", //Translations.of(context).text(StringResources.offers),
                                      padding: EdgeInsets.all(
                                          UIDimens.paddingXXXSmall),
                                      backgroundColor: Colors.white,
                                      onPressed: () {},
                                      style: Styles.appBarTitle
                                          .copyWith(color: Colors.red)),
                                ],
                              )
                            ]));
                      })),
            ],
          ),
        ),
      );
}
