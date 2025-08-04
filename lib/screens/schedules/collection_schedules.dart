// import 'package:abans_city_clean_user_app/models/schedule.dart';
// import 'package:abans_city_clean_user_app/screens/schedules/next_collection_day_screen.dart';
// import 'package:abans_city_clean_user_app/screens/schedules/schedule_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'dart:convert';

// class CollectionSchedules extends StatefulWidget {
//   @override
//   _CollectionSchedulesState createState() => _CollectionSchedulesState();
// }

// class _CollectionSchedulesState extends State<CollectionSchedules> {
//   String selectedCategory = 'All';
//   bool isLoading = true;
//   // List<Map<String, dynamic>> allCollections = [];
//   List<Schedule> allCollections = [];

//   final List<String> categories = [
//     'All',
//     'Plastic',
//     'Organic Waste',
//     'Polythene',
//     'Glass'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadCollections();
//   }

//   // Load collections from JSON file
//   Future<void> _loadCollections() async {
//     try {
//       final String response =
//           await rootBundle.loadString('assets/json/schedule_collection.json');
//       final Map<String, dynamic> data = json.decode(response);
//       setState(() {
//         // allCollections = List<Map<String, dynamic>>.from(data['collections']);
//         allCollections = (data['collections'] as List<dynamic>)
//             .map((json) => Schedule.fromJson(json))
//             .toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error loading collections: $e');
//       setState(() {
//         allCollections = [];
//         isLoading = false;
//       });
//     }
//   }

//   // Updated filtering logic
//   // List<Map<String, dynamic>> get filteredCollections {
//   //   if (selectedCategory == 'All') {
//   //     return allCollections;
//   //   }
//   //   return allCollections
//   //       .where((collection) =>
//   //           (collection['types'] as List<dynamic>).contains(selectedCategory))
//   //       .toList();
//   // }
//   List<Schedule> get filteredCollections {
//     if (selectedCategory == 'All') {
//       return allCollections;
//     }
//     return allCollections
//         .where((collection) => collection.types.contains(selectedCategory))
//         .toList();
//   }

//   // Map<String, dynamic>? getNextCollectionDay() {
//   //   DateTime today = DateTime.now();

//   //   List<MapEntry<DateTime, Map<String, dynamic>>> collectionsWithDates = [];

//   //   for (var collection in allCollections) {
//   //     DateTime? collectionDate = _parseDate(collection['date']);
//   //     if (collectionDate != null) {
//   //       collectionsWithDates.add(MapEntry(collectionDate, collection));
//   //     }
//   //   }

//   //   // Sort by date
//   //   collectionsWithDates.sort((a, b) => a.key.compareTo(b.key));

//   //   // Find the next collection after today
//   //   for (var entry in collectionsWithDates) {
//   //     if (entry.key.isAfter(today) || isSameDay(entry.key, today)) {
//   //       return entry.value;
//   //     }
//   //   }

//   //   // If no upcoming collections, return the first one (cycle back)
//   //   return collectionsWithDates.isNotEmpty
//   //       ? collectionsWithDates.first.value
//   //       : null;
//   // }
//   Schedule? getNextCollectionDay() {
//     DateTime today = DateTime.now();

//     // Convert all collections to DateTime objects with their data
//     List<MapEntry<DateTime, Schedule>> collectionsWithDates = [];

//     for (var collection in allCollections) {
//       DateTime? collectionDate = _parseDate(collection.date);
//       if (collectionDate != null) {
//         collectionsWithDates.add(MapEntry(collectionDate, collection));
//       }
//     }

//     // Sort by date
//     collectionsWithDates.sort((a, b) => a.key.compareTo(b.key));

//     // Find the next collection after today
//     for (var entry in collectionsWithDates) {
//       if (entry.key.isAfter(today) || isSameDay(entry.key, today)) {
//         return entry.value;
//       }
//     }

//     // If no upcoming collections, return the first one (cycle back)
//     return collectionsWithDates.isNotEmpty
//         ? collectionsWithDates.first.value
//         : null;
//   }

//   // Add this helper method for date parsing (same as CalendarPopup)
//   DateTime? _parseDate(String dateStr) {
//     try {
//       List<String> parts = dateStr.split(' ');
//       if (parts.length >= 3) {
//         int day = int.parse(parts[1]);
//         String month = parts[2];
//         int year = DateTime.now().year;

