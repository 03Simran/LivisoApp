

class CallItem{
  final phoneNo;
  final accepted;
  final durn;
  final dateTime;

  CallItem( {
    required this.phoneNo, 
    required this.accepted,
    required this.durn,
    required this.dateTime

  });

  factory CallItem.fromJson(Map<String, dynamic> json) {
    return CallItem(
      phoneNo: json['phoneNo'],
      accepted: json['accepted'],
      durn: json['durn'],
      dateTime : json['dateTime']
    );
}
}

