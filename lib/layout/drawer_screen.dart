import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/change_password/change_password_screen.dart';
import 'package:shop_app/modules/notifications/notifications_scrren.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/modules/update_profile/update_profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit_mode.dart';
import 'package:shop_app/shared/cubit/states_mode.dart';
import 'package:shop_app/shared/styles/colors.dart';

ClipPath buildDrawer(context) {
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 40,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: const [BoxShadow(color: Colors.black45)],
        ),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _buildRow(
                  Icons.person_pin,
                  "My profile",
                  () => navigateTo(context, const ProfilesScreen()),
                  context,
                ),
                _buildDivider(),
                _buildRow(
                  Icons.person,
                  "Edit profile",
                  () => navigateTo(context, const UpdateProfileScreen()),
                  context,
                ),
                _buildDivider(),
                BlocConsumer<AppCubitMode, AppCubitModeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return _buildRow(
                      Icons.dark_mode,
                      "Dark mode",
                      () => AppCubitMode.get(context).changemode(),
                      context,
                    );
                  },
                ),
                _buildDivider(),
                _buildRow(
                    Icons.change_circle_rounded,
                    "Change Password",
                    () => navigateTo(context, const ChangePasswordScreen()),
                    context),
                _buildDivider(),
                _buildRow(
                  Icons.notifications_active,
                  "Notifications",
                  () => navigateTo(context, const NotificationsScreen()),
                  context,
                ),
                _buildDivider(),
                _buildRow(
                  Icons.logout_outlined,
                  "Logout",
                  () => singout(context),
                  context,
                ),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return const Divider(
    color: defualtColor,
  );
}

Widget _buildRow(
    IconData icon, String title, Function()? iconOnpress, context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        const SizedBox(
          width: 10.0,
        ),
        TextButton(
          onPressed: iconOnpress,
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 5);
    path.quadraticBezierTo(
        size.width, size.height / 6, size.width, size.height / 6);
    path.quadraticBezierTo(size.width, size.height - (size.height / 2),
        size.width - 4, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