//         Map<String, int> monthMap = {
//           'January': 1,
//           'February': 2,
//           'March': 3,
//           'April': 4,
//           'May': 5,
//           'June': 6,
//           'July': 7,
//           'August': 8,
//           'September': 9,
//           'October': 10,
//           'November': 11,
//           'December': 12
//         };

//         int? monthNum = monthMap[month];
//         if (monthNum != null) {
//           return DateTime(year, monthNum, day);
//         }
//       }
//     } catch (e) {
//       print('Error parsing date: $dateStr');
//     }
//     return null;
//   }

//   // Helper method to check if two dates are the same day
//   bool isSameDay(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         // decoration: BoxDecoration(
//         //   gradient: LinearGradient(
//         //     begin: Alignment.topLeft,
//         //     end: Alignment.bottomRight,
//         //     colors: [
//         //       Color(0xFFFFC107),
//         //       Color(0xFF673AB7),
//         //       Color(0xFFFFC107),
//         //       Color(0xFF673AB7),
//         //       Color(0xFFFFC107),
//         //     ],
//         //   ),
//         // ),
//         decoration: BoxDecoration(
//           color: Color.fromARGB(255, 255, 191, 0),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Schedules',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 5.0),
//                           child: GestureDetector(
//                             onTap: () {},
//                             child: Icon(
//                               Icons.notifications,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 6.0),
//                           child: GestureDetector(
//                             onTap: () {},
//                             child: Icon(
//                               Icons.settings,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                   ),
//                   child: isLoading
//                       ? Center(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                                 Color(0xFFFFC107)),
//                           ),
//                         )
//                       : Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Category filters
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 15.0, vertical: 20),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Garbage Categories',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     SizedBox(height: 16),
//                                     SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Row(
//                                         children: categories.map((category) {
//                                           bool isSelected =
//                                               selectedCategory == category;
//                                           return Padding(
//                                             padding:
//                                                 EdgeInsets.only(right: 6.0),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   selectedCategory = category;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 25,
//                                                     vertical: 12),
//                                                 decoration: BoxDecoration(
//                                                   color: isSelected
//                                                       ? Color(0xFFFFC107)
//                                                       : Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                   border: Border.all(
//                                                     color: isSelected
//                                                         ? Color(0xFFFFC107)
//                                                         : Colors.grey.shade300,
//                                                     width: 1,
//                                                   ),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.black
//                                                           .withOpacity(0.05),
//                                                       blurRadius: 4,
//                                                       offset: Offset(0, 2),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 child: Text(
//                                                   category,
//                                                   style: TextStyle(
//                                                     color: isSelected
//                                                         ? Colors.white
//                                                         : Colors.black,
//                                                     fontWeight: isSelected
//                                                         ? FontWeight.w800
//                                                         : FontWeight.w500,
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               SizedBox(height: 5),

//                               // Collection list
//                               Container(
//                                 height: 400,
//                                 child: Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 20.0),
//                                   child: ListView.builder(
//                                     itemCount: filteredCollections.length,
//                                     itemBuilder: (context, index) {
//                                       final collection =
//                                           filteredCollections[index];
//                                       // List<String> types =
//                                       //     List<String>.from(collection['types']);

//                                       return Container(
//                                         margin: EdgeInsets.only(bottom: 12),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.black.withOpacity(0.1),
//                                               blurRadius: 12,
//                                               offset: Offset(0, 6),
//                                             ),
//                                           ],
//                                         ),
//                                         child: ListTile(
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 12, vertical: 10),
//                                           leading: Container(
//                                             width: 60,
//                                             height: 80,
//                                             decoration: BoxDecoration(
//                                               color: Colors.amber.shade50,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: Icon(
//                                               FontAwesomeIcons.truck,
//                                               color: Colors.amber[500],
//                                               size: 25,
//                                             ),
//                                           ),
//                                           title: Text(
//                                             // collection['date'],
//                                             collection.date,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           subtitle: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 // 'Time - ${collection['time']}',
//                                                 'Time - ${collection.time}',
//                                                 style: TextStyle(
//                                                   color: Colors.grey.shade600,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 // 'Location - ${collection['location']}',
//                                                 'Location - ${collection.location}',
//                                                 style: TextStyle(
//                                                   color: Colors.grey.shade600,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               // Display multiple types with colored chips
//                                               Wrap(
//                                                 spacing: 4,
//                                                 runSpacing: 4,
//                                                 children: collection.types
//                                                     .map((type) {
//                                                   Color chipColor = CalendarPopup
//                                                               .categoryColors[
//                                                           type] ??
//                                                       Colors.grey;
//                                                   return Container(
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             horizontal: 12,
//                                                             vertical: 5),
//                                                     decoration: BoxDecoration(
//                                                       color: chipColor
//                                                           .withOpacity(0.15),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       // border: Border.all(color: chipColor, width: 1),
//                                                     ),
//                                                     child: Text(
//                                                       type,
//                                                       style: TextStyle(
//                                                         color: chipColor
//                                                             .withOpacity(0.8),
//                                                         fontSize: 12,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                               ),
//                                             ],
//                                           ),
//                                           trailing: GestureDetector(
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         // CollectionDetailScreen(
//                                                         //   date:
//                                                         //       collection['date'],
//                                                         //   time:
//                                                         //       collection['time'],
//                                                         //   location: collection[
//                                                         //       'location'],
//                                                         //   categories:
//                                                         //       List<String>.from(
//                                                         //               collection[
//                                                         //                   'types'])
//                                                         //           .join(', '),
//                                                         // )),
//                                                         CollectionDetailScreen(
//                                                           date: collection.date,
//                                                           time: collection.time,
//                                                           location: collection
//                                                               .location,
//                                                           categories: collection
//                                                               .types
//                                                               .join(', '),
//                                                         )),
//                                               );
//                                             },
//                                             child: Icon(
//                                               Icons.chevron_right,
//                                               color: Colors.grey.shade400,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),

