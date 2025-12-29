import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SafeArea(child: FriendsPage())),
    ),
  );
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Friends",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 28),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F2F6),
                  shape: const CircleBorder(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              _PillButton(text: "Suggestions", isSelected: true),
              const SizedBox(width: 10),
              _PillButton(text: "Your friends", isSelected: false),
            ],
          ),

          const Divider(height: 30, thickness: 0.5, color: Colors.grey),

          _SectionHeader(title: "Friend Requests", actionText: "See all"),
          ...dummyRequests.map((user) => FriendRequestItem(user: user)),

          const Divider(height: 40, thickness: 8, color: Color(0xFFF0F2F5)),
          const SizedBox(height: 10),

          _SectionHeader(title: "People You May Know"),
          ...dummySuggestions.map((user) => FriendSuggestionItem(user: user)),
        ],
      ),
    );
  }
}

class FriendRequestItem extends StatelessWidget {
  final Friend user;
  const FriendRequestItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      "2w",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                const Text(
                  "2 mutual friends",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _FBButton(
                        text: "Confirm",
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FBButton(
                        text: "Delete",
                        isPrimary: false,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FriendSuggestionItem extends StatelessWidget {
  final Friend user;
  const FriendSuggestionItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Suggested for you",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _FBButton(
                        text: "Add friend",
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FBButton(
                        text: "Remove",
                        isPrimary: false,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FBButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _FBButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isPrimary
              ? const Color(0xFF1877F2)
              : const Color(0xFFE4E6EB),
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF050505),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _PillButton({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E6EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;

  const _SectionHeader({required this.title, this.actionText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (actionText != null)
            Text(
              actionText!,
              style: const TextStyle(color: Color(0xFF1877F2), fontSize: 16),
            ),
        ],
      ),
    );
  }
}

class Friend {
  final String name;
  final String imageUrl;
  Friend(this.name, this.imageUrl);
}

final dummyRequests = [
  Friend("Alex Johnson", "https://i.pravatar.cc/150?img=11"),
  Friend("Sara Smith", "https://i.pravatar.cc/150?img=5"),
  Friend("John Doe", "https://i.pravatar.cc/150?img=3"),
];

final dummySuggestions = [
  Friend("Michael Brown", "https://i.pravatar.cc/150?img=13"),
  Friend("Emily Davis", "https://i.pravatar.cc/150?img=9"),
  Friend("Jessica Williams", "https://i.pravatar.cc/150?img=20"),
];
