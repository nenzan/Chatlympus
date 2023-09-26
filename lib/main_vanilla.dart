import 'package:flutter/material.dart';
import 'package:chatlympus/common/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chatlympus/pages/splash/page/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ayuqypfpofveqniysgqa.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5dXF5cGZwb2Z2ZXFuaXlzZ3FhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA1NjU3MTksImV4cCI6MjAwNjE0MTcxOX0.l_O8svWoia4rdtY15Or9efBNWMma73ChtoS4LQxUSaA',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatlympus',
      theme: appTheme,
      home: const SplashPage(),
    );
  }
}
