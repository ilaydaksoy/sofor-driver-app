import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedTab = 'Tümü';
  
  final List<String> tabs = ['Tümü', 'Seyahat', 'Sistem', 'Duyuru'];
  
  final List<Map<String, dynamic>> notifications = [
    {
      'id': '1',
      'type': 'Seyahat',
      'title': 'Yeni Seyahat Talebi',
      'message': 'Ahmet Yılmaz tarafından İstanbul Havalimanı\'na seyahat talebi.',
      'time': '2 dakika önce',
      'isRead': false,
      'icon': Icons.directions_car,
      'color': Colors.blue,
      'priority': 'high',
    },
    {
      'id': '2',
      'type': 'Sistem',
      'title': 'Profil Onaylandı',
      'message': 'Belgeleriniz incelendi ve profiliniz onaylandı.',
      'time': '1 saat önce',
      'isRead': false,
      'icon': Icons.verified_user,
      'color': Colors.green,
      'priority': 'medium',
    },
    {
      'id': '3',
      'type': 'Seyahat',
      'title': 'Seyahat Tamamlandı',
      'message': 'Fatma Özkan ile yaptığınız seyahat tamamlandı. 150 TL kazandınız.',
      'time': '3 saat önce',
      'isRead': true,
      'icon': Icons.check_circle,
      'color': Color(AppConstants.primaryColorValue),
      'priority': 'low',
    },
    {
      'id': '4',
      'type': 'Duyuru',
      'title': 'Yeni Özellik',
      'message': 'Artık günlük kazanç raporlarınızı görüntüleyebilirsiniz.',
      'time': '1 gün önce',
      'isRead': true,
      'icon': Icons.new_releases,
      'color': Colors.orange,
      'priority': 'low',
    },
    {
      'id': '5',
      'type': 'Sistem',
      'title': 'Ödeme Alındı',
      'message': 'Bu haftaki kazancınız hesabınıza yatırıldı: 2.450 TL',
      'time': '2 gün önce',
      'isRead': true,
      'icon': Icons.account_balance_wallet,
      'color': Colors.green,
      'priority': 'medium',
    },
    {
      'id': '6',
      'type': 'Seyahat',
      'title': 'İptal Edildi',
      'message': 'Mehmet Kaya seyahati iptal etti.',
      'time': '3 gün önce',
      'isRead': true,
      'icon': Icons.cancel,
      'color': Colors.red,
      'priority': 'low',
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedTab == 'Tümü') {
      return notifications;
    }
    return notifications.where((notification) => 
      notification['type'] == selectedTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Bildirimler'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.done_all),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab seçici
          _buildTabSelector(),
          
          // Bildirim listesi
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = tab),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Color(AppConstants.textPrimaryColorValue),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationsList() {
    final filtered = filteredNotifications;
    
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Henüz bildirim bulunmuyor',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final notification = filtered[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification['isRead'] ? Colors.white : Color(AppConstants.primaryColorValue).withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification['isRead'] 
            ? Colors.grey[200]! 
            : Color(AppConstants.primaryColorValue).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: notification['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            notification['icon'],
            color: notification['color'],
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification['title'],
                style: TextStyle(
                  fontWeight: notification['isRead'] ? FontWeight.w600 : FontWeight.bold,
                  fontSize: 14,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
            ),
            if (!notification['isRead'])
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(AppConstants.primaryColorValue),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              notification['message'],
              style: TextStyle(
                fontSize: 13,
                color: Color(AppConstants.textSecondaryColorValue),
                height: 1.3,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: notification['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    notification['type'],
                    style: TextStyle(
                      fontSize: 10,
                      color: notification['color'],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  notification['time'],
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(AppConstants.textTertiaryColorValue),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _markAsRead(notification['id']),
      ),
    );
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index = notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tüm bildirimler okundu olarak işaretlendi'),
        backgroundColor: Color(AppConstants.primaryColorValue),
      ),
    );
  }
}
