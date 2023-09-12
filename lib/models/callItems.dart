class CallItem {
  String number;
  String time;
  String? duration;
  bool isAccepted;

  CallItem({required this.number,  required this.time, this.duration,  required this.isAccepted});
  
  factory CallItem.fromJson(dynamic json){
    return CallItem(
      number: json["number"],
    time : json["time"],
    duration : json["duration"],
    isAccepted: json["isAccepted"]
    );
  }
}