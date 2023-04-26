import 'dart:convert';

GearMotoRideModel gearMotoRideModelFromJson(String str) =>
    GearMotoRideModel.fromJson(json.decode(str));

String gearMotoRideModelToJson(GearMotoRideModel data) =>
    json.encode(data.toJson());

class GearMotoRideModel {
  GearMotoRideModel({
    required this.query,
    required this.motorcycle,
  });

  String query;
  List<Motorcycle> motorcycle;

  factory GearMotoRideModel.fromJson(Map<String, dynamic> json) =>
      GearMotoRideModel(
        query: json["query"],
        motorcycle: List<Motorcycle>.from(
            json["result"].map((x) => Motorcycle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": query,
        "result": List<dynamic>.from(motorcycle.map((x) => x.toJson())),
      };
}

class Motorcycle {
  Motorcycle({
    required this.brakePower,
    required this.country,
    required this.maximumTorque,
    required this.maximumSpeed,
    required this.driving,
    required this.textDescription,
    required this.year,
    required this.acceleration,
    required this.cylinders,
    required this.engineTiming,
    required this.imageUrlBackground,
    required this.motoId,
    required this.weight,
    required this.cylinderCapacity,
    required this.imageUrlFrontPage,
    required this.brand,
    required this.motorcycleName,
    required this.category,
    required this.maximumPower,
  });

  String brakePower;
  String country;
  String maximumTorque;
  String maximumSpeed;
  String driving;
  String textDescription;
  String year;
  String acceleration;
  String cylinders;
  String engineTiming;
  ImageUrl imageUrlBackground;
  String motoId;
  String weight;
  String cylinderCapacity;
  ImageUrl imageUrlFrontPage;
  String brand;
  String motorcycleName;
  String category;
  String maximumPower;

  factory Motorcycle.fromJson(Map<String, dynamic> json) => Motorcycle(
        brakePower: json["brakePower"],
        country: json["country"],
        maximumTorque: json["maximumTorque"],
        maximumSpeed: json["maximumSpeed"],
        driving: json["driving"],
        textDescription: json["textDescription"],
        year: json["year"],
        acceleration: json["acceleration"],
        cylinders: json["cylinders"],
        engineTiming: json["engineTiming"],
        imageUrlBackground: ImageUrl.fromJson(json["imageUrlBackground"]),
        motoId: json["motoId"],
        weight: json["weight"],
        cylinderCapacity: json["cylinderCapacity"],
        imageUrlFrontPage: ImageUrl.fromJson(json["imageUrlFrontPage"]),
        brand: json["brand"],
        motorcycleName: json["motorcycleName"],
        category: json["category"],
        maximumPower: json["maximumPower"],
      );

  Map<String, dynamic> toJson() => {
        "brakePower": brakePower,
        "country": country,
        "maximumTorque": maximumTorque,
        "maximumSpeed": maximumSpeed,
        "driving": driving,
        "textDescription": textDescription,
        "year": year,
        "acceleration": acceleration,
        "cylinders": cylinders,
        "engineTiming": engineTiming,
        "imageUrlBackground": imageUrlBackground.toJson(),
        "motoId": motoId,
        "weight": weight,
        "cylinderCapacity": cylinderCapacity,
        "imageUrlFrontPage": imageUrlFrontPage.toJson(),
        "brand": brand,
        "motorcycleName": motorcycleName,
        "category": category,
        "maximumPower": maximumPower,
      };
}

class ImageUrl {
  ImageUrl({
    required this.asset,
  });

  Asset asset;

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
        asset: Asset.fromJson(json["asset"]),
      );

  Map<String, dynamic> toJson() => {
        "asset": asset.toJson(),
      };
}

class Asset {
  Asset({
    required this.ref,
  });
  String urlPath = "https://cdn.sanity.io/images/kc2aszeh/production/";
  String ref;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        ref: json["_ref"],
      );

  Map<String, dynamic> toJson() => {
        "_ref": ref,
      };
}
