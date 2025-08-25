import 'package:city_eye_citizen_app/constants/color_pallette.dart';
import 'package:city_eye_citizen_app/screens/complaints/map_selection.dart';
import 'package:city_eye_citizen_app/screens/notifications/notifications.dart';
import 'package:city_eye_citizen_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ReportIssueScreen extends StatefulWidget {
  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  String? selectedMainCategory;
  String? selectedSubCategory;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool isLoadingLocation = false;
  String? selectedImagePath;

  // Two-level category structure
  final Map<String, List<String>> issueCategories = {
    'Traffic Violations': [
      'Over Speeding',
      'Running Red Light',
      'Wrong Lane Driving',
      'Illegal Parking',
      'No Helmet/Seatbelt',
      'Using Mobile While Driving',
      'Drunk Driving',
      'Other Traffic Violation'
    ],
    'Traffic Issues': [
      'Traffic Jam',
      'Road Blockage',
      'Accident',
      'Signal Not Working',
      'Road Construction Delay',
      'Vehicle Breakdown',
      'Other Traffic Issue'
    ],
    'Waste Management Issues': [
      'Overflowing Garbage',
      'Illegally Dumped Waste',
      'Overflowing trash can',
      'Waste Burning'
    ],
    'Corruption & Bribery': [
      'Police Bribery',
      'Government Office Bribery',
      'License/Permit Bribery',
      'Traffic Fine Bribery',
      'Public Service Bribery',
      'Other Corruption'
    ],
    'Infrastructure Issues': [
      'Blocked Drainage',
      'Street Light Issue',
      'Road Damage',
      'Broken Sidewalk',
      'Water Supply Issue',
      'Other Infrastructure'
    ],
    'Public Safety': [
      'Street Crime',
      'Harassment',
      'Unsafe Area',
      'Missing Street Lights',
      'Stray Animals',
      'Drug Activity',
      'Other Safety Issue'
    ],
    'Environmental Pollution': [
      'Air Pollution',
      'Water Pollution',
      'Illegal Construction',
      'Tree Cutting',
      'Other Environmental'
    ],
    'Public Services': [
      'Poor Service Quality',
      'Long Waiting Times',
      'Rude Behavior',
      'Facility Not Working',
      'Cleanliness Issues',
      'Graffiti On Wall',
      'Other Service Issue'
    ],
    'Other Issues': ['General Complaint', 'Suggestion', 'Emergency', 'Other']
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoadingLocation = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isLoadingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          isLoadingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            "${place.street}, ${place.locality}, ${place.subAdministrativeArea}";
        setState(() {
          locationController.text = address;
        });
      }
    } catch (e) {
      print('Error getting location: $e');
    } finally {
      setState(() {
        isLoadingLocation = false;
      });
    }
  }

  Future<void> _selectLocationManually() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        locationController.text = result;
      });
    }
  }

  void _submitReport() {
    if (selectedMainCategory == null || selectedSubCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please select both issue category and specific issue!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

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
                        '  Report Issue',
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
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main Issue Category Dropdown
                        Text(
                          'Issue Category',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.8),
                                width: 1),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.category_outlined,
                                  color: AppColors.ternary.withOpacity(0.9)),
                            ),
                            value: selectedMainCategory,
                            hint: Text('Select Issue Category'),
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 15),
                            dropdownColor: Color(0xFFFFFFFF),
                            items: issueCategories.keys.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedMainCategory = newValue;
                                selectedSubCategory =
                                    null; // Reset sub-category
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),

                        // Sub Issue Category Dropdown
                        Text(
                          'Specific Issue',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: selectedMainCategory == null
                                ? Color(0xFFF5F5F5) // Disabled color
                                : Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: selectedMainCategory == null
                                    ? Colors.grey.withOpacity(0.4)
                                    : AppColors.primary.withOpacity(0.8),
                                width: 1),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.list_alt_outlined,
                                color: selectedMainCategory == null
                                    ? Colors.grey
                                    : AppColors.ternary.withOpacity(0.9),
                              ),
                            ),
                            value: selectedSubCategory,
                            hint: Text(
                              selectedMainCategory == null
                                  ? 'Select issue category first'
                                  : 'Select specific issue',
                              style: TextStyle(
                                color: selectedMainCategory == null
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: selectedMainCategory == null
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 15),
                            dropdownColor: Color(0xFFFFFFFF),
                            items: selectedMainCategory == null
                                ? []
                                : issueCategories[selectedMainCategory]!
                                    .map((String issue) {
                                    return DropdownMenuItem<String>(
                                      value: issue,
                                      child: Text(issue),
                                    );
                                  }).toList(),
                            onChanged: selectedMainCategory == null
                                ? null
                                : (String? newValue) {
                                    setState(() {
                                      selectedSubCategory = newValue;
                                    });
                                  },
                          ),
                        ),
                        SizedBox(height: 16),

                        // Description Field
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.8),
                                width: 1),
                          ),
                          child: TextFormField(
                            controller: descriptionController,
                            maxLines: 4,
                            style: TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: 'Describe the issue in detail...',
                              hintStyle: TextStyle(color: Color(0xFF757575)),
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 12, left: 12, right: 12),
                                child: Icon(Icons.description_outlined,
                                    color: AppColors.ternary.withOpacity(0.9)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Photo Upload Section
                        Text(
                          'Photo',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.9),
                                width: 1),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt,
                                  color: Color(0xFF757575), size: 50),
                              SizedBox(height: 10),
                              Text(
                                'Add Photo',
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                              Text(
                                'Tap to capture or select a photo',
                                style: TextStyle(color: Color(0xFF757575)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Location Section
                        Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.9),
                                width: 1),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.1),
                            //     spreadRadius: 1,
                            //     blurRadius: 4,
                            //     offset: Offset(0, 2),
                            //   ),
                            // ],
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: locationController,
                                readOnly: true,
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 16),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                  border: InputBorder.none,
                                  prefixIcon: isLoadingLocation
                                      ? Padding(
                                          padding: EdgeInsets.all(16),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColors.primary),
                                            ),
                                          ),
                                        )
                                      : Icon(Icons.location_on_outlined,
                                          color: AppColors.ternary
                                              .withOpacity(0.9)),
                                  hintText: isLoadingLocation
                                      ? 'Getting current location...'
                                      : 'Location will appear here',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: AppColors.primary.withOpacity(0.2),
                              ),
                              InkWell(
                                onTap: _selectLocationManually,
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Icon(Icons.map_outlined,
                                          color: AppColors.ternary
                                              .withOpacity(0.9),
                                          size: 22),
                                      SizedBox(width: 12),
                                      Text(
                                        'Select Manually',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Colors.black,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: _submitReport,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Submit Report',
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
}
