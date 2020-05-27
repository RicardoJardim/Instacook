
class Recipe{

  String id;
  String name;
  String type;
  int props;
  int likes;
  String difficulty;
  bool privacy;
  String description;
  String imgUrl;
  String userId;
  List <Map> prods;
  List <Map> steps;
  DateTime date;

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