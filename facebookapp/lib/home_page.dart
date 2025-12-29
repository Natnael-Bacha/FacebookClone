import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import 'models.dart';

import 'friends_page.dart';
import 'messages_page.dart';
import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Material(
              elevation: 1,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'facebook',
                          style: TextStyle(
                            color: Color(0xFF1777F2),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.2,
                          ),
                        ),
                        const Spacer(),
                        CircleButton(icon: Icons.search, onPressed: () {}),
                        CircleButton(
                          icon: Icons.exit_to_app,
                          onPressed: _logout,
                        ),
                      ],
                    ),
                  ),

                  TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xFF1777F2),
                    labelColor: const Color(0xFF1777F2),
                    unselectedLabelColor: Colors.grey[600],
                    tabs: const [
                      Tab(icon: Icon(Icons.home, size: 28)),
                      Tab(icon: Icon(Icons.people, size: 28)),
                      Tab(icon: Icon(Icons.messenger_outline, size: 28)),
                      Tab(icon: Icon(Icons.ondemand_video, size: 28)),
                      Tab(icon: Icon(Icons.notifications, size: 28)),
                      Tab(icon: Icon(Icons.storefront, size: 28)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _HomeFeed(user: user),

                const FriendsPage(),

                const MessagesPage(),

                const Center(child: Text("Videos")),

                const NotificationsPage(),

                const Center(child: Text("Marketplace")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeFeed extends StatelessWidget {
  final User? user;
  const _HomeFeed({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CreatePostContainer(user: user),
        const RoomsAndStories(),
        ...dummyPosts.map((post) => PostContainer(post: post)),
      ],
    );
  }
}

class CreatePostContainer extends StatelessWidget {
  final User? user;
  const CreatePostContainer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayName =
        user?.displayName ?? user?.email?.split('@')[0] ?? "Guest";

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 20, child: Icon(Icons.person)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "What's on your mind, $displayName?",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class RoomsAndStories extends StatelessWidget {
  const RoomsAndStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: 1 + dummyStories.length,
        itemBuilder: (context, index) {
          if (index == 0) return const _StoryCard(isAddStory: true);
          return _StoryCard(story: dummyStories[index - 1]);
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final Story? story;

  const _StoryCard({this.isAddStory = false, this.story});

  @override
  Widget build(BuildContext context) {
    if (isAddStory) {
      return Container(
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                'https://i.pravatar.cc/150',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                "Create Story",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(story!.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            story!.user,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 2, color: Colors.black)],
            ),
          ),
        ),
      ),
    );
  }
}

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.userImageUrl),
            ),
            title: Text(
              post.user,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${post.timeAgo} • Public'),
            trailing: const Icon(Icons.more_horiz),
          ),
          if (post.caption != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(post.caption!),
            ),
          if (post.imageUrl != null)
            Image.network(post.imageUrl!, fit: BoxFit.cover),
          const Divider(),
          Row(
            children: const [
              _PostAction(icon: Icons.thumb_up_alt_outlined, label: "Like"),
              _PostAction(icon: Icons.mode_comment_outlined, label: "Comment"),
              _PostAction(icon: Icons.share_outlined, label: "Share"),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PostAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE4E6EB),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}
