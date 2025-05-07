import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'package:sahla/services/providers.dart';
import 'package:splash_view/splash_view.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

// SplashScreen is a StatefulWidget that displays a splash screen with a logo animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// _SplashScreenState is the State class for SplashScreen
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // _hasInternet is a boolean that indicates whether the device has internet connection
  bool _hasInternet = false;

  // _controller is an AnimationController that controls the animation of the logo
  late AnimationController _controller;

  // _animation is a CurvedAnimation that defines the animation curve for the logo
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and CurvedAnimation
    _controller = AnimationController(
      duration:
          const Duration(milliseconds: 1200), // animation duration is 1200ms
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate, // animation curve is ease-in-out
    );

    // Start the animation forward
    _controller.forward();

    // After 1000ms, check the internet connection
    Future.delayed(const Duration(milliseconds: 1000), () async {
      // Check the internet connection using the Connectivity package
      var connectivityResult = await (Connectivity().checkConnectivity());

      // If the device has internet connection, set _hasInternet to true
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('Connected to internet');
        setState(() {
          _hasInternet = true;
        });
      } else {
        // If the device does not have internet connection, show a snackbar with an error message
        print('No internet connection');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AwesomeSnackbarContent(
              title: 'No Internet Connection',
              message: 'Please check your internet connection and try again.',
              contentType: ContentType.failure,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // Dispose the AnimationController when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Return a SplashView widget with a logo animation
    return SplashView(
      backgroundImageDecoration: const BackgroundImageDecoration(
          image: AssetImage("assets/backsplash.jpeg")),
      logo: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Scale the logo animation using the _animation value
            return Transform.scale(
              scale: _animation.value * 0.5,
              child: child,
            );
          },
          child: Container()),
      done: Done(
        // If _hasInternet is true, show the HomeScreen or WelcomeScreen based on the user's login status
        _hasInternet ? _getHomeScreen(context) : const SizedBox(),
      ),
    );
  }

  // _getHomeScreen returns the HomeScreen or WelcomeScreen based on the user's login status
  Widget _getHomeScreen(context) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.email != null ? const HomeScreen() : WelcomeScreen();
  }
}
