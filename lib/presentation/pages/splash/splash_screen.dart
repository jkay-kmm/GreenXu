import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greenxu/config/theme/app_colors.dart';
import 'package:greenxu/config/theme/app_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOption();
  }

  void _navigateToOption() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        context.go('/option');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            SizedBox(height: 266),
            SvgPicture.asset(
              "assets/images/svg/Logo.svg",
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Text("GreenXu", style: AppFont.semibold_black_30),
            const SizedBox(height: 208),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Hợp nhất quyết tâm và bước vào việc hiện thực hóa trái đất mà không có rác",
                style: AppFont.semibold_green_12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
