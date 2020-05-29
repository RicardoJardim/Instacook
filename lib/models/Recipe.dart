
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe{

  String id;
  String name;
  String type;
  int props;
  List likes;
  String difficulty;
  bool privacy;
  String description;
  String imgUrl;
  String userId;
  List prods;
  List steps;
  Timestamp date;

  Recipe({
    this.name,
    this.type,
    this.props,
    this.likes,
    this.difficulty,
    this.description,
    this.imgUrl,
    this.id,
    this.privacy,
    this.prods,
    this.steps,
    this.userId,
    this.date
    });

  }