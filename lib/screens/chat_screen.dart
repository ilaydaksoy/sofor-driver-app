import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentTabIndex = 0;
  
  final List<Map<String, dynamic>> chats = [
    {
      'id': '1',
      'customerName': 'Ahmet Yılmaz',
      'customerImage': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Havalimanından alacak mısınız?',
      'lastMessageTime': '14:30',
      'unreadCount': 2,
      'isOnline': true,
      'tripStatus': 'pending', // pending, active, completed
      'destination': 'İstanbul Havalimanı → Taksim',
      'requestTime': '15:00',
      'messages': [
        {'text': 'Havalimanından alacak mısınız?', 'isMe': false, 'time': '14:30'},
        {'text': 'Tabii, hangi terminal?', 'isMe': true, 'time': '14:25'},
        {'text': 'Dış hatlar terminali', 'isMe': false, 'time': '14:20'},
      ]
    },
    {
      'id': '2',
      'customerName': 'Fatma Özkan',
      'customerImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Çok teşekkür ederim, güvenli bir yolculuktu!',
      'lastMessageTime': '12:15',
      'unreadCount': 0,
      'isOnline': false,
      'tripStatus': 'completed',
      'destination': 'Kadıköy → Bostancı',
      'requestTime': '11:00',
      'messages': [
        {'text': 'Çok teşekkür ederim, güvenli bir yolculuktu!', 'isMe': false, 'time': '12:15'},
        {'text': 'Rica ederim, iyi günler', 'isMe': true, 'time': '12:10'},
      ]
    },
    {
      'id': '3',
      'customerName': 'Mehmet Kaya',
      'customerImage': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Platform Bildirimi: Yeni seyahat talebi',
      'lastMessageTime': '09:45',
      'unreadCount': 1,
      'isOnline': true,
      'tripStatus': 'pending',
      'destination': 'Şişli → Levent',
      'requestTime': '10:30',
      'isPlatformMessage': true,
      'messages': [
        {'text': 'Platform Bildirimi: Yeni seyahat talebi alındı', 'isMe': false, 'time': '09:45', 'isPlatformMessage': true},
        {'text': 'Kabul ediyorum', 'isMe': true, 'time': '09:46'},
      ]
    },
    {
      'id': '4',
      'customerName': 'Ali Demir',
      'customerImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Sesli mesaj gönderdi',
      'lastMessageTime': 'Dün',
      'unreadCount': 0,
      'isOnline': false,
      'tripStatus': 'active',
      'destination': 'Beşiktaş → Ortaköy',
      'requestTime': 'Dün',
      'messages': [
        {'text': 'Sesli mesaj', 'isMe': false, 'time': 'Dün', 'isVoice': true, 'duration': '0:23'},
        {'text': 'Anladım, geliyorum', 'isMe': true, 'time': 'Dün'},
      ]
    },
  ];

  final List<Map<String, dynamic>> contacts = [
    {
      'id': '1',
      'name': 'Ahmet Yılmaz',
      'image': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'rating': 9.2,
      'car': 'Mercedes C200',
      'lastSeen': 'Çevrimiçi',
      'isVerified': true,
    },
    {
      'id': '2',
      'name': 'Mehmet Kaya',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      'isOnline': false,
      'rating': 9.8,
      'car': 'BMW 320i',
      'lastSeen': '2 saat önce',
      'isVerified': true,
    },
    {
      'id': '3',
      'name': 'Ali Demir',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'rating': 8.9,
      'car': 'Audi A4',
      'lastSeen': 'Çevrimiçi',
      'isVerified': false,
    },
    {
      'id': '4',
      'name': 'Fatma Özkan',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'isOnline': false,
      'rating': 9.5,
      'car': 'Volkswagen Passat',
      'lastSeen': '1 gün önce',
      'isVerified': true,
    },
    {
      'id': '5',
      'name': 'Can Yıldız',
      'image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'rating': 9.0,
      'car': 'Toyota Camry',
      'lastSeen': 'Çevrimiçi',
      'isVerified': true,
    },
    {
      'id': '6',
      'name': 'Zeynep Kaya',
      'image': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      'isOnline': false,
      'rating': 8.7,
      'car': 'Honda Civic',
      'lastSeen': '3 saat önce',
      'isVerified': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Müşteri Mesajları',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(AppConstants.primaryColorValue),
        elevation: 0,
        // TODO: Arama ve telefon ikonları daha sonra kullanılacak
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search, color: Colors.white),
        //     onPressed: () {
        //       // TODO: Sohbet arama özelliği
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Tab Bar - Sadece Sohbetler aktif, Kişiler yorum satırında
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Müşteri Mesajları',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // TODO: Kişiler tabı daha sonra kullanılacak
          // Container(
          //   margin: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[100],
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () => setState(() => _currentTabIndex = 0),
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: 12),
          //             decoration: BoxDecoration(
          //               color: _currentTabIndex == 0 
          //                   ? Color(AppConstants.primaryColorValue)
          //                   : Colors.transparent,
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Icon(
          //                   Icons.chat_bubble_outline,
          //                   color: _currentTabIndex == 0 
          //                       ? Colors.white
          //                       : Color(AppConstants.textSecondaryColorValue),
          //                   size: 20,
          //                 ),
          //                 const SizedBox(width: 8),
          //                 Text(
          //                   'Sohbetler',
          //                   style: TextStyle(
          //                     color: _currentTabIndex == 0 
          //                         ? Colors.white
          //                         : Color(AppConstants.textSecondaryColorValue),
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () => setState(() => _currentTabIndex = 1),
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: 12),
          //             decoration: BoxDecoration(
          //               color: _currentTabIndex == 1 
          //                   ? Color(AppConstants.primaryColorValue)
          //                   : Colors.transparent,
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Icon(
          //                   Icons.people_outline,
          //                   color: _currentTabIndex == 1 
          //                       ? Colors.white
          //                       : Color(AppConstants.textSecondaryColorValue),
          //                   size: 20,
          //                 ),
          //                 const SizedBox(width: 8),
          //                 Text(
          //                   'Kişiler',
          //                   style: TextStyle(
          //                     color: _currentTabIndex == 1 
          //                         ? Colors.white
          //                         : Color(AppConstants.textSecondaryColorValue),
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Content - Sadece Sohbetler
          Expanded(
            child: _buildChatsTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsTab() {
    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: const Color(0xFF111111).withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Henüz müşteri mesajınız yok',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111111).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Müşterilerden gelen mesajlar burada görünecek',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF111111).withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatItem(chat);
      },
    );
  }

  Widget _buildContactsTab() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return _buildContactItem(contact);
      },
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF111111).withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            ClipOval(
              child: Container(
                width: 56,
                height: 56,
                child: Image.network(
                  contact['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 28,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(AppConstants.primaryColorValue)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (contact['isOnline'])
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            if (contact['isVerified'])
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(AppConstants.primaryColorValue),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Text(
              contact['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(AppConstants.textPrimaryColorValue),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
            Text(
              contact['rating'].toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.amber,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              contact['car'],
              style: TextStyle(
                fontSize: 14,
                color: Color(AppConstants.textSecondaryColorValue),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  contact['isOnline'] ? Icons.circle : Icons.circle_outlined,
                  color: contact['isOnline'] ? Colors.green : Colors.grey,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  contact['lastSeen'],
                  style: TextStyle(
                    fontSize: 12,
                    color: contact['isOnline'] ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.message,
                color: Color(AppConstants.primaryColorValue),
                size: 20,
              ),
              onPressed: () {
                // Sohbet başlat
              },
            ),
            IconButton(
              icon: Icon(
                Icons.phone,
                color: Color(AppConstants.primaryColorValue),
                size: 20,
              ),
              onPressed: () {
                // Arama yap
              },
            ),
          ],
        ),
        onTap: () {
          // Kişi detayına git
        },
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF111111).withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            ClipOval(
              child: Container(
                width: 56,
                height: 56,
                child: Image.network(
                  chat['driverImage'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 28,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(AppConstants.primaryColorValue)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (chat['isOnline'])
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(AppConstants.primaryColorValue),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat['customerName'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111111),
                ),
              ),
            ),
            _buildTripStatusChip(chat['tripStatus']),
            SizedBox(width: 8),
            Text(
              chat['lastMessageTime'],
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: Color(AppConstants.primaryColorValue),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    chat['destination'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(AppConstants.textSecondaryColorValue),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    chat['lastMessage'],
                    style: TextStyle(
                      fontSize: 14,
                      color: chat['isPlatformMessage'] == true 
                        ? Color(AppConstants.primaryColorValue)
                        : Color(0xFF444444),
                      fontWeight: chat['isPlatformMessage'] == true 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (chat['unreadCount'] > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(AppConstants.primaryColorValue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      chat['unreadCount'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(chat: chat),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripStatusChip(String status) {
    Color chipColor;
    String chipText;
    
    switch (status) {
      case 'pending':
        chipColor = Colors.orange;
        chipText = 'Bekliyor';
        break;
      case 'active':
        chipColor = Colors.green;
        chipText = 'Aktif';
        break;
      case 'completed':
        chipColor = Colors.blue;
        chipText = 'Tamamlandı';
        break;
      default:
        chipColor = Colors.grey;
        chipText = 'Bilinmiyor';
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        chipText,
        style: TextStyle(
          fontSize: 10,
          color: chipColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chat;

  const ChatDetailScreen({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _messages.addAll(widget.chat['messages']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Container(
                width: 40,
                height: 40,
                child: Image.network(
                  widget.chat['customerImage'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(AppConstants.primaryColorValue)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat['customerName'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.chat['destination'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(AppConstants.primaryColorValue),
        elevation: 0,
        // TODO: Telefon ve video ikonları daha sonra kullanılacak
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.phone, color: Colors.white),
        //     onPressed: () {
        //       // TODO: Arama özelliği
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.video_call, color: Colors.white),
        //     onPressed: () {
        //       // TODO: Video arama özelliği
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessage(msg);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF111111).withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTapDown: (_) => _startRecording(),
                  onTapUp: (_) => _stopRecording(),
                  onTapCancel: () => _cancelRecording(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isRecording ? Colors.red : Color(AppConstants.primaryColorValue),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(AppConstants.primaryColorValue),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    final isMe = msg['isMe'] ?? false;
    final isVoice = msg['isVoice'] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            ClipOval(
              child: Container(
                width: 32,
                height: 32,
                child: Image.network(
                  widget.chat['customerImage'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 16,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(AppConstants.primaryColorValue)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: isMe
                    ? Color(AppConstants.primaryColorValue)
                    : isVoice 
                        ? Color(0xFFE53E3E).withOpacity(0.8) // Sesli mesaj için kırmızı ton
                        : Color(0xFFE8E8E8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: isVoice
                  ? _buildVoiceMessage(msg)
                  : Text(
                      msg['text'],
                      style: TextStyle(
                        color: isMe ? Colors.white : isVoice ? Colors.white : Color(0xFF111111),
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 8),
          if (isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(AppConstants.primaryColorValue),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage(Map<String, dynamic> msg) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => _toggleVoicePlayback(),
        ),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child: LinearProgressIndicator(
            value: 0.3, // TODO: Gerçek ses ilerlemesi
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          msg['duration'] ?? '0:15',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text.trim(),
          'isMe': true,
          'time': DateTime.now().toString().substring(11, 16),
        });
      });
      _messageController.clear();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    // TODO: Ses kaydetme başlat
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    // TODO: Ses kaydetme durdur ve mesaj olarak ekle
    setState(() {
      _messages.add({
        'text': 'Sesli mesaj',
        'isMe': true,
        'time': DateTime.now().toString().substring(11, 16),
        'isVoice': true,
        'duration': '0:15',
      });
    });
  }

  void _cancelRecording() {
    setState(() {
      _isRecording = false;
    });
    // TODO: Ses kaydetme iptal et
  }

  void _toggleVoicePlayback() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    // TODO: Ses oynatma/durdurma
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text.trim(),
          'isMe': true,
          'time': DateTime.now().toString().substring(11, 16),
        });
      });
      _messageController.clear();
    }
  }
} 