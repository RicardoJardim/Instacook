class User {
  final String email;
  final String uid;
  String username;
  String imgUrl;
  bool proUser;
  List <Map> recipesBook;
  List <String> followers;
  List <String> follow;

  User({
    this.email,
    this.uid,
    this.username,
    this.imgUrl: "",
    this.follow: null,
    this.followers: null,
    this.proUser: false,
    this.recipesBook: null
    });
    
}
