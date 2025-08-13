import 'package:city_eye_citizen_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I report a traffic violation?',
      'answer': 'You can report traffic violations by going to the "Report Issue" section and selecting "Traffic Violations". Choose the specific type of violation and provide necessary details including location and description.'
    },
    {
      'question': 'What information should I include when reporting an issue?',
      'answer': 'Please include the exact location, time of incident, detailed description, and if possible, attach photos or videos as evidence. The more information you provide, the better we can address the issue.'
    },
    {
      'question': 'How long does it take to resolve reported issues?',
      'answer': 'Resolution time varies depending on the type and severity of the issue. Emergency issues are prioritized and typically addressed within 24 hours. Other issues may take 3-7 business days.'
    },
    {
      'question': 'Can I track the status of my reported issue?',
      'answer': 'Yes, you can track all your reported issues in the "Complaints" section. You will receive updates on the progress and resolution status of each complaint.'
    },
    {
      'question': 'What types of issues can I report through City Eye?',
      'answer': 'You can report traffic violations, infrastructure issues, waste management problems, corruption & bribery, public safety concerns, environmental pollution, and various other city-related issues.'
    },
    {
      'question': 'Is my personal information kept confidential?',
      'answer': 'Yes, we take privacy seriously. Your personal information is protected and used only for processing your reports. You can report issues anonymously if preferred.'
    },
    {
      'question': 'Can I submit multiple reports for the same issue?',
      'answer': 'Please avoid duplicate reports for the same issue as it may delay processing. If you have additional information about a previously reported issue, you can update your existing complaint.'
    },
    {
      'question': 'What should I do in case of emergency?',
      'answer': 'For immediate emergencies, please contact emergency services directly (119, 110, or 1990). Use City Eye for non-emergency issues that require civic attention.'
    },
    {
      'question': 'How can I provide feedback about the app?',
      'answer': 'You can submit feedback through the "Submit Feedback" option in the Feedback & Help section. We value your suggestions for improving the app and city services.'
    },
    {
      'question': 'Can I edit or delete my reports after submission?',
      'answer': 'You can view and track your submitted reports, but editing or deletion may not be possible once they are under review. Contact support if you need to make changes to a submitted report.'
    }
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
                        'FAQs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
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
                            onTap: () { Navigator.push(
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
                    color:AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Search bar
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search FAQs...',
                              hintStyle: TextStyle(color: Color(0xFF757575)),
                              prefixIcon: Icon(Icons.search, color: Color(0xFF757575)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        
                        // FAQ Items
                        ...faqs.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, String> faq = entry.value;
                          return _buildFAQItem(
                            question: faq['question']!,
                            answer: faq['answer']!,
                            index: index,
                          );
                        }).toList(),
                        
                        SizedBox(height: 20),
                        
                        // Contact support section
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.ternary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.help_center_outlined,
                                color: AppColors.ternary.withOpacity(0.9),
                                size: 40,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Still need help?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Contact our support team for personalized assistance',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF757575),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text('Contact Support'),
                              ),
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

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required int index,
  }) {
    bool isExpanded = expandedIndex == index;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Text(
              question,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: primaryPurpleColor,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
          ),
          if (isExpanded)
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}