

class ProfileData {
  String id;
  String name;
  String phone;
  String shopName;
  String webLink ;
  String socialLink ;
  String email ;
 List<dynamic> calls;
  bool isOpen;
  String shopLink;
  bool isRegistered;
  String password;
  int? clicks;
  String? token ;



  ProfileData({
    required this.id,
    required this.name,
    required this.phone,
    required this.shopName,
    required this.webLink,
    required this.socialLink,
    required this.email,
    required this.calls,
    required this.isOpen,
    required this.shopLink,
    required this.isRegistered,
    required this.password,
    this.clicks,
    required this.token

    });
  
  factory ProfileData.fromJson(dynamic json) {
  

  return ProfileData(
    id : json["_id"],
    name: json["name"],
    phone: json["phone"],
    shopName: json["shopName"],
    webLink: json["webLink"],
    socialLink: json["socialLink"],
    email: json["email"],
    calls: json["calls"],
    isOpen: json["isOpen"],
    shopLink: json["shopLink"],
    isRegistered: json["isRegistered"],
    password: json["password"],
    clicks: json["clicks"],
    token : json['token'],
  );
}

}