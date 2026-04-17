// ignore_for_file: strict_top_level_inference, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  bool Darkmode = true;
  @override
  void initState() {
    super.initState();
    _LodeUserName();
  }

  void _LodeUserName() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString("username");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFffffff),
                ),
              ),
            ),

            // Profile Image + Name
            Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/Thumbnail.png'),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(160),
                            color: Color(0xFF282828),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 7),

                Text(
                  username ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),

                Text(
                  "One task at a time. One step closer.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Profile Info",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ),

            SizedBox(height: 7),

            // ✅ ITEM 1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.person_2_outlined),
                    title: Text(
                      "User Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Divider(color: Color(0xFF6C6C6C)),
                ],
              ),
            ),

            // ✅ ITEM 2 (Dark Mode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.dark_mode_outlined),
                    title: Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Switch(
                      value: Darkmode,
                      onChanged: (bool value) {
                        setState(() {
                          Darkmode = value;
                        });
                      },
                    ),
                  ),
                  Divider(color: Color(0xFF6C6C6C)),
                ],
              ),
            ),

            // ✅ ITEM 3 (Logout)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Divider(color: Color(0xFF6C6C6C)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
