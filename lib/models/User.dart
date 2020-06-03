class User {
  final String email;
  final String uid;
  final String id;
  String username;
  String imgUrl;
  bool proUser;
  List<dynamic> recipesBook;
  List<dynamic> followers;
  List<dynamic> follow;

  User({
    this.email,
    this.id,
    this.uid,
    this.username,
    this.imgUrl: "",
    this.follow,
    this.followers,
    this.proUser,
    this.recipesBook,
  });
}
