class User {
  final String email;
  final String uid;
  String username;
  String imgUrl;
  bool proUser;
  List<dynamic> recipesBook;
  List<dynamic> followers;
  List<dynamic> follow;
  List<dynamic> myrecipes;

  User(
      {this.email,
      this.uid,
      this.username,
      this.imgUrl: "",
      this.follow,
      this.followers,
      this.proUser,
      this.recipesBook,
      this.myrecipes});
}
