import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../models/trip.dart';
import '../providers/trip_provider.dart';
import '../widgets/trip_card.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadTrips();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTrips() async {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);
    await tripProvider.loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: const Text(
          'Seferlerim',
          style: TextStyle(
            color: Color(AppConstants.textColorValue),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(AppConstants.primaryColorValue),
          unselectedLabelColor: const Color(AppConstants.textColorValue).withOpacity(0.6),
          indicatorColor: const Color(AppConstants.primaryColorValue),
          tabs: const [
            Tab(text: 'Bekleyen'),
            Tab(text: 'Aktif'),
            Tab(text: 'Tamamlanan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTripsList('pending'),
          _buildTripsList('active'),
          _buildTripsList('completed'),
        ],
      ),
    );
  }

  Widget _buildTripsList(String status) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        if (tripProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(AppConstants.primaryColorValue),
            ),
          );
        }

        List<Trip> trips;
        switch (status) {
          case 'pending':
            trips = tripProvider.pendingTrips;
            break;
          case 'active':
            trips = tripProvider.activeTrips;
            break;
          case 'completed':
            trips = tripProvider.completedTrips;
            break;
          default:
            trips = [];
        }

        if (trips.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car_outlined,
                  size: 64,
                  color: const Color(AppConstants.textColorValue).withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  _getEmptyMessage(status),
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(AppConstants.textColorValue).withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _loadTrips,
          color: const Color(AppConstants.primaryColorValue),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TripCard(trip: trip),
              );
            },
          ),
        );
      },
    );
  }

  String _getEmptyMessage(String status) {
    switch (status) {
      case 'pending':
        return 'Bekleyen seferiniz bulunmuyor';
      case 'active':
        return 'Aktif seferiniz bulunmuyor';
      case 'completed':
        return 'Tamamlanan seferiniz bulunmuyor';
      default:
        return 'Sefer bulunamadı';
    }
  }
} 