import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/provider/call_log_provider.dart';
import 'package:sales_app/provider/login_provider.dart';
import 'package:sales_app/provider/user_provider.dart';
import 'package:sales_app/services/shared_preferences_service.dart';
import 'package:sales_app/splash_screen/splashpage/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.openBox('callLogs');
  await SharedPreferencesService().initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<CallLogProvider>(
              create: (_) => CallLogProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: SplashScreen(),
        ));
  }
}
