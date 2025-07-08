import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: const Text(
          'Harita',
          style: TextStyle(
            color: Color(AppConstants.textColorValue),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 80,
              color: const Color(AppConstants.textColorValue).withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Harita Özelliği',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(AppConstants.textColorValue).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bu özellik yakında eklenecek',
              style: TextStyle(
                fontSize: 16,
                color: const Color(AppConstants.textColorValue).withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 