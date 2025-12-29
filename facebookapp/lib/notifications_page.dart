import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: const Text(
              "Notifications",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [_CircleActionBtn(icon: Icons.search)],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _FilterChip(label: "All", isSelected: true),
                  const SizedBox(width: 8),
                  _FilterChip(label: "Unread", isSelected: false),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                "New",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return NotificationTile(notification: dummyNotifications[index]);
            }, childCount: dummyNotifications.length),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        color: notification.isRead ? Colors.white : const Color(0xFFE7F3FF),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(notification.imageUrl),
                ),
                Positioned(
                  bottom: 0,
                  right: -2,
                  child: _NotificationIconBadge(type: notification.type),
                ),
              ],
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: notification.user,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " ${notification.message}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.time,
                    style: TextStyle(
                      color: notification.isRead
                          ? Colors.grey[600]
                          : const Color(0xFF1877F2),
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  onPressed: () {},
                ),
                if (!notification.isRead)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1877F2),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE7F3FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF1877F2) : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _NotificationIconBadge extends StatelessWidget {
  final NotificationType type;
  const _NotificationIconBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case NotificationType.like:
        icon = Icons.thumb_up;
        color = const Color(0xFF1877F2);
        break;
      case NotificationType.comment:
        icon = Icons.mode_comment;
        color = const Color(0xFF45BD62);
        break;
      case NotificationType.friendRequest:
        icon = Icons.person;
        color = const Color(0xFF1877F2);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }
}

class _CircleActionBtn extends StatelessWidget {
  final IconData icon;
  const _CircleActionBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 22),
        onPressed: () {},
      ),
    );
  }
}

enum NotificationType { like, comment, friendRequest }

class AppNotification {
  final String user;
  final String imageUrl;
  final String message;
  final String time;
  final bool isRead;
  final NotificationType type;

  AppNotification({
    required this.user,
    required this.imageUrl,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

final dummyNotifications = [
  AppNotification(
    user: "Alex Johnson",
    imageUrl: "https://i.pravatar.cc/150?img=31",
    message: "liked your post: \"The best way to learn Flutter...\"",
    time: "5m",
    type: NotificationType.like,
  ),
  AppNotification(
    user: "Sara Smith",
    imageUrl: "https://i.pravatar.cc/150?img=32",
    message: "commented on your photo: \"This looks amazing!\"",
    time: "20m",
    type: NotificationType.comment,
  ),
  AppNotification(
    user: "Michael Brown",
    imageUrl: "https://i.pravatar.cc/150?img=33",
    message: "sent you a friend request. Tap to see more suggestions.",
    time: "1h",
    type: NotificationType.friendRequest,
  ),
  AppNotification(
    user: "Emily Davis",
    imageUrl: "https://i.pravatar.cc/150?img=34",
    message: "liked your comment: \"I agree with your point!\"",
    time: "Yesterday",
    type: NotificationType.like,
    isRead: true,
  ),
];
