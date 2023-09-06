class MeetingDetail {
  String? id;
  String? hostId;
  String? hostName;

  MeetingDetail({this.id, this.hostId, this.hostName});
  
  factory MeetingDetail.fromJson(dynamic json){
    return MeetingDetail(hostId: json["hostId"],
    id : json["id"],
    hostName : json["hostName"]
    );
  }
}