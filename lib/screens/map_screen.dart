import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Harita',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(AppConstants.primaryColorValue),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 80,
              color: const Color(0xFF111111).withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Harita Özelliği',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111111).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bu özellik yakında eklenecek',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF111111).withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 