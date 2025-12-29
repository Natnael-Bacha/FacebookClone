import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MessagesPage()),
  );
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          _CircleIconButton(icon: Icons.camera_alt),
          _CircleIconButton(icon: Icons.edit),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F2F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                const _ActiveFriendsSection(),

                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummyChats.length,
                  itemBuilder: (context, index) {
                    final chat = dummyChats[index];
                    return ChatTile(chat: chat);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _AvatarWithStatus(imageUrl: chat.imageUrl, isOnline: chat.isOnline),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: chat.isUnread
                                ? Colors.black
                                : Colors.grey[600],
                            fontWeight: chat.isUnread
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "·",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Text(
                        chat.time,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (chat.isUnread)
              Container(
                margin: const EdgeInsets.only(left: 8),
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF0084FF),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ActiveFriendsSection extends StatelessWidget {
  const _ActiveFriendsSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: dummyChats.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _AddStoryItem();
          }
          final friend = dummyChats[index - 1];
          return Container(
            width: 75,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                _AvatarWithStatus(
                  imageUrl: friend.imageUrl,
                  isOnline: friend.isOnline,
                  radius: 30,
                ),
                const SizedBox(height: 6),
                Text(
                  friend.name.split(" ")[0],
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AvatarWithStatus extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;
  final double radius;

  const _AvatarWithStatus({
    required this.imageUrl,
    this.isOnline = false,
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(imageUrl),
        ),
        if (isOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF31A24C),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
      ],
    );
  }
}

class _AddStoryItem extends StatelessWidget {
  const _AddStoryItem();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFF1F2F6),
            child: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
          const SizedBox(height: 6),
          const Text(
            "Your Story",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  const _CircleIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F2F6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 20),
        onPressed: () {},
      ),
    );
  }
}

class Chat {
  final String name;
  final String imageUrl;
  final String lastMessage;
  final String time;
  final bool isOnline;
  final bool isUnread;

  Chat({
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.time,
    this.isOnline = false,
    this.isUnread = false,
  });
}

final dummyChats = [
  Chat(
    name: "Alex Johnson",
    imageUrl: "https://i.pravatar.cc/150?img=21",
    lastMessage: "Hey, are you coming tonight?",
    time: "2m",
    isOnline: true,
    isUnread: true,
  ),
  Chat(
    name: "Sara Smith",
    imageUrl: "https://i.pravatar.cc/150?img=22",
    lastMessage: "That was awesome 😂",
    time: "15m",
    isOnline: false,
    isUnread: false,
  ),
  Chat(
    name: "Michael Brown",
    imageUrl: "https://i.pravatar.cc/150?img=23",
    lastMessage: "Let’s catch up tomorrow",
    time: "1h",
    isOnline: true,
    isUnread: false,
  ),
  Chat(
    name: "Emily Davis",
    imageUrl: "https://i.pravatar.cc/150?img=24",
    lastMessage: "Seen",
    time: "Yesterday",
    isOnline: false,
    isUnread: false,
  ),
];
