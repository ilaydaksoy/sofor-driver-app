import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_constants.dart';
import '../models/trip.dart';
import '../widgets/custom_button.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({
    super.key,
    required this.trip,
  });

  Color _getStatusColor() {
    switch (trip.status) {
      case 'pending':
        return const Color(0xFFFF9800);
      case 'active':
        return const Color(AppConstants.successColorValue);
      case 'completed':
        return const Color(AppConstants.primaryColorValue);
      case 'cancelled':
        return const Color(AppConstants.errorColorValue);
      default:
        return const Color(AppConstants.textColorValue);
    }
  }

  String _getStatusText() {
    switch (trip.status) {
      case 'pending':
        return AppConstants.tripStatusPending;
      case 'active':
        return AppConstants.tripStatusActive;
      case 'completed':
        return AppConstants.tripStatusCompleted;
      case 'cancelled':
        return AppConstants.tripStatusCancelled;
      default:
        return trip.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık ve Durum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Sefer #${trip.id.substring(0, 8)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.textColorValue),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getStatusColor()),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Yolcu Bilgileri
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(AppConstants.primaryColorValue),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.passengerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(AppConstants.textColorValue),
                        ),
                      ),
                      Text(
                        trip.passengerPhone,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(AppConstants.textColorValue).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Konum Bilgileri
            _buildLocationInfo(
              Icons.location_on,
              'Alış Noktası',
              trip.pickupLocation,
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildLocationInfo(
              Icons.location_on_outlined,
              'Bırakış Noktası',
              trip.dropoffLocation,
              Colors.red,
            ),
            const SizedBox(height: 16),
            
            // Sefer Detayları
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.access_time,
                    'Tarih',
                    DateFormat('dd.MM.yyyy').format(trip.scheduledTime),
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.schedule,
                    'Saat',
                    DateFormat('HH:mm').format(trip.scheduledTime),
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.straighten,
                    'Mesafe',
                    '${trip.distance.toStringAsFixed(1)} km',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.attach_money,
                    'Ücret',
                    '₺${trip.fare.toStringAsFixed(2)}',
                  ),
                ),
                if (trip.rating != null)
                  Expanded(
                    child: _buildDetailItem(
                      Icons.star,
                      'Puan',
                      trip.rating!.toStringAsFixed(1),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Aksiyon Butonları
            if (trip.status == 'pending')
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Kabul Et',
                      onPressed: () {
                        // TODO: Sefer kabul etme işlemi
                      },
                      backgroundColor: const Color(AppConstants.successColorValue),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Reddet',
                      onPressed: () {
                        // TODO: Sefer reddetme işlemi
                      },
                      backgroundColor: const Color(AppConstants.errorColorValue),
                    ),
                  ),
                ],
              ),
            
            if (trip.status == 'active')
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Seferi Başlat',
                      onPressed: () {
                        // TODO: Sefer başlatma işlemi
                      },
                      backgroundColor: const Color(AppConstants.primaryColorValue),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Tamamla',
                      onPressed: () {
                        // TODO: Sefer tamamlama işlemi
                      },
                      backgroundColor: const Color(AppConstants.successColorValue),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo(IconData icon, String title, String location, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(AppConstants.textColorValue).withOpacity(0.6),
                ),
              ),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(AppConstants.textColorValue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color(AppConstants.primaryColorValue), size: 20),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: const Color(AppConstants.textColorValue).withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.textColorValue),
          ),
        ),
      ],
    );
  }
} 