//                               // Bottom buttons
//                               Padding(
//                                 padding: EdgeInsets.all(20.0),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       width: double.infinity,
//                                       height: 50,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           CalendarPopup.showCalendarDialog(
//                                               context, allCollections);
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               Color.fromARGB(255, 108, 65, 182),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           'View calendar',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 12),
//                                     Container(
//                                       width: double.infinity,
//                                       height: 50,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           // Map<String, dynamic>? nextCollection =
//                                           //     getNextCollectionDay();
//                                           Schedule? nextCollection =
//                                               getNextCollectionDay();
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     NextCollectionDayScreen(
//                                                       date:
//                                                           nextCollection!.date,
//                                                       time: nextCollection.time,
//                                                       location: nextCollection
//                                                           .location,
//                                                       categories: nextCollection
//                                                           .types
//                                                           .join(', '),
//                                                     )),
//                                           );
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               Color.fromARGB(255, 108, 65, 182),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           'Next collection day',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CalendarPopup {
//   // Define colors for each category
//   static final Map<String, Color> categoryColors = {
//     'Plastic': const Color.fromARGB(255, 192, 145, 4),
//     'Organic Waste': const Color.fromARGB(255, 42, 152, 2),
//     'Polythene': const Color.fromARGB(255, 240, 21, 21),
//     'Glass': const Color.fromARGB(255, 9, 85, 237),
//   };

//   // Parse date string to DateTime
//   static DateTime? _parseDate(String dateStr) {
//     try {
//       // Parse "Wed 18 June" format
//       List<String> parts = dateStr.split(' ');
//       if (parts.length >= 3) {
//         int day = int.parse(parts[1]);
//         String month = parts[2];
//         int year = DateTime.now().year; // Assume current year

//         Map<String, int> monthMap = {
//           'January': 1,
//           'February': 2,
//           'March': 3,
//           'April': 4,
//           'May': 5,
//           'June': 6,
//           'July': 7,
//           'August': 8,
//           'September': 9,
//           'October': 10,
//           'November': 11,
//           'December': 12
//         };

//         int? monthNum = monthMap[month];
//         if (monthNum != null) {
//           return DateTime(year, monthNum, day);
//         }
//       }
//     } catch (e) {
//       print('Error parsing date: $dateStr');
//     }
//     return null;
//   }

//   // Updated to handle multiple types per collection
//   static Map<DateTime, List<String>> _generateCollectionEvents(
//       List<Schedule> collections) {
//     Map<DateTime, List<String>> events = {};

//     for (var collection in collections) {
//       DateTime? date = _parseDate(collection.date);
//       if (date != null) {
//         List<String> types = List<String>.from(collection.types);
//         if (events[date] == null) {
//           events[date] = [];
//         }
//         // Add all types for this collection date
//         for (String type in types) {
//           if (!events[date]!.contains(type)) {
//             events[date]!.add(type);
//           }
//         }
//       }
//     }

//     return events;
//   }

//   static void showCalendarDialog(
//       BuildContext context, List<Schedule> collections) {
//     DateTime _focusedDay = DateTime.now();
//     DateTime? _selectedDay;

//     Map<DateTime, List<String>> collectionEvents =
//         _generateCollectionEvents(collections);

//     final kToday = DateTime.now();
//     final kFirstDay = DateTime(kToday.year, kToday.month - 24, kToday.day);
//     final kLastDay = DateTime(kToday.year, kToday.month + 24, kToday.day);
//     CalendarFormat _calendarFormat = CalendarFormat.month;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.95,
//                 height: MediaQuery.of(context).size.height * 0.75,
//                 padding: EdgeInsets.all(14),
//                 child: Column(
//                   children: [
//                     // Header
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Collection Schedule',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.close),
//                           onPressed: () => Navigator.of(context).pop(),
//                         ),
//                       ],
//                     ),

//                     // Calendar
//                     TableCalendar<String>(
//                       firstDay: kFirstDay,
//                       lastDay: kLastDay,
//                       focusedDay: _focusedDay,
//                       selectedDayPredicate: (day) {
//                         return isSameDay(_selectedDay, day);
//                       },
//                       eventLoader: (day) {
//                         return collectionEvents[
//                                 DateTime(day.year, day.month, day.day)] ??
//                             [];
//                       },
//                       startingDayOfWeek: StartingDayOfWeek.monday,
//                       calendarFormat: _calendarFormat,
//                       onFormatChanged: (format) {
//                         if (_calendarFormat != format) {
//                           setState(() {
//                             _calendarFormat = format;
//                           });
//                         }
//                       },
//                       calendarStyle: CalendarStyle(
//                         outsideDaysVisible: true,
//                         weekendTextStyle: TextStyle(color: Colors.black),
//                         selectedDecoration: BoxDecoration(
//                           color: Colors.green,
//                           shape: BoxShape.circle,
//                         ),
//                         todayDecoration: BoxDecoration(
//                           color: Colors.transparent,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.green, width: 2),
//                         ),
//                         todayTextStyle: TextStyle(color: Colors.black),
//                         markersMaxCount: 4, // Increased to show more markers
//                       ),
//                       headerStyle: HeaderStyle(
//                         formatButtonVisible: false,
//                         titleCentered: true,
//                       ),
//                       calendarBuilders: CalendarBuilders(
//                         markerBuilder: (context, day, events) {
//                           if (events.isNotEmpty) {
//                             return Positioned(
//                               bottom: 4,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: events.take(4).map((event) {
//                                   return Container(
//                                     margin: EdgeInsets.symmetric(horizontal: 1),
//                                     width: 6,
//                                     height: 6,
//                                     decoration: BoxDecoration(
//                                       color:
//                                           categoryColors[event] ?? Colors.grey,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             );
//                           }
//                           return null;
//                         },
//                       ),
//                       onDaySelected: (selectedDay, focusedDay) {
//                         if (!isSameDay(_selectedDay, selectedDay)) {
//                           // Call `setState()` when updating the selected day
//                           setState(() {
//                             _selectedDay = selectedDay;
//                             _focusedDay = focusedDay;
//                           });
//                         }
//                         setState(() {
//                           selectedDay = selectedDay;
//                           focusedDay = focusedDay;
//                         });
//                       },
//                       onPageChanged: (focusedDay) {
//                         focusedDay = focusedDay;
//                       },
//                     ),

//                     // ignore: unnecessary_null_comparison
//                     if (_selectedDay != null &&
//                         collectionEvents[DateTime(_selectedDay!.year,
//                                 _selectedDay!.month, _selectedDay!.day)] !=
//                             null)
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Collections on ${_selectedDay!.day}/${_selectedDay!.month}:',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Wrap(
//                               spacing: 6,
//                               runSpacing: 6,
//                               children: collectionEvents[DateTime(
//                                       _selectedDay!.year,
//                                       _selectedDay!.month,
//                                       _selectedDay!.day)]!
//                                   .map((type) {
//                                 Color chipColor =
//                                     categoryColors[type] ?? Colors.grey;
//                                 return Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: chipColor.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                     border:
//                                         Border.all(color: chipColor, width: 1),
//                                   ),
//                                   child: Text(
//                                     type,
//                                     style: TextStyle(
//                                       color: chipColor,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                       ),

//                     SizedBox(height: 20),

//                     // Color Legend
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Garbage Types:',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 15),
//                           Wrap(
//                             spacing: 8,
//                             runSpacing: 6,
//                             children: categoryColors.entries.map((entry) {
//                               return Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                     width: 12,
//                                     height: 12,
//                                     decoration: BoxDecoration(
//                                       color: entry.value,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   SizedBox(width: 6),
//                                   Text(
//                                     entry.key,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
