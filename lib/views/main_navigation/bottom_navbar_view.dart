// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/utils/custom_colors.dart';
import 'package:social_media_app/views/home/home_view.dart';
import 'package:social_media_app/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

import 'bottom_navbar_viewmodel.dart';

class BottomNavbarView extends StatelessWidget {
  final int viewIndex;
  const BottomNavbarView({
    Key? key,
    required this.viewIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavbarViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Scaffold(backgroundColor: Colors.white)
          : WillPopScope(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: IndexedStack(
                  index: model.index,
                  children: [
                    Navigator(
                      key: model.homePageKey,
                      onGenerateRoute: (route) => MaterialPageRoute(
                          settings: route,
                          builder: (context) => const HomeView()),
                    ),
                    Navigator(
                      key: model.profilePageKey,
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => const ProfileView(),
                      ),
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  shape: const CircleBorder(),
                  heroTag: "CreatePostView",
                  backgroundColor: CustomColors.primaryColor,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () async {
                    model.navigateToCreatePost();
                  },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                  surfaceTintColor: Colors.white,
                  height: 72,
                  shape: const CustomNotchedRectangle(),
                  notchMargin: 5.0,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _bottomBarItem(
                        index: 0,
                        name: "Home",
                        icon: Icons.home_filled,
                        model: model,
                      ),
                      const SizedBox(),
                      _bottomBarItem(
                        index: 1,
                        name: "Profile",
                        icon: Icons.person,
                        model: model,
                      ),
                    ],
                  ),
                ),
              ),
              onWillPop: () => _onBackPressed(model, context),
            ),
      viewModelBuilder: () => BottomNavbarViewModel(),
      onViewModelReady: (model) => model.initialize(viewIndex),
    );
  }
}

Widget _bottomBarItem(
    {IconData? icon,
    required String name,
    required int index,
    String? imageUrl,
    required BottomNavbarViewModel model}) {
  var color = model.index == index ? CustomColors.primaryColor : Colors.grey;
  return GestureDetector(
    onTap: () => model.updateIndex(index),
    child: Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(
            name,
            style: TextStyle(color: color, fontSize: 10),
          )
        ],
      ),
    ),
  );
}

Future<bool> _onBackPressed(
    BottomNavbarViewModel model, BuildContext context) async {
  if (model.index != 0) {
    model.switchScreen(0);
  } else {
    showExitDialog(context, "");
  }

  return false;
}

showExitDialog(BuildContext context, message) async {
  Widget negativeButton = TextButton(
    child: const Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        "No",
      ),
    ),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );
  Widget positiveButton = TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(CustomColors.blueDarkestColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    child: const Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.white),
      ),
    ),
    onPressed: () {
      Navigator.pop(context, true);
      exit(0);
    },
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    content: Container(
      padding: const EdgeInsets.only(top: 8),
      child: const Text(
        "Do you want to exit?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    actions: [
      negativeButton,
      positiveButton,
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class CustomNotchedRectangle extends NotchedShape {
  const CustomNotchedRectangle();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    const double s1 = 10.0;
    const double s2 = 8.0;
    const double addedRadius = 10;

    final double notchRadius = guest.width / 2.0 + addedRadius;
    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null);

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
