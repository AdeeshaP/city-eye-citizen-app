import 'package:abans_city_clean_user_app/screens/About-Us/about_us_screen.dart';
import 'package:abans_city_clean_user_app/screens/history/complaints_history.dart';
import 'package:abans_city_clean_user_app/screens/complaints/report_issue_screen.dart';
import 'package:abans_city_clean_user_app/screens/help-feedback/help.dart';
import 'package:abans_city_clean_user_app/screens/notifications/notifications.dart';
import 'package:abans_city_clean_user_app/screens/schedules/new_schedule_screen.dart';
import 'package:abans_city_clean_user_app/screens/settings/settings.dart';
import 'package:abans_city_clean_user_app/screens/user-login/register_user.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 191, 0),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        '  Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationsScreen(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsScreen()),
                              );
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 248, 237, 133),
                                Color.fromARGB(255, 248, 244, 244),
                                Color.fromARGB(255, 248, 237, 133),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/images/city eye.png",
                            ),
                          )),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            buildNavigationButtons(
                              icon: Icons.person_add,
                              title: 'Register',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            buildNavigationButtons(
                              icon: Icons.report_problem,
                              title: 'Report Issue',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReportIssueScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            buildNavigationButtons(
                              icon: Icons.record_voice_over,
                              title: 'Complaints',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyReportsScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            buildNavigationButtons(
                              icon: Icons.help,
                              title: 'Feedbak & Help',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FeedbackHelpScreen()),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            buildNavigationButtons(
                              icon: Icons.info,
                              title: 'About Us',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutUsPage()),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            buildNavigationButtons(
                              icon: Icons.calendar_month,
                              title: 'Schedules',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        // CollectionSchedules()
                                        CitySchedulesScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavigationButtons({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 108, 65, 182),
          // color: primaryPurpleColor.withOpacity(0.95),
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
