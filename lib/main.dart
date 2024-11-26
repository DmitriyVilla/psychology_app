import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //String title = timeOfDay('Benutzer');
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

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Center(
          child: Container( 
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(25),
                  ),

                  padding: const EdgeInsets.all(20),

                  width: 300,
                  height: 300,
                  child: Text(
                    'Home Page',
                    textAlign: TextAlign.center,
                    
                    style: TextStyle(
                      fontSize: 32,
                      color: colorScheme.surface
                                            
                    ),),



                  ),
                );
        break;
      case 1:
        page = const Center(child: Text('Search Page'));
        break;
      case 2:
        page = const Center(child: Text('Favorites Page'));
        break;
      case 3:
        page = const Center(child: Text('Settings Page'));
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surface,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 420) {
            return Column(
              children: [
                AppBar(
                  title: Text((timeOfDay('Benuzer'))),
                  backgroundColor: colorScheme.primary,
                  leading: const Icon(Icons.menu),
                ),
               
                

                
              
                Expanded(child: mainArea),
                SafeArea(
                  child: Center(
                    child: NavigationBarTheme(
                      data: const NavigationBarThemeData(
                        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                      ),
                      child: NavigationBar(
                          //shadowColor: colorScheme.primaryContainer,,
                          selectedIndex: selectedIndex,
                          onDestinationSelected: (int value) {
                            setState(() {
                              selectedIndex = value;
                            });
                          },
                        destinations: const [
                          NavigationDestination(
                              icon: Icon(Icons.home_outlined),
                              selectedIcon: Icon(Icons.home),
                              label: 'Home',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.search_outlined),
                              selectedIcon: Icon(Icons.search),
                              label: 'Search',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.favorite_border),
                              selectedIcon: Icon(Icons.favorite),
                              label: 'Favorites',
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.settings_outlined),
                              selectedIcon: Icon(Icons.settings),
                              label: 'Settings',
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ],
            );
          } else {
            // Layout für größere Bildschirme

            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.search_outlined),
                        selectedIcon: Icon(Icons.search),
                        label: Text('Search'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite_border),
                        selectedIcon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],

                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}


class AppColors {
  // Light Theme Colors
  static const lightPrimary = Color(0xFF87CEEB); // Мягкий голубой для акцентов
  static const lightSecondary = Color.fromARGB(255, 255,255,255); // для второстепенных акцентов
  static const lightBackground = Color.fromARGB(255, 33, 37, 41); // для фона
  static const lightSurface = Color(0xFFFFFFFF); // Белый для карточек и поверхностей

  // Dark Theme Colors
  static const darkPrimary = Color(0xFF4682B4); // Глубокий голубой для акцентов
  static const darkSecondary = Color(0xFF20B2AA); // Глубокий бирюзовый для второстепенных акцентов
  static const darkBackground = Color(0xFF121212); // Тёмно-серый фон для ночной темы
  static const darkSurface = Color(0xFF1E1E1E); // Угольный чёрный для поверхностей

  // Общие цвета для обеих тем
  static const error = Color(0xFFFF6B6B); // Красный для ошибок
  static const textPrimaryLight = Color(0xFF333333); // Тёмно-серый текст для светлой темы
  static const textSecondaryLight = Color(0xFF888888); // Светло-серый текст для светлой темы
  static const textPrimaryDark = Color(0xFFFFFFFF); // Белый текст для тёмной темы
  static const textSecondaryDark = Color(0xFFB0B0B0); // Светло-серый текст для тёмной темы
}


// Динамический текст приветствия
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
