import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/desktop_provider.dart';
import 'screens/desktop_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DesktopProvider()),
      ],
      child: MaterialApp(
        title: 'Windows 11 Emulator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'Segoe UI', // Fallback to default if not available
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const DesktopScreen(),
        },
      ),
    );
  }
}
