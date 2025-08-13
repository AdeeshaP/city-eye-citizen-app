import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../settings/settings.dart';

class NextCollectionDayScreen extends StatelessWidget {
  final String date;
  final String time;
  final String location;
  final String categories; // This now contains comma-separated categories

  NextCollectionDayScreen({
    Key? key,
    required this.date,
    required this.time,
    required this.location,
    required this.categories,
  }) : super(key: key);

  // Parse the comma-separated categories string into a list
  List<String> get categoryList {
    return categories.split(', ').map((cat) => cat.trim()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.9),
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
                        'Schedules',
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
                            onTap: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsScreen()),
                              );},
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
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Collection Info Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Next Garbage Collection Day",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                date,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Time: $time PM',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  // color: _getCategoryColor(category)
                                  //     .withOpacity(0.2),
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Garbage Category : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      categories,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),

                        SizedBox(height: 10),

                        // Instructions Section
                        Text(
                          'Collection Instructions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        SizedBox(height: 16),

                        _buildInstructionItem(
                          icon: Icons.access_time,
                          text:
                              'Place bins outside by 7:00 am on collection day.',
                        ),
                        SizedBox(height: 12),
                        _buildInstructionItem(
                          icon: Icons.warning_amber_rounded,
                          text:
                              'Do not include - hazardous waste, e-waste, or bulky items.',
                        ),
                        SizedBox(height: 12),
                        _buildInstructionItem(
                          icon: Icons.check_circle_outline,
                          text:
                              'Ensure the bin lid is completely closed – overfilled bins may not be collected.',
                        ),

                        SizedBox(height: 24),

                        // Category Description Section - Updated for multiple categories
                        Text(
                          categoryList.length > 1
                              ? 'Waste Categories Information'
                              : 'Waste Category Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Display each category with its own card
                        ...categoryList
                            .map((category) => Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 12),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(category)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _getCategoryColor(category)
                                          .withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  _getCategoryColor(category),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              _getCategoryIcon(category),
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              category,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    _getCategoryColor(category),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        _getCategoryDescription(category),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),

                        SizedBox(height: 10),

                        // Action Buttons
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Track Garbage Truck',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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

  Widget _buildInstructionItem({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.ternary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.ternary.withOpacity(0.9),
            size: 18,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase().trim()) {
      case 'organic waste':
        return Color.fromARGB(255, 42, 152, 2); // Orange
      case 'plastic':
        return Color.fromARGB(255, 192, 145, 4); // Blue
      case 'polythene':
        return Color.fromARGB(255, 240, 21, 21); // Purple
      case 'glass':
        return Color.fromARGB(255, 9, 66, 237); // Pink
      case 'all':
      default:
        return Color(0xFFFF9800); // Orange
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase().trim()) {
      case 'organic waste':
        return Icons.recycling;
      case 'glass':
        return FontAwesomeIcons.wineGlass;
      case 'polythene':
        return FontAwesomeIcons.bagShopping;
      case 'plastic':
        return FontAwesomeIcons.bottleWater;
      case 'all':
      default:
        return Icons.delete_outline;
    }
  }

  String _getCategoryDescription(String category) {
    switch (category.toLowerCase().trim()) {
      case 'organic waste':
        return 'Food scraps & garden waste only (no plastic bags or containers)';
      case 'plastic':
        return 'Clean plastic containers, bottles, and hard plastic items only (rinse before disposal)';
      case 'polythene':
        return 'Thin plastic films like shopping bags, wrappers, and packing sheets (must be clean and dry)';
      case 'glass':
        return 'Glass bottles, jars, and containers (rinsed and unbroken preferred)';
      case 'all':
      default:
        return 'General household waste including mixed materials (excluding hazardous items)';
    }
  }
}
