class Character {
  late int id;
  late String name;
  late String status;
  late String species;
  late String type;
  late String gender;
  late Map<String, dynamic> origin;
  late Map<String, dynamic> location;
  late String image;
  late List<String> episode;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = Map<String, dynamic>.from(json['origin']);
    location = Map<String, dynamic>.from(json['location']);
    image = json['image'];
    episode = json['episode'] != null ? List<String>.from(json['episode']) : [];
  }
}
