import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> chats = [
    {
      'id': '1',
      'driverName': 'Ahmet Yılmaz',
      'driverImage': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Merhaba, ne zaman geleceksiniz?',
      'lastMessageTime': '14:30',
      'unreadCount': 2,
      'isOnline': true,
      'rating': 9.2,
      'messages': [
        {'text': 'Merhaba, ne zaman geleceksiniz?', 'isMe': false, 'time': '14:30'},
        {'text': '5 dakika içinde orada olacağım', 'isMe': true, 'time': '14:25'},
        {'text': 'Tamam, bekliyorum', 'isMe': false, 'time': '14:20'},
      ]
    },
    {
      'id': '2',
      'driverName': 'Mehmet Kaya',
      'driverImage': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Sefer tamamlandı, teşekkürler!',
      'lastMessageTime': '12:15',
      'unreadCount': 0,
      'isOnline': false,
      'rating': 9.8,
      'messages': [
        {'text': 'Sefer tamamlandı, teşekkürler!', 'isMe': false, 'time': '12:15'},
        {'text': 'Rica ederim, iyi yolculuklar', 'isMe': true, 'time': '12:10'},
      ]
    },
    {
      'id': '3',
      'driverName': 'Ali Demir',
      'driverImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Sesli mesaj gönderdi',
      'lastMessageTime': '09:45',
      'unreadCount': 1,
      'isOnline': true,
      'rating': 8.9,
      'messages': [
        {'text': 'Sesli mesaj', 'isMe': false, 'time': '09:45', 'isVoice': true, 'duration': '0:15'},
        {'text': 'Anladım, teşekkürler', 'isMe': true, 'time': '09:40'},
      ]
    },
    {
      'id': '4',
      'driverName': 'Fatma Özkan',
      'driverImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Konumunuzu paylaşabilir misiniz?',
      'lastMessageTime': 'Dün',
      'unreadCount': 0,
      'isOnline': false,
      'rating': 9.5,
      'messages': [
        {'text': 'Konumunuzu paylaşabilir misiniz?', 'isMe': false, 'time': 'Dün'},
        {'text': 'Tabii, hemen gönderiyorum', 'isMe': true, 'time': 'Dün'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Sohbetler',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(AppConstants.primaryColorValue),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF111111)),
            onPressed: () {
              // TODO: Sohbet arama özelliği
            },
          ),
        ],
      ),
      body: chats.isEmpty
          ? Center(
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
                    'Henüz sohbetiniz yok',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111111).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sürücülerle sohbet etmeye başlayın',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF111111).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return _buildChatItem(chat);
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
                chat['driverName'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111111),
                ),
              ),
            ),
            Text(
              chat['lastMessageTime'],
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                chat['lastMessage'],
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF444444),
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
                  widget.chat['driverImage'],
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
                    widget.chat['driverName'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.chat['isOnline'] ? 'Çevrimiçi' : 'Çevrimdışı',
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
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.white),
            onPressed: () {
              // TODO: Arama özelliği
            },
          ),
          IconButton(
            icon: Icon(Icons.video_call, color: Colors.white),
            onPressed: () {
              // TODO: Video arama özelliği
            },
          ),
        ],
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
                  widget.chat['driverImage'],
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
                    : Color(0xFFF5F5F5),
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
                        color: isMe ? Colors.white : Color(0xFF111111),
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
} 