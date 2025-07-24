import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    // ChangeNotifierProvider manages our app's state.
    // Any widget in the tree can access AppProvider to get data or call methods.
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const DreamSpaceApp(),
    ),
  );
}

class DreamSpaceApp extends StatelessWidget {
  const DreamSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DreamSpace AI',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.blueGrey,
          surface: Color(0xFF1E1E1E),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.black,
          error: Colors.redAccent,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}