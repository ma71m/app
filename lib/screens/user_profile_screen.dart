import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/screens/login_screen.dart';
import 'package:sahla/services/providers.dart';
import 'package:sahla/utils/fadeslide.dart';
import 'package:sahla/utils/slideRoute.dart';

import 'order_history_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: Text(
          'Profile',
          style: AppStyles.primaryFont.copyWith(
            color: AppStyles.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 16),
          _buildOption(
            context,
            'Order History',
            Icons.history,
            () {
              Navigator.push(
                  context, FadeSlideRoute(page:  OrderHistoryScreen()));
            },
          ),
          _buildOption(
            context,
            'Settings',
            Icons.settings,
            () {},
          ),
          _buildOption(
            context,
            'Logout',
            Icons.exit_to_app,
            () async {
              final userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              await userProvider.logout();
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                SlideRoute(page: const MainView(index: 0)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Row(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/Logo.png'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Text(
                userProvider.displayName ?? 'No display name',
                style: AppStyles.userProfileName,
              ),
              const SizedBox(height: 4),
              Text(
                userProvider.email ?? 'No email',
                style: AppStyles.userProfileEmail,
              ),
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          radius: 10,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: AppStyles.darkOrange,
                borderRadius: BorderRadius.circular(10)),
            child:
                const Icon(Icons.mode_edit_outlined, color: Color(0xFF373A40)),
          ),
        )
      ],
    );
  }

  Widget _buildOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: AppStyles.primaryFont,
      ),
      onTap: onPressed,
    );
  }
}
