import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:videolist/router/router.dart';
import 'package:videolist/utils/sp_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: FlexScheme.blue,
        appBarElevation: 0.5,
        useMaterial3: true,
      )..copyWith(
          tabBarTheme: const TabBarTheme(tabAlignment: TabAlignment.start)),
      title: 'tvBox',
      routerConfig: goRouter,
    );
  }
}
