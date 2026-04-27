import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_service_server/views/splash_screen_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:money_service_server/constant/env_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(const MoneyTrackingApp());
}

class MoneyTrackingApp extends StatefulWidget {
  const MoneyTrackingApp({super.key});

  @override
  State<MoneyTrackingApp> createState() => _MoneyTrackingAppState();
}

class _MoneyTrackingAppState extends State<MoneyTrackingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenUI(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
