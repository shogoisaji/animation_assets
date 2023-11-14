import 'package:animation_assets/config/config.dart';
import 'package:animation_assets/pages/bounce_page_.dart';
import 'package:animation_assets/pages/collision_page.dart';
import 'package:animation_assets/pages/drag_page.dart';
import 'package:animation_assets/pages/pop_page.dart';
import 'package:animation_assets/pages/reflect_page.dart';
import 'package:animation_assets/state/state.dart';
import 'package:animation_assets/theme/color_theme.dart';
import 'package:animation_assets/widgets/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'M_PLUS_Rounded_1c',
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends ConsumerWidget {
  MainPage({super.key});
  final pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String title = ref.watch(getTitleProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: APP_BAR_HEIGHT,
        backgroundColor: MyTheme.brown,
        title: Center(
            child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        )),
      ),
      bottomNavigationBar: SizedBox(
        height: BOTTOM_NAVIGATION_BAR_HEIGHT,
        child: BottomNavigationBar(
          currentIndex: ref.watch(bottomNavigationBarIndexProvider),
          onTap: (int index) {
            ref.read(bottomNavigationBarIndexProvider.notifier).setIndex(index);
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          items: <BottomNavigationBarItem>[
            customBottomNavigationItem(const Icon(Icons.category)),
            customBottomNavigationItem(const Icon(Icons.wifi_channel)),
            customBottomNavigationItem(const Icon(Icons.network_ping)),
            customBottomNavigationItem(const Icon(Icons.blur_on_sharp)),
            customBottomNavigationItem(const Icon(Icons.vertical_align_center)),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: MyTheme.brown,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedIconTheme: const IconThemeData(size: 36, color: Colors.red),
          unselectedIconTheme:
              const IconThemeData(size: 36, color: Colors.white70),
        ),
      ),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            DragPage(),
            BouncePage(),
            ReflectPage(),
            PopPage(),
            CollisionPage(),
          ]),
    );
  }
}
