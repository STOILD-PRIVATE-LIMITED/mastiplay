import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';

// const String momentsServer = "https://v9nm4hsv-3007.asse.devtunnels.ms";
// const String momentsServer = "https://bcb0-103-137-198-235.ngrok-free.app";
const String momentsServer = "https://3.7.66.245:3007";

class Post {
  String postId = "";
  String title = "";
  String description = "";
  String postedBy = "";
  String? imgUrl;
  List<String> tags = [];
  int sharedCount = 0;
  int commentsCount = 0;
  int likesCount = 0;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  bool hasLiked = false;
  bool hasCommented = false;
  bool doesFollow = false;
  Post({
    this.postId = "",
    this.title = "",
    this.description = "",
    this.postedBy = "",
    this.imgUrl,
    this.tags = const [],
    this.sharedCount = 0,
    this.commentsCount = 0,
    this.likesCount = 0,
    this.hasLiked = false,
    this.hasCommented = false,
    this.doesFollow = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    createdAt ??= DateTime.now();
    updatedAt ??= DateTime.now();
    // ignore: prefer_initializing_formals
    this.createdAt = createdAt;
    // ignore: prefer_initializing_formals
    this.updatedAt = updatedAt;
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['PostId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      postedBy: json['postedBy'] as String,
      imgUrl: json['imgUrl'] as String?,
      tags: (json['tags'] as List<dynamic>).cast(),
      sharedCount: json['sharedCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      likesCount: json['likesCount'] ?? 0,
      hasLiked: json['hasLiked'] ?? false,
      hasCommented: json['hasCommented'] ?? false,
      doesFollow: json['doesFollow'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PostId': postId,
      'title': title,
      'description': description,
      'postedBy': postedBy,
      'imgUrl': imgUrl,
      'tags': tags,
    };
  }

  @override
  String toString() {
    return 'Post(PostId: $postId, title: $title, description: $description, postedBy: $postedBy, imgUrl: $imgUrl, tags: $tags, sharedCount: $sharedCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

Future<void> postPost(Post post) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/posts/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(post.toJson()),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to post post');
  }
}

Future<List<Post>> getHotPosts(int limit, int startPostId) async {
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/hot?limit=$limit&start=$startPostId&userId=${currentUser.id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> posts = json.decode(response.body);
    return posts.map((e) => Post.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<List<Post>> getRecentPost(int limit, int startPostId) async {
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/recent?limit=$limit&start=$startPostId&userId=${currentUser.id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> posts = json.decode(response.body);
    return posts.map((e) => Post.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<List<Post>> getFollowingPost(int limit, int start) async {
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/following?userId=${currentUser.id}&limit=$limit&start=$start'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> posts = json.decode(response.body);
    return posts.map((e) => Post.fromJson(e)).toList();
  } else {
    log("Failed to following load posts: ${response.body}");
    throw Exception('Failed to load posts');
  }
}

Future<void> sharePost(String postId) async {
  try {
    final response = await http.put(
      Uri.parse('$momentsServer/api/posts/share'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"postId": postId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to share post');
    }
  } catch (e) {
    log("Failed to share post: $e");
  }
}

Future<List<Post>> searchPost(List<String>? tags, int limit, int start) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/search-with-tags?userId=${currentUser.id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "userId": currentUser.id,
      "tags": tags,
      "limit": limit,
      "start": start
    }),
  );
  if (response.statusCode == 200) {
    final List<dynamic> posts = json.decode(response.body);
    return posts.map((e) => Post.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<void> commentPost(Post post, String comment) async {
  try {
    final response = await http.post(
      Uri.parse('$momentsServer/api/comment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "postId": post.postId,
        "comment": comment,
        'userId': currentUser.id,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to comment post');
    }
  } catch (e) {
    log("Failed to comment post: $e");
  }
}

Future<void> likePost(Post post) async {
  try {
    final response = await http.post(
      Uri.parse('$momentsServer/api/like'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "postId": post.postId,
        'userId': currentUser.id,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like a post');
    }
  } catch (e) {
    log("Failed to comment post: $e");
  }
}

// Future<void> deletePost(String postId) async {
//   final response = await http.delete(
//     Uri.parse('$momentsServer/api/posts/$postId'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
//   if (response.statusCode != 200) {
//     throw Exception('Failed to delete post');
//   }
// }
