import '../model/chat.dart';
import '../model/message.dart';
import '../model/user.dart';

//sample users
User mainUser = User.chat(first_name: "Anna", last_name: "Banana");
User otherUser = User.chat(first_name: "John", last_name: "Smith");

//so say these are sample messages
Message samplemessage1 =
    Message(content: "Hello!", by: 0, time: DateTime.now());
Message samplemessage2 = Message(
    content:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    by: 0,
    time: DateTime.now());
Message samplemessage3 = Message(content: "Good", by: 1, time: DateTime.now());
Message samplemessage4 =
    Message(content: samplemessage2.content, by: 1, time: DateTime.now());

Chat sampleChatTile = Chat(
    imageURL: "https://via.placeholder.com/150",
    messages: [samplemessage1, samplemessage2, samplemessage3, samplemessage4],
    users: [mainUser, otherUser],
    lastMessage: "we'll figure this out later");
