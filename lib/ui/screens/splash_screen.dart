import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm_getx/ui/screens/sign_in_screen.dart';

import '../controllers/auth_controller.dart';
import '../utils/assets_path.dart';
import '../widgets/screen_background.dart';
import 'main_bottom_nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
   static String name ='/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    if (AuthController.isLoggedIn()) {
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavBarScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsPath.logoSvg,
                width: 120,
              )
            ],
          ),
        ),
      ),
    );
  }
}
