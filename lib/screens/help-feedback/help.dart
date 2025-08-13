import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/screens/help-feedback/contact_support.dart';
import 'package:city_eye_citizen_app/screens/help-feedback/faq.dart';
import 'package:city_eye_citizen_app/screens/help-feedback/submit_feedback.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';
import 'package:city_eye_citizen_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class FeedbackHelpScreen extends StatelessWidget {
  FeedbackHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.9),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
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
                        'Feedback & Help',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
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
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Main menu items
                        _buildMenuItem(
                          icon: Icons.help_outline,
                          title: 'FAQs',
                          iconColor: AppColors.ternary.withOpacity(0.9),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FAQScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.phone,
                          title: 'Contact Support',
                          iconColor: AppColors.ternary.withOpacity(0.9),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUsScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.feedback_outlined,
                          title: 'Submit Feedback',
                          iconColor: AppColors.ternary.withOpacity(0.9),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubmitFeedbackScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 32),

                        // Terms & Policies section
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Terms & Policies',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: 'Terms of Service',
                          iconColor: Color(0xFF757575),
                          showIcon: false,
                          onTap: () {
                            // Navigate to Terms of Service
                          },
                        ),
                        SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          iconColor: Color(0xFF757575),
                          showIcon: false,
                          onTap: () {
                            // Navigate to Privacy Policy
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
    bool showIcon = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: showIcon
            ? Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              )
            : null,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Color(0xFF757575),
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
}

// Example usage in your main app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abans City Clean',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF4CAF50),
      ),
      home: FeedbackHelpScreen(),
    );
  }
}
