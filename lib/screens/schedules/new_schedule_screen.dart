import 'dart:convert';
import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/models/city_service.dart';
import 'package:city_eye_citizen_app/models/schedule.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';
import 'package:city_eye_citizen_app/screens/schedules/next_collection_day_screen.dart';
import 'package:city_eye_citizen_app/screens/schedules/services_schedule_details.dart';
import 'package:city_eye_citizen_app/screens/schedules/waste_schedule_details.dart';
import 'package:city_eye_citizen_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class CitySchedulesScreen extends StatefulWidget {
  @override
  _CitySchedulesScreenState createState() => _CitySchedulesScreenState();
}

class _CitySchedulesScreenState extends State<CitySchedulesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;

  // Garbage Collection Data
  List<Schedule> allCollections = [];
  String selectedGarbageCategory = 'All';
  final List<String> garbageCategories = [
    'All',
    'Plastic',
    'Organic Waste',
    'Polythene',
    'Glass'
  ];

  // City Services Data
  List<CityService> allCityServices = [];
  String selectedServiceCategory = 'All';
  final List<String> serviceCategories = [
    'All',
    'Traffic Management',
    'Infrastructure',
    'Public Safety',
    'Environmental',
    'Utilities'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadGarbageCollections(),
      _loadCityServices(),
    ]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadGarbageCollections() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/schedule_collection.json');
      final Map<String, dynamic> data = json.decode(response);
      setState(() {
        allCollections = (data['collections'] as List<dynamic>)
            .map((json) => Schedule.fromJson(json))
            .toList();
      });
    } catch (e) {
      print('Error loading garbage collections: $e');
      // Mock data for demonstration
    }
  }

  Future<void> _loadCityServices() async {
    try {
      // Try to load from JSON file first
      final String response =
          await rootBundle.loadString('assets/json/city_services.json');
      final Map<String, dynamic> data = json.decode(response);
      setState(() {
        allCityServices = (data['services'] as List<dynamic>)
            .map((json) => CityService.fromJson(json))
            .toList();
      });
    } catch (e) {
      print('Error loading city services: $e');
      // Mock data for demonstration
      setState(() {
        allCityServices = [
          CityService(
            serviceName: "Traffic Signal Maintenance",
            date: "10 June",
            time: "9:00 AM to 11:00 AM",
            location: "Galle Road Junction",
            category: "Traffic Management",
            status: "Scheduled",
            description: "Regular maintenance of traffic signals",
          ),
          CityService(
            serviceName: "Street Light Repair",
            date: "11 June",
            time: "7:00 PM to 9:00 PM",
            location: "Marine Drive",
            category: "Infrastructure",
            status: "In Progress",
            description: "Replacing faulty street light bulbs",
          ),
          CityService(
            serviceName: "Road Cleaning",
            date: "13 June",
            time: "6:00 AM to 8:00 AM",
            location: "Colombo City Center",
            category: "Environmental",
            status: "Scheduled",
            description: "Weekly road cleaning service",
          ),
          CityService(
            serviceName: "Water Supply Maintenance",
            date: "14 June",
            time: "10:00 AM to 2:00 PM",
            location: "Bambalapitiya",
            category: "Infrastructure",
            status: "Scheduled",
            description: "Scheduled water line maintenance",
          ),
        ];
      });
    }
  }

  List<Schedule> get filteredGarbageCollections {
    if (selectedGarbageCategory == 'All') {
      return allCollections;
    }
    return allCollections
        .where(
            (collection) => collection.types.contains(selectedGarbageCategory))
        .toList();
  }

  List<CityService> get filteredCityServices {
    if (selectedServiceCategory == 'All') {
      return allCityServices;
    }
    return allCityServices
        .where((service) => service.category == selectedServiceCategory)
        .toList();
  }

  // Color _getStatusColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'scheduled':
  //       return Colors.blue;
  //     case 'in progress':
  //       return Colors.orange;
  //     case 'completed':
  //       return Colors.green;
  //     case 'cancelled':
  //       return Colors.red;
  //     default:
  //       return Colors.grey;
  //   }
  // }

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
                  child: Column(
                    children: [
                      // Tab Bar
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[600],
                          indicator: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_shipping, size: 18),
                                  SizedBox(width: 8),
                                  Text('Waste Collection'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_city, size: 18),
                                  SizedBox(width: 8),
                                  Text('City Services'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tab Content
                      Expanded(
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primary.withOpacity(0.9)),
                                ),
                              )
                            : TabBarView(
                                controller: _tabController,
                                children: [
                                  _buildGarbageCollectionTab(),
                                  _buildCityServicesTab(),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGarbageCollectionTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category filters
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Garbage Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: garbageCategories.map((category) {
                    bool isSelected = selectedGarbageCategory == category;
                    return Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGarbageCategory = category;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.ternary.withOpacity(0.9)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.ternary.withOpacity(0.9)
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Collection list
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: filteredGarbageCollections.length,
              itemBuilder: (context, index) {
                final collection = filteredGarbageCollections[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    leading: Container(
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.ternary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        FontAwesomeIcons.truck,
                        color: AppColors.ternary.withOpacity(0.9),
                        size: 25,
                      ),
                    ),
                    title: Text(
                      collection.date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Time - ${collection.time}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Location - ${collection.location}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: collection.types.map((type) {
                            // Color chipColor = _getGarbageTypeColor(type);
                            Color chipColor = AppColors.secondary.withOpacity(0.1);

                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: chipColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                type,
                                style: TextStyle(
                                  color: chipColor.withOpacity(0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleDetailsScreen(
                              date: collection.date,
                              time: collection.time,
                              location: collection.location,
                              categories: collection.types.join(', '),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom buttons for garbage collection
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Show calendar dialog
                    CalendarPopup.showCalendarDialog(context, allCollections);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View calendar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Schedule? nextCollection = getNextCollectionDay();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextCollectionDayScreen(
                          date: nextCollection!.date,
                          time: nextCollection.time,
                          location: nextCollection.location,
                          categories: nextCollection.types.join(', '),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next collection day',
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
      ],
    );
  }

  Widget _buildCityServicesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service category filters
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: serviceCategories.map((category) {
                    bool isSelected = selectedServiceCategory == category;
                    return Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedServiceCategory = category;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.ternary.withOpacity(0.9)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.ternary.withOpacity(0.9)
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Services list
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: filteredCityServices.length,
              itemBuilder: (context, index) {
                final service = filteredCityServices[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.ternary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getCategoryIcon(service.category),
                        color: AppColors.ternary.withOpacity(0.9),
                        size: 30,
                      ),
                    ),
                    title: Text(
                      service.serviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          '${service.date} - ${service.time}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Location - ${service.location}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                service.category,
                                style: TextStyle(
                                  // color: Colors.grey[700],
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        // Navigate to service details screen
                        _showServiceDetails(service);
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CityServicesScheduleDetails(
                        //       date: service.date,
                        //       time: service.time,
                        //       location: service.location,
                        //       categories: service.serviceName,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom button for city services
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Show all services calendar or filter options
                _showServiceCalendar();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Service Calendar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Schedule? getNextCollectionDay() {
    DateTime today = DateTime.now();

    // Convert all collections to DateTime objects with their data
    List<MapEntry<DateTime, Schedule>> collectionsWithDates = [];

    for (var collection in allCollections) {
      DateTime? collectionDate = _parseDate(collection.date);
      if (collectionDate != null) {
        collectionsWithDates.add(MapEntry(collectionDate, collection));
      }
    }

    // Sort by date
    collectionsWithDates.sort((a, b) => a.key.compareTo(b.key));

    // Find the next collection after today
    for (var entry in collectionsWithDates) {
      if (entry.key.isAfter(today) || isSameDay(entry.key, today)) {
        return entry.value;
      }
    }

    // If no upcoming collections, return the first one (cycle back)
    return collectionsWithDates.isNotEmpty
        ? collectionsWithDates.first.value
        : null;
  }

  // Add this helper method for date parsing (same as CalendarPopup)
  DateTime? _parseDate(String dateStr) {
    try {
      List<String> parts = dateStr.split(' ');
      if (parts.length >= 3) {
        int day = int.parse(parts[1]);
        String month = parts[2];
        int year = DateTime.now().year;

        Map<String, int> monthMap = {
          'January': 1,
          'February': 2,
          'March': 3,
          'April': 4,
          'May': 5,
          'June': 6,
          'July': 7,
          'August': 8,
          'September': 9,
          'October': 10,
          'November': 11,
          'December': 12
        };

        int? monthNum = monthMap[month];
        if (monthNum != null) {
          return DateTime(year, monthNum, day);
        }
      }
    } catch (e) {
      print('Error parsing date: $dateStr');
    }
    return null;
  }

  // Helper method to check if two dates are the same day
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Color _getGarbageTypeColor(String type) {
    switch (type) {
      case 'Plastic':
        return Color.fromARGB(255, 192, 145, 4);
      case 'Organic Waste':
        return Color.fromARGB(255, 42, 152, 2);
      case 'Polythene':
        return Color.fromARGB(255, 240, 21, 21);
      case 'Glass':
        return Color.fromARGB(255, 9, 85, 237);
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Traffic Management':
        return Icons.traffic;
      case 'Infrastructure':
        return Icons.construction;
      case 'Public Safety':
        return Icons.security;
      case 'Environmental':
        return Icons.eco;
      case 'Utilities':
        return Icons.water_drop;
      default:
        return Icons.miscellaneous_services;
    }
  }

  void _showServiceDetails(CityService service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            service.serviceName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(Icons.calendar_today, 'Date', service.date),
              _buildDetailRow(Icons.access_time, 'Time', service.time),
              _buildDetailRow(Icons.location_on, 'Location', service.location),
              _buildDetailRow(Icons.category, 'Category', service.category),
              _buildDetailRow(Icons.info, 'Status', service.status),
              SizedBox(height: 10),
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(service.description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: TextStyle(color: AppColors.secondary)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          SizedBox(width: 8),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showServiceCalendar() {
    // Implement service calendar view
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Service calendar feature coming soon!'),
        backgroundColor: Color.fromARGB(255, 108, 65, 182),
      ),
    );
  }
}

class CalendarPopup {
  // Define colors for each category
  static final Map<String, Color> categoryColors = {
    'Plastic': const Color.fromARGB(255, 192, 145, 4),
    'Organic Waste': const Color.fromARGB(255, 42, 152, 2),
    'Polythene': const Color.fromARGB(255, 240, 21, 21),
    'Glass': const Color.fromARGB(255, 9, 85, 237),
  };

  // Parse date string to DateTime
  static DateTime? _parseDate(String dateStr) {
    try {
      // Parse "Wed 18 June" format
      List<String> parts = dateStr.split(' ');
      if (parts.length >= 3) {
        int day = int.parse(parts[1]);
        String month = parts[2];
        int year = DateTime.now().year; // Assume current year

        Map<String, int> monthMap = {
          'January': 1,
          'February': 2,
          'March': 3,
          'April': 4,
          'May': 5,
          'June': 6,
          'July': 7,
          'August': 8,
          'September': 9,
          'October': 10,
          'November': 11,
          'December': 12
        };

        int? monthNum = monthMap[month];
        if (monthNum != null) {
          return DateTime(year, monthNum, day);
        }
      }
    } catch (e) {
      print('Error parsing date: $dateStr');
    }
    return null;
  }

  // Updated to handle multiple types per collection
  static Map<DateTime, List<String>> _generateCollectionEvents(
      List<Schedule> collections) {
    Map<DateTime, List<String>> events = {};

    for (var collection in collections) {
      DateTime? date = _parseDate(collection.date);
      if (date != null) {
        List<String> types = List<String>.from(collection.types);
        if (events[date] == null) {
          events[date] = [];
        }
        // Add all types for this collection date
        for (String type in types) {
          if (!events[date]!.contains(type)) {
            events[date]!.add(type);
          }
        }
      }
    }

    return events;
  }

  static void showCalendarDialog(
      BuildContext context, List<Schedule> collections) {
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;

    Map<DateTime, List<String>> collectionEvents =
        _generateCollectionEvents(collections);

    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 24, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 24, kToday.day);
    CalendarFormat _calendarFormat = CalendarFormat.month;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.75,
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Collection Schedule',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),

                    // Calendar
                    TableCalendar<String>(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      eventLoader: (day) {
                        return collectionEvents[
                                DateTime(day.year, day.month, day.day)] ??
                            [];
                      },
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: true,
                        weekendTextStyle: TextStyle(color: Colors.black),
                        selectedDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        todayTextStyle: TextStyle(color: Colors.black),
                        markersMaxCount: 4, // Increased to show more markers
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, day, events) {
                          if (events.isNotEmpty) {
                            return Positioned(
                              bottom: 4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: events.take(4).map((event) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 1),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color:
                                          categoryColors[event] ?? Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          // Call `setState()` when updating the selected day
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                        setState(() {
                          selectedDay = selectedDay;
                          focusedDay = focusedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        focusedDay = focusedDay;
                      },
                    ),

                    // ignore: unnecessary_null_comparison
                    if (_selectedDay != null &&
                        collectionEvents[DateTime(_selectedDay!.year,
                                _selectedDay!.month, _selectedDay!.day)] !=
                            null)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Collections on ${_selectedDay!.day}/${_selectedDay!.month}:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: collectionEvents[DateTime(
                                      _selectedDay!.year,
                                      _selectedDay!.month,
                                      _selectedDay!.day)]!
                                  .map((type) {
                                Color chipColor =
                                    categoryColors[type] ?? Colors.grey;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: chipColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: chipColor, width: 1),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: chipColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 20),

                    // Color Legend
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Garbage Types:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: categoryColors.entries.map((entry) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: entry.value,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
