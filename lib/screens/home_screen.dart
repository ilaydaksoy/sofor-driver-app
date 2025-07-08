import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../providers/trip_provider.dart';
import '../widgets/custom_button.dart';
import 'trips_screen.dart';
import 'profile_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isOnline = false;

  final List<Widget> _screens = [
    const TripsScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);
    await tripProvider.loadTrips();
  }

  void _toggleOnlineStatus() {
    setState(() {
      _isOnline = !_isOnline;
    });
    // TODO: API'ye online durumu gönder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(AppConstants.primaryColorValue),
        unselectedItemColor: const Color(AppConstants.textColorValue).withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Seferler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Harita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: _toggleOnlineStatus,
              backgroundColor: _isOnline
                  ? const Color(AppConstants.successColorValue)
                  : const Color(AppConstants.primaryColorValue),
              icon: Icon(
                _isOnline ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              label: Text(
                _isOnline ? 'Çevrimiçi' : 'Çevrimdışı',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
} 