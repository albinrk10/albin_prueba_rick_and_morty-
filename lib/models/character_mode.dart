import 'dart:convert';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));

String characterToJson(Character data) => json.encode(data.toJson());

class Character {
  String? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? image;
  Origin? origin;
  List<Episode>? episode; 

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
    this.origin,
    this.episode, 
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        image: json["image"],
        origin: json["origin"] == null ? null : Origin.fromJson(json["origin"]),
        episode: json["episode"] == null
            ? []
            : List<Episode>.from(json["episode"].map((x) => Episode.fromJson(x))), // Añadir esta línea
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "image": image,
        "origin": origin?.toJson(),
        "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x.toJson())), // Añadir esta línea
      };
}

class Origin {
  String? id;
  String? name;
  String? type;
  String? dimension;
  String? created;

  Origin({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.created,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "created": created,
      };
}

class Episode {
  String? id;
  String? name;
  String? airDate;
  String? episode;
  String? created;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "created": created,
      };
}