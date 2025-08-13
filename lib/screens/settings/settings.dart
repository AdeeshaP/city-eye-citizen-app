import 'package:flutter/material.dart';
import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool locationServices = true;
  bool anonymousReporting = false;
  bool autoLocationDetection = true;
  bool soundEffects = true;
  bool vibration = true;
  String selectedLanguage = 'English';

  final List<String> languages = [
    'English',
    'Sinhala',
    'Tamil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 255, 191, 0),
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
                        'Settings',
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
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {},
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Account Section
                        _buildSectionHeader('Account'),
                        _buildMenuItem(
                          icon: Icons.person_outline,
                          title: 'Profile Settings',
                          subtitle: 'Update your personal information',
                          iconColor: AppColors.ternary.withOpacity(0.9),
                          onTap: () {
                            // Navigate to Profile Settings
                          },
                        ),
                        SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.lock_outline,
                          title: 'Security',
                          subtitle: 'Password and security settings',
                          iconColor: AppColors.ternary.withOpacity(0.9),
                          onTap: () {
                            // Navigate to Security Settings
                          },
                        ),
                        SizedBox(height: 24),

                        // Notifications Section
                        _buildSectionHeader('Notifications'),
                        _buildSwitchTile(
                          icon: Icons.notifications_active_outlined,
                          title: 'Push Notifications',
                          subtitle: 'Receive alerts about report updates',
                          value: pushNotifications,
                          onChanged: (value) {
                            setState(() {
                              pushNotifications = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _buildSwitchTile(
                          icon: Icons.email_outlined,
                          title: 'Email Notifications',
                          subtitle: 'Get status updates via email',
                          value: emailNotifications,
                          onChanged: (value) {
                            setState(() {
                              emailNotifications = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _buildSwitchTile(
                          icon: Icons.sms_outlined,
                          title: 'SMS Alerts',
                          subtitle: 'Receive important updates via SMS',
                          value: smsNotifications,
                          onChanged: (value) {
                            setState(() {
                              smsNotifications = value;
                            });
                          },
                        ),
                        SizedBox(height: 24),

                        // Privacy & Location Section
                        _buildSectionHeader('Privacy & Location'),
                        _buildSwitchTile(
                          icon: Icons.location_on_outlined,
                          title: 'Location Services',
                          subtitle: 'Allow location access for reports',
                          value: locationServices,
                          onChanged: (value) {
                            setState(() {
                              locationServices = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _buildSwitchTile(
                          icon: Icons.my_location_outlined,
                          title: 'Auto Location Detection',
                          subtitle: 'Automatically detect your location',
                          value: autoLocationDetection,
                          onChanged: (value) {
                            setState(() {
                              autoLocationDetection = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _buildSwitchTile(
                          icon: Icons.visibility_off_outlined,
                          title: 'Anonymous Reporting',
                          subtitle: 'Submit reports without your identity',
                          value: anonymousReporting,
                          onChanged: (value) {
                            setState(() {
                              anonymousReporting = value;
                            });
                          },
                        ),
                        SizedBox(height: 24),

                        // App Preferences Section
                        _buildSectionHeader('App Preferences'),
                        _buildDropdownTile(
                          icon: Icons.language_outlined,
                          title: 'Language',
                          subtitle: 'Choose your preferred language',
                          value: selectedLanguage,
                          items: languages,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _buildSwitchTile(
                          icon: Icons.volume_up_outlined,
                          title: 'Sound Effects',
                          subtitle: 'Play sounds for app interactions',
                          value: soundEffects,
                          onChanged: (value) {
                            setState(() {
                              soundEffects = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _buildSwitchTile(
                          icon: Icons.vibration_outlined,
                          title: 'Vibration',
                          subtitle: 'Vibrate for notifications',
                          value: vibration,
                          onChanged: (value) {
                            setState(() {
                              vibration = value;
                            });
                          },
                        ),
                        SizedBox(height: 24),

                        // Data & Storage Section
                        _buildSectionHeader('Data & Storage'),
                        _buildMenuItem(
                          icon: Icons.cloud_sync_outlined,
                          title: 'Data Sync',
                          subtitle: 'Sync your data across devices',
                          iconColor: Color(0xFF757575),
                          showIcon: false,
                          onTap: () {
                            // Navigate to Data Sync settings
                          },
                        ),
                        SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.storage_outlined,
                          title: 'Storage Usage',
                          subtitle: 'View app storage and cache usage',
                          iconColor: Color(0xFF757575),
                          showIcon: false,
                          onTap: () {
                            _showStorageDialog();
                          },
                        ),
                        SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.download_outlined,
                          title: 'Download Quality',
                          subtitle: 'Set image and video download quality',
                          iconColor: Color(0xFF757575),
                          showIcon: false,
                          onTap: () {
                            // Navigate to Download Quality settings
                          },
                        ),
                        SizedBox(height: 24),
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

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                  size: 22,
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
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Color(0xFF999999),
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.ternary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: AppColors.ternary.withOpacity(0.9),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.ternary,
          activeTrackColor: AppColors.ternary.withOpacity(0.3),
          inactiveThumbColor: Color(0xFFE0E0E0),
          inactiveTrackColor: Color(0xFFF5F5F5),
        ),
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.ternary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: AppColors.ternary.withOpacity(0.9),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE9ECEF)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              icon:
                  Icon(Icons.expand_more, color: primaryPurpleColor, size: 20),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  void _showStorageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.storage_outlined, color: primaryPurpleColor),
              SizedBox(width: 12),
              Text('Storage Usage'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStorageItem('App Data', '45.2 MB'),
              _buildStorageItem('Cache', '12.8 MB'),
              _buildStorageItem('Images', '23.4 MB'),
              _buildStorageItem('Documents', '8.1 MB'),
              Divider(),
              _buildStorageItem('Total', '89.5 MB', isTotal: true),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Clear cache logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cache cleared successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Clear Cache'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStorageItem(String label, String size, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? Color(0xFF333333) : Color(0xFF666666),
            ),
          ),
          Text(
            size,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? primaryPurpleColor : Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
