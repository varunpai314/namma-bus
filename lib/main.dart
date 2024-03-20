import 'package:flutter/material.dart';
import 'package:namma_bus/screens/screens.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String url = "https://ekfouxfsolardpgzdkzz.supabase.co";
const String anonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVrZm91eGZzb2xhcmRwZ3pka3p6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk0NTkzMTcsImV4cCI6MjAyNTAzNTMxN30.bcm-C8nw23uiPP4fsLw63eZBZqIih8d2hs023WMfx8s";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namma Bus',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 180, 95)),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late BuildContext _initialContext;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild widget on animation updates
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Animation completed
          navigateToNextScreen();
        }
      });
    _controller.forward();
  }

  Future<void> navigateToNextScreen() async {
    // Wait for Supabase initialization
    await initializeSupabase();
    // Delay for 1 second
    await Future.delayed(const Duration(seconds: 1));
    // Check if the widget is still mounted before accessing its context
    if (mounted) {
      Navigator.of(_initialContext).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Screens(),
        ),
      );
    }
  }

  Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initialContext = context;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/namma_bus_logo.png',
            width: 200,
            height: 200,
          ), // Replace 'your_logo.png' with your actual logo asset path
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
    );
  }
}
