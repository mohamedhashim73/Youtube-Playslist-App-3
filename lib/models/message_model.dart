class MessageModel{
  String? content;
  String? date;
  String? senderID;

  MessageModel({required this.content,required this.date,required this.senderID});

  // refactoring map | json
  MessageModel.fromJson({required Map<String,dynamic> data}){
    content = data['content'];
    date = data['date'];
    senderID = data['senderID'];
  }

  Map<String,dynamic> toJson(){
    return {
      'content' : content,
      'date' : date,
      'senderID' : senderID,
    };
  }

}