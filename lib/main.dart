import 'package:flutter/material.dart';
import 'package:psychology_app/core/app_colors.dart';
import 'package:psychology_app/core/utils/service_locator.dart';
import 'package:psychology_app/features/test/presentation/desktop_layout.dart';
import 'package:psychology_app/features/test/presentation/home_page.dart';
import 'package:psychology_app/features/test/presentation/mobile_layout.dart';


void main() {
  setupLocator(); // Registrierung der Abhängigkeiten
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Psychology App',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(
          primary: AppColors.lightPrimary,
          secondary: AppColors.lightSecondary,
          surface: AppColors.lightSurface,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          secondary: AppColors.darkSecondary,
          surface: AppColors.darkSurface,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Psychology App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  // Liste der verfügbaren Seiten
  final List<Widget> pages = [
    const HomePage(),
    const Center(child: Text('Suche')), 
    const Center(child: Text('Favoriten')),
    const Center(child: Text('Einstellungen')),
  ];

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    // Vereinfachte Page-Auswahl
    Widget page = pages[selectedIndex];

    var mainArea = ColoredBox(
      color: colorScheme.surface,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsives Layout
          if (constraints.maxWidth < 450) {
            return MobileLayout(
              selectedIndex: selectedIndex,
              mainArea: mainArea,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            );
          } else {
            return DesktopLayout(
              selectedIndex: selectedIndex,
              mainArea: mainArea,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              extended: constraints.maxWidth >= 1000,
            );
          }
        }
      ),
    );
  }
}

String timeOfDay(String name) {
  final now = DateTime.now();
  String greeting;

  if (now.hour >= 9 && now.hour < 18) {
    greeting = 'Guten Tag';
  } else if (now.hour >= 6 && now.hour < 9) {
    greeting = 'Guten Morgen';
  } else {
    greeting = 'Guten Abend';
  }

  return '$greeting, $name!';
}
