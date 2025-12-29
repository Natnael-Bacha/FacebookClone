class Post {
  final String user;
  final String userImageUrl;
  final String timeAgo;
  final String? caption;
  final String? imageUrl;
  final String likes;
  final String comments;
  final String shares;

  const Post({
    required this.user,
    required this.userImageUrl,
    required this.timeAgo,
    this.caption,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

class Story {
  final String user;
  final String userImageUrl;
  final String imageUrl;

  const Story({
    required this.user,
    required this.userImageUrl,
    required this.imageUrl,
  });
}

final List<Story> dummyStories = [
  const Story(
    user: 'User Two',
    userImageUrl: 'https://i.pravatar.cc/150?img=2',
    imageUrl: 'https://picsum.photos/id/237/200/300',
  ),
  const Story(
    user: 'User Three',
    userImageUrl: 'https://i.pravatar.cc/150?img=3',
    imageUrl: 'https://picsum.photos/id/238/200/300',
  ),
  const Story(
    user: 'User Four',
    userImageUrl: 'https://i.pravatar.cc/150?img=4',
    imageUrl: 'https://picsum.photos/id/239/200/300',
  ),
  const Story(
    user: 'User Five',
    userImageUrl: 'https://i.pravatar.cc/150?img=5',
    imageUrl: 'https://picsum.photos/id/240/200/300',
  ),
];

final List<Post> dummyPosts = [
  const Post(
    user: 'Marcus Ng',
    userImageUrl: 'https://i.pravatar.cc/150?img=59',
    timeAgo: '58m',
    caption: 'Enjoying the beautiful view! 🏔️',
    imageUrl:
        'https://images.pexels.com/photos/158063/bellingrath-gardens-alabama-landscape-scenic-158063.jpeg?auto=compress&cs=tinysrgb&w=600',
    likes: '1.2K',
    comments: '284',
    shares: '48',
  ),
  const Post(
    user: 'Flutter Devs',
    userImageUrl: 'https://i.pravatar.cc/150?img=60',
    timeAgo: '2h',
    caption: 'Just released a new update for the app. Check it out! 🚀',
    imageUrl:
        'https://images.pexels.com/photos/276452/pexels-photo-276452.jpeg?auto=compress&cs=tinysrgb&w=600',
    likes: '892',
    comments: '122',
    shares: '16',
  ),
  const Post(
    user: 'Jane Doe',
    userImageUrl: 'https://i.pravatar.cc/150?img=32',
    timeAgo: '5h',
    caption: 'Look at this puppy! 🐶',
    imageUrl:
        'https://images.pexels.com/photos/1390361/pexels-photo-1390361.jpeg',
    likes: '2.5K',
    comments: '402',
    shares: '120',
  ),
];
