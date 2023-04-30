

class Message{
  final String messageContent;
  Message(this.messageContent);

  factory Message.fromJson(data){
    return Message(data['message']);
  }
}