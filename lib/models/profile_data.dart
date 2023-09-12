import 'package:liviso_flutter/models/callItems.dart';

class ProfileData {
  String name;
  String phone;
  String shopName;
  String webLink ;
  String socialLink ;
  String email ;
 List<dynamic>? calls;
  bool? isOpen;
  String shopLink;
  bool? isRegistered;
  String password;
  int? clicks;
  bool? isCreatedRoom;



  ProfileData({
    required this.name,
    required this.phone,
    required this.shopName,
    required this.webLink,
    required this.socialLink,
    required this.email,
    this.calls,
    this.isOpen,
    required this.shopLink,
    this.isRegistered,
    required this.password,
    this.clicks,
    this.isCreatedRoom

    });
  
  factory ProfileData.fromJson(dynamic json){
    return ProfileData(
      name : json["name"],
      phone : json["phone"],
      shopName : json["shopName"],
      webLink : json["webLink"],
      socialLink : json["socialLink"],
      email : json["email"],
      calls :json["calls"],
      isOpen : json["isOpen"],
      shopLink : json["shopLink"],
      isRegistered: json["isRegistered"],
      password: json["password"],
      clicks : json["clicks"],
      isCreatedRoom: json["isCreatedRoom"]
    );
  }
}