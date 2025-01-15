import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../app/routes/route_name.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    context: context,
                    title: "Dashboard",
                    icon: Icons.dashboard_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildMenuItem(
                    context: context,
                    title: "Change Password",
                    icon: Icons.lock_rounded,
                    onTap: () => Fluttertoast.showToast(msg: 'Change Password'),
                  ),
                  _buildMenuItem(
                    context: context,
                    title: "Clear Data",
                    icon: Icons.cleaning_services_rounded,
                    onTap: () => Fluttertoast.showToast(msg: 'Cleared Data'),
                  ),
                  _buildMenuItem(
                    context: context,
                    title: "Delete Account",
                    icon: Icons.delete_rounded,
                    color: Colors.red.shade700,
                    onTap: () => Fluttertoast.showToast(msg: 'Account Deleted'),
                  ),
                  const Divider(height: 40),
                  _buildMenuItem(
                    context: context,
                    title: "Logout",
                    icon: Icons.logout_rounded,
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/google.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Organization Name',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        leading: Icon(
          icon,
          color: color ?? Colors.grey.shade700,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color ?? Colors.grey.shade900,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 20,
        horizontalTitleGap: 12,
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.grey,
          ),
          const SizedBox(width: 12),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
         Navigator.of(context).pushNamedAndRemoveUntil(
       AppRoute.splashScreenPath,
           (route) => false,
   );
  }
}