import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String id;
  String name;
  String type;
  int props;
  List likes;
  List saved;
  String difficulty;
  bool privacy;
  String description;
  dynamic imgUrl;
  String userId;
  List prods;
  List steps;
  Timestamp date;
  String time;
  Recipe(
      {this.name,
      this.type,
      this.props,
      this.likes,
      this.saved,
      this.difficulty,
      this.description,
      this.imgUrl,
      this.id,
      this.privacy,
      this.prods,
      this.steps,
      this.time,
      this.userId,
      this.date});
}
