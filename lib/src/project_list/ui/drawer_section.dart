import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/core/core.dart';
import 'package:project_bloc/core/extensions/context_ext.dart';
import 'package:project_bloc/core/services/sharepref/flutter_secure_storage.dart';
import '../../../app/app_info.dart';
import '../../../app/routes/route_name.dart';
import '../../../app/themes/colors.dart';
import '../../../app/themes/textstyle.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: context.screenWidth / 1.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(children: [
          titleSection(context),
          DrawerIconName(
            name: "Dashboard",
            iconName: Icons.dashboard,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          divider(),
          DrawerIconName(
            name: "Delete Account",
            iconName: Icons.delete,
            color: kErrorColor,
            onTap: () {
              Fluttertoast.showToast(msg: 'Account Deleted');
              //Navigator.pushNamed(context, AppRoute.deletePath);
            },
          ),
          divider(),
          DrawerIconName(
            name: "Change Password",
            iconName: Icons.password,
            onTap: () {
              Fluttertoast.showToast(msg: 'Change Password');
             // Navigator.pushNamed(context, AppRoute.changePasswordScreen);
            },
          ),
          divider(),
          DrawerIconName(
            name: "Clear Data",
            iconName: Icons.clear,
            onTap: () {
              Fluttertoast.showToast(msg: 'Cleared Data');
            },
          ),
          divider(),
          DrawerIconName(
            name: "LogOut",
            iconName: Icons.logout,
            onTap: () {
              logOutFlutter(context);
            },
          ),
          divider(),
        ]),
      ).paddingVertical(10.0),
    );
  }

  void logOut(BuildContext context) {
    locator<PrefHelper>().removePreference();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoute.splashScreenPath,
          (route) => false,
    );
  }
  void logOutFlutter(BuildContext context) {
    locator<SecureStorageHelper>().clearAll();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoute.splashScreenPath,
          (route) => false,
    );
  }

  Widget titleSection(context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        border: Border.all(color: kPrimaryColor),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Flexible(
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('assets/images/google.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppInfo.appName, style: kWhiteTitleText),
                    Text(
                      AppInfo.orgName,
                      style: kSubTitleTextBold.copyWith(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).paddingHorizontal(10.0),
              ),
            ],
          ),
          5.pHeight,
          const Divider(),
          5.pHeight,

        ],
      ).paddingAll(10.0),
    );
  }

  Widget divider() {
    return Container(height: 1.0, color: Colors.grey.shade300);
  }
}

class DrawerIconName extends StatelessWidget {
  final String name;
  final IconData iconName;
  final void Function()? onTap;
  final Color? color;

  const DrawerIconName({
    super.key,
    required this.iconName,
    required this.name,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconName,
            size: 25.0,
            color: color ?? kPrimaryColor,
          ).paddingRight(15.0),
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black,
              ),
            ),
          ),
        ],
      ).paddingSymmetric(10.0, 15.0),
    );
  }
}
