import 'dart:convert';

PropertiesListResponse propertiesListResponseFromJson(String str) => PropertiesListResponse.fromJson(json.decode(str));

String propertiesListResponseToJson(PropertiesListResponse data) => json.encode(data.toJson());

class PropertiesListResponse {
  List<PropertyList>? propertyList;

  PropertiesListResponse({
    this.propertyList,
  });

  factory PropertiesListResponse.fromJson(Map<String, dynamic> json) => PropertiesListResponse(
    propertyList: json["property_list"] == null ? [] : List<PropertyList>.from(json["property_list"]!.map((x) => PropertyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "property_list": propertyList == null ? [] : List<dynamic>.from(propertyList!.map((x) => x.toJson())),
  };
}


class PropertyList {
  int? id;
  int? userId;
  String? propertyName;
  int? categoryId;
  int? stateId;
  int? cityId;
  String? address;
  String? budget;
  String? contactDetails;
  List<String>? photos;
  DateTime? createdAt;
  DateTime? updatedAt;

  PropertyList({
    this.id,
    this.userId,
    this.propertyName,
    this.categoryId,
    this.stateId,
    this.cityId,
    this.address,
    this.budget,
    this.contactDetails,
    this.photos,
    this.createdAt,
    this.updatedAt,
  });

  factory PropertyList.fromJson(Map<String, dynamic> json) => PropertyList(
    id: json["id"],
    userId: json["user_id"],
    propertyName: json["property_name"],
    categoryId: json["category_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    address: json["address"],
    budget: json["budget"],
    contactDetails: json["contact_details"],
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "property_name": propertyName,
    "category_id": categoryId,
    "state_id": stateId,
    "city_id": cityId,
    "address": address,
    "budget": budget,
    "contact_details": contactDetails,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

