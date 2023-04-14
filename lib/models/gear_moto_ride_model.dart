import 'dart:convert';

GearMotoRideModel gearMotoRideModelFromJson(String str) =>
    GearMotoRideModel.fromJson(json.decode(str));

String gearMotoRideModelToJson(GearMotoRideModel data) =>
    json.encode(data.toJson());

class GearMotoRideModel {
  GearMotoRideModel({
    required this.result,
    required this.status,
    required this.message,
  });

  Result result;
  bool status;
  String message;

  factory GearMotoRideModel.fromJson(Map<String, dynamic> json) =>
      GearMotoRideModel(
        result: Result.fromJson(json["result"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "status": status,
        "message": message,
      };
}

class Result {
  Result({
    required this.motos,
  });

  List<Moto> motos;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        motos: List<Moto>.from(json["motos"].map((x) => Moto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "motos": List<dynamic>.from(motos.map((x) => x.toJson())),
      };
}

class Moto {
  Moto({
    required this.motoId,
    required this.brand,
    required this.motorcycleName,
    required this.year,
    required this.country,
    required this.category,
    required this.cylinderCapacity,
    required this.cylinders,
    required this.engineTiming,
    required this.maximumPower,
    required this.maximumTorque,
    required this.weight,
    required this.acceleration,
    required this.maximumSpeed,
    required this.driving,
    required this.brakePower,
    required this.textDescription,
    required this.imageUrlFrontPage,
    required this.imageUrlBackground,
  });

  String motoId;
  String brand;
  String motorcycleName;
  String year;
  String country;
  String category;
  String cylinderCapacity;
  String cylinders;
  String engineTiming;
  String maximumPower;
  String maximumTorque;
  String weight;
  String acceleration;
  String maximumSpeed;
  String driving;
  String brakePower;
  List<String> textDescription;
  String imageUrlFrontPage;
  String imageUrlBackground;

  factory Moto.fromJson(Map<String, dynamic> json) => Moto(
        motoId: json["motoId"],
        brand: json["brand"],
        motorcycleName: json["motorcycleName"],
        year: json["year"],
        country: json["country"],
        category: json["category"],
        cylinderCapacity: json["cylinderCapacity"],
        cylinders: json["cylinders"],
        engineTiming: json["engineTiming"],
        maximumPower: json["maximumPower"],
        maximumTorque: json["maximumTorque"],
        weight: json["weight"],
        acceleration: json["acceleration"],
        maximumSpeed: json["maximumSpeed"],
        driving: json["driving"],
        brakePower: json["brakePower"],
        textDescription:
            List<String>.from(json["textDescription"].map((x) => x)),
        imageUrlFrontPage: json["imageUrlFrontPage"],
        imageUrlBackground: json["imageUrlBackground"],
      );

  Map<String, dynamic> toJson() => {
        "motoId": motoId,
        "brand": brand,
        "motorcycleName": motorcycleName,
        "year": year,
        "country": country,
        "category": category,
        "cylinderCapacity": cylinderCapacity,
        "cylinders": cylinders,
        "engineTiming": engineTiming,
        "maximumPower": maximumPower,
        "maximumTorque": maximumTorque,
        "weight": weight,
        "acceleration": acceleration,
        "maximumSpeed": maximumSpeed,
        "driving": driving,
        "brakePower": brakePower,
        "textDescription": List<dynamic>.from(textDescription.map((x) => x)),
        "imageUrlFrontPage": imageUrlFrontPage,
        "imageUrlBackground": imageUrlBackground,
      };
}
