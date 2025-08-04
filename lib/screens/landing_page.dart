// import 'package:city_clean_app/home_page.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));

//     _animationController.forward();

//     // Navigate to home page after 3 seconds
//     Future.delayed(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF66BB6A),
//               Color(0xFF2E7D32),
//             ],
//           ),
//         ),
//         child: AnimatedBuilder(
//           animation: _animationController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: ScaleTransition(
//                 scale: _scaleAnimation,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Logo Container
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(60),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.eco,
//                         size: 60,
//                         color: Color(0xFF2E7D32),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     // App Title
//                     const Text(
//                       'City Clean',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Keep Your City Clean & Green',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white70,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                     const SizedBox(height: 50),
//                     // Loading indicator
//                     const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
