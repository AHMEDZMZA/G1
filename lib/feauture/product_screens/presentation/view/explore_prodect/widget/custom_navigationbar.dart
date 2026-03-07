import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

import '../../../../../dashboard_screen/presentation/view/seller_dashboard.dart';
import '../../../../../home/presentation/view/home_screen.dart';
import '../../../../comming_soon_screen.dart';
import '../explore_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

// class _MainWrapperState extends State<MainWrapper> {
//   int _selectedIndex = 0; // ابدأي من الصفر عشان يفتح الهوم أول ما يشتغل

//   // قائمة الصفحات
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const ExploreAllScreen(),
//     const ComingSoonScreen(title: 'Community'),
//     const ComingSoonScreen(title: 'AI'),
//     Profile(),

//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // عرض الصفحة بناءً على الاندكس المختار
//       body: IndexedStack(index: _selectedIndex, children: _pages),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
//           BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
//           BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );
void changeTab(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(5, (index) {
          return Navigator(
            key: _navigatorKeys[index],
            onGenerateRoute: (settings) {
              return MaterialPageRoute(builder: (_) => _getRootPage(index));
            },
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: _selectedIndex,
        onTap: (index) {
          if (_selectedIndex == index) {
            _navigatorKeys[index].currentState!.popUntil(
              (route) => route.isFirst,
            );
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        // selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getRootPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SellerDashboardScreen();
      case 2:
        return const ComingSoonScreen(title: 'Community');
      case 3:
        return const ComingSoonScreen(title: 'AI');
      case 4:
  return Profile(
    onGoHome: () => changeTab(0),
  );

      default:
        return const HomeScreen();
    }
  }
}
