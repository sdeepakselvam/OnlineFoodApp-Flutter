import 'package:flutter/material.dart';
import 'package:online_food_app/controllers/home_controller.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
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
            backgroundColor: UIColors.backgroundColor,
            drawer: _drawerWidget,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        _headerWidget,
                        Space(isSmall: true),
                        _dealOfWeek,
                        Space(isSmall: true),
                        _productList,
                        Space()
                      ],
                    )),
                  ],
                )
              ],
            )));
  }

  Widget get _drawerWidget => Drawer(
    child: ListView(

      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: UIColors.appBarColor,
          ),
          child: Center(child: Text('User', style: Styles.appBarTitle.copyWith(color: Colors.white, fontSize: UIDimens.size20),)),
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('Notifications'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('Help'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('Support'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login, (Route<dynamic> route) => false);
          },
        ),
      ],
    ),
  );

  Widget get _headerWidget => Container(
        color: UIColors.appBarColor,
        padding: EdgeInsets.symmetric(
            horizontal: UIDimens.size18, vertical: UIDimens.size10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Space(), _addressField, Space(), _searchField, Space()],
        ),
      );

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
            },
          ),
          HorizontalSpace(isSmall: true),
          InkWell(
            onTap: () async {
              await CustomBottomSheetWidget(_controller, context: context)
                  .showBottomSheet();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Home",
                    style: Styles.boldStyle.copyWith(color: Colors.white)),
                Text("A-123, Sector",
                    softWrap: true,
                    style: Styles.boldStyle.copyWith(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Spacer(),
          CommonButton(
            borderColor: Colors.white,
            width: UIDimens.size60,
            height: UIDimens.size30,
            title: "Offers",
            padding: EdgeInsets.all(UIDimens.paddingXXXSmall),
            backgroundColor: Colors.transparent,
            onPressed: () {},
            style: Styles.appBarTitle.copyWith(color: Colors.white),
          ),
          HorizontalSpace(isSmall: true),
          CommonIcon(
            iconPath: AppAssets.notificationIcon,
            iconWidth: UIDimens.size30,
            iconHeight: UIDimens.size30,
            iconColor: Colors.white,
          ),
        ],
      );

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
          hintText: "What are you craving for?",
        ),
      );

  Widget get _dealOfWeek => Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIDimens.size20, vertical: UIDimens.size10),
        color: UIColors.backgroundGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deal of the week!", style: Styles.boldStyle),
            Space(isSmall: true),
            CommonIcon(
              iconPath: AppAssets.offerIcon,
              iconWidth: MediaQuery.of(context).size.width,
              iconHeight: MediaQuery.of(context).size.height * 0.3,
            )
          ],
        ),
      );

  Widget get _productList => Container(
      color: UIColors.lightGrey,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: UIDimens.size20, vertical: UIDimens.size10),
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonIcon(
                        iconWidth: UIDimens.size80,
                        iconHeight: UIDimens.size90,
                        iconPath: AppAssets.offerIcon,
                      ),
                      HorizontalSpace(isSmall: true),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: UIDimens.size100,
                            height: UIDimens.size30,
                            child: Card(
                              elevation: UIDimens.size2,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: UIColors.lightGrey),
                                borderRadius: BorderRadius.circular(
                                    UIDimens.paddingXXXSmall),
                              ),
                              color: Colors.white,
                              child: Center(
                                child: Text("BEST SELLER",
                                    style: Styles.appBarTitle
                                        .copyWith(color: Colors.orangeAccent)),
                              ),
                            ),
                          ),
                          Space(customValue: UIDimens.size2),
                          Text("Chicken Tikka", style: Styles.boldStyle),
                          Space(customValue: UIDimens.size2),
                          Text("Net wt : 1kg . Total wt : 2kg",
                              style: Styles.boldStyle),
                          Space(customValue: UIDimens.size2),
                          Text("\$ 450", style: Styles.boldStyle),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }));
}
