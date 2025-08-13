import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/models/complaint.dart';
import 'package:city_eye_citizen_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';

import '../notifications/notifications.dart';

class ViewReportDetailsScreen extends StatefulWidget {
  const ViewReportDetailsScreen({super.key, required this.report});

  final Complaint report;

  @override
  State<ViewReportDetailsScreen> createState() =>
      _ViewReportDetailsScreenState();
}

class _ViewReportDetailsScreenState extends State<ViewReportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        '  Report Details',
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
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  widget.report.imageUrl,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                widget.report.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Category: ${widget.report.category}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF757575),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Reported Date: ${widget.report.date} - ${widget.report.time}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF757575),
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Status: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF757575),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: ElevatedButton(
                                      onPressed: null,
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                            (widget.report.status) == 'Resolved'
                                                ? Color(0xFFE8F5E8)
                                                : Colors.amber[100],
                                          ),
                                          minimumSize: WidgetStatePropertyAll(
                                              Size(55, 30)),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          )),
                                      child: Text(
                                        widget.report.status,
                                        style: TextStyle(
                                          color: (widget.report.status) ==
                                                  'Resolved'
                                              ? Colors.green[600]
                                              : Colors.yellow[800],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox(), flex: 3),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Resolved Date: ${widget.report.resolvedDate}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF757575),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Description:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                widget.report.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF757575),
                                ),
                              ),
                              if ((widget.report.status) == 'Resolved') ...[
                                SizedBox(height: 20),
                                Text(
                                  'Comments:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment...',
                                    hintStyle:
                                        TextStyle(color: Color(0xFF757575)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.secondary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 20),
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
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'Submit Comment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
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
}
