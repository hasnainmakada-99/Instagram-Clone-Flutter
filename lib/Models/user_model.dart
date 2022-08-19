class User {
  final String email;
  final String userName;
  final String uid;
  final String bio;
  final String photoURL;
  final List following;
  final List followers;

  const User({
    required this.email,
    required this.userName,
    required this.uid,
    required this.bio,
    required this.photoURL,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": userName,
        "uid": uid,
        "bio": bio,
        "photo url": photoURL,
        "following": following,
        "followers": followers,
      };
}
