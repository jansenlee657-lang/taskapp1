import 'package:flutter/material.dart';
import 'models/item_model.dart';
import 'screens/auth_screen.dart';
import 'screens/browse_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_reports_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/report_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/header_app_bar.dart';

void main() {
  runApp(const CatsuLostAndFoundApp());
}

class CatsuLostAndFoundApp extends StatelessWidget {
  const CatsuLostAndFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CATSU Lost & Found',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  bool _isAuthenticated = true;
  int _currentIndex = 0;
  ItemType _reportType = ItemType.lost;

  final List<String> _pageTitles = [
    'CATSU Lost & Found',
    'Browse Directory',
    'Report Incident',
    'My Reports & Registry',
    'Profile & Credits',
  ];

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return AuthScreen(
        onLoginSuccess: () {
          setState(() {
            _isAuthenticated = true;
            _currentIndex = 0;
          });
        },
      );
    }

    final pages = [
      HomeScreen(
        onNavigateTab: (index) => setState(() => _currentIndex = index),
        onStartReport: (type) {
          setState(() {
            _reportType = type;
            _currentIndex = 2; // Report tab
          });
        },
      ),
      const BrowseScreen(),
      ReportScreen(
        key: ValueKey(_reportType),
        initialType: _reportType,
        onReportCompleted: () {
          setState(() => _currentIndex = 3); // Go to My Reports
        },
      ),
      MyReportsScreen(
        onNewIncident: () {
          setState(() {
            _reportType = ItemType.lost;
            _currentIndex = 2; // Report tab
          });
        },
      ),
      ProfileScreen(
        onSignOut: () {
          setState(() => _isAuthenticated = false);
        },
      ),
    ];

    return Scaffold(
      appBar: CatsuHeaderAppBar(
        title: _pageTitles[_currentIndex],
        onNotificationTap: () {
          _showNotificationsDialog(context);
        },
        onProfileTap: () {
          setState(() => _currentIndex = 4); // Go to Profile
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: CatsuBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 2) {
              _reportType = ItemType.lost;
            }
          });
        },
      ),
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.notifications_active,
                  color: AppColors.primaryContainer,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Campus Notifications',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 6),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  size: 16,
                  color: AppColors.primaryContainer,
                ),
              ),
              title: const Text(
                'Potential Match Found',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              subtitle: const Text(
                'A Casio Calculator matching Case #CATSU-LF-2024-0419 was logged at Security Post 2.',
                style: TextStyle(fontSize: 11),
              ),
              trailing: const Text('2h ago', style: TextStyle(fontSize: 10, color: AppColors.outline)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Dismiss Notifications'),
            ),
          ],
        ),
      ),
    );
  }
}
