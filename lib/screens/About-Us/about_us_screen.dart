import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';
import 'package:city_eye_citizen_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
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
                        'About Us',
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

              // Content
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
                        // Logo Section
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.ternary)),
                            child: Image.asset(
                              "assets/images/playstore.png",
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Mission Section
                        _buildSection(
                          'Our Mission',
                          'City Eye is dedicated to building safer, cleaner, and more efficient cities through comprehensive civic issue reporting. Our mission is to empower citizens to actively participate in improving their communities by providing a direct channel to report and track various urban issues.',
                        ),

                        // What We Do Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('What We Do'),
                            Text(
                              'City Eye is a comprehensive civic engagement platform that connects citizens with municipal services and law enforcement. We streamline the process of reporting, tracking, and resolving various urban issues to create better communities.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 15),
                            _buildFeaturesList(),
                            SizedBox(height: 30),
                          ],
                        ),

                        // Issue Categories Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('What You Can Report'),
                            Text(
                              'Our platform covers a wide range of civic issues to ensure comprehensive community support:',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 15),
                            _buildIssueCategoriesList(),
                            SizedBox(height: 30),
                          ],
                        ),

                        // Contact Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Contact Us'),
                            _buildContactCard(),
                            SizedBox(height: 30),
                          ],
                        ),

                        // Why Choose Us Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Why Choose City Eye'),
                            Text(
                              'Our platform bridges the gap between citizens and municipal services, law enforcement, and civic authorities. We believe that technology can make civic participation more accessible and effective for everyone.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Join thousands of users who are already making a difference in their communities. Together, we can build safer, cleaner, and more efficient cities for everyone.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),

                        // Version Info
                        _buildVersionInfo(context),
                        SizedBox(height: 20),
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

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.ternary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      'Report traffic violations with photo evidence',
      'Track infrastructure issues and their resolution',
      'Report corruption and bribery incidents securely',
      'Monitor public safety concerns in real-time',
      'Schedule waste collection and environmental reports',
      'Receive updates on reported issues',
      'Contribute to community safety and cleanliness',
    ];

    return Column(
      children: features.map((feature) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.ternary.withOpacity(0.9),
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIssueCategoriesList() {
    final categories = [
      {
        'icon': Icons.traffic,
        'title': 'Traffic Violations',
        'description': 'Over speeding, red light violations, illegal parking'
      },
      {
        'icon': Icons.car_crash,
        'title': 'Traffic Issues',
        'description': 'Traffic jams, accidents, signal problems'
      },
      {
        'icon': Icons.gavel,
        'title': 'Corruption & Bribery',
        'description': 'Report corruption incidents securely and anonymously'
      },
      {
        'icon': Icons.construction,
        'title': 'Infrastructure Issues',
        'description': 'Road damage, drainage, street lights, waste management'
      },
      {
        'icon': Icons.security,
        'title': 'Public Safety',
        'description': 'Street crime, harassment, unsafe areas'
      },
      {
        'icon': Icons.eco,
        'title': 'Environmental Issues',
        'description': 'Pollution, illegal dumping, environmental violations'
      },
      {
        'icon': Icons.public,
        'title': 'Public Services',
        'description': 'Poor service quality, facility issues'
      },
    ];

    return Column(
      children: categories.map((category) {
        return Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.ternary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: AppColors.ternary.withOpacity(0.9),
                  size: 24,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      category['description'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildContactItem(Icons.email, 'Email', 'support@cityeye.lk'),
          SizedBox(height: 15),
          _buildContactItem(Icons.phone, 'Phone', '+94 11 234 5678'),
          SizedBox(height: 15),
          _buildContactItem(Icons.location_on, 'Address', 'Colombo, Sri Lanka'),
          // SizedBox(height: 15),
          // _buildContactItem(Icons.language, 'Website', 'www.cityeye.lk'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.ternary.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVersionInfo(BuildContext ctxt) {
    return Container(
      width: MediaQuery.of(ctxt).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            'City Eye v1.0.0',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '© 2025 City Eye. All rights reserved.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Building safer communities together 🏙️',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
