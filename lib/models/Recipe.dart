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
  String imgUrl;
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

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'type': this.type,
      'props': this.props,
      'likes': this.likes,
      "saved": this.saved,
      "difficulty": this.difficulty,
      "description": this.description,
      "imgUrl": this.imgUrl,
      "id": this.id,
      "privacy": this.privacy,
      "prods": this.prods,
      "steps": this.steps,
      "time": this.time,
      "userId": this.userId,
      "date": this.date
    };
  }
}
