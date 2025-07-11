import 'package:flutter/material.dart';
import 'package:greenxu/presentation/routers/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Greenxu',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
