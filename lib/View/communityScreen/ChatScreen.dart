// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:tripmates/services/authservices.dart';
// import 'package:tripmates/services/chatService.dart';
// import 'package:tripmates/widgets/custom_textFields.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String recieverEmail;
//   final String receiverId;
//
//   ChatScreen({super.key, required this.recieverEmail, required this.receiverId, required String agentId});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final AuthServices _authServices = AuthServices();
//
//   String receiverPhotoUrl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchReceiverDetails();
//   }
//
//   void _fetchReceiverDetails() async {
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.receiverId).get();
//     if (userDoc.exists) {
//       setState(() {
//         receiverPhotoUrl = userDoc["photoUrl"] ?? "";
//       });
//     }
//   }
//
//   void sendMessage() async {
//     if (messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(widget.receiverId, messageController.text);
//       messageController.clear();
//     }
//   }
//
//   void deleteMessage(String messageId) async {
//     await _chatService.deleteMessage(widget.receiverId, messageId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: receiverPhotoUrl.isNotEmpty
//                   ? NetworkImage(receiverPhotoUrl)
//                   : AssetImage("assets/images/AppLogo-TripMates.png") as ImageProvider,
//             ),
//             SizedBox(width: 10),
//             Text(widget.recieverEmail),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildMessageList()),
//           _buildUserInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageList() {
//     String senderID = _authServices.getCurrentUser()!.uid;
//
//     return StreamBuilder(
//       stream: _chatService.getMessages(widget.receiverId, senderID),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Error loading messages');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text("No messages yet."));
//         }
//
//         return ListView(
//           reverse: true,
//           children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
//         );
//       },
//     );
//   }
//
//   Widget _buildMessageItem(QueryDocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     bool isCurrentUser = data["senderID"] == _authServices.getCurrentUser()!.uid;
//
//     return GestureDetector(
//       onLongPress: () {
//         if (isCurrentUser) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text("Delete Message"),
//               content: Text("Are you sure you want to delete this message?"),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     deleteMessage(doc.id);
//                     Navigator.pop(context);
//                   },
//                   child: Text("Delete", style: TextStyle(color: Colors.red)),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//       child: Align(
//         alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: isCurrentUser ? Colors.green[300] : Colors.grey[300],
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 data["messages"] ?? "No Message",
//                 style: TextStyle(fontSize: 16),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Text(
//                   "${data["timestamp"].toDate().hour}:${data["timestamp"].toDate().minute}",
//                   style: TextStyle(fontSize: 12, color: Colors.black54),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserInput() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Row(
//         children: [
//           Expanded(
//             child: CustomTextField(
//               controller: messageController,
//               label: 'Type Message',
//               hint: 'Type message here',
//               icon: Icons.edit,
//             ),
//           ),
//           IconButton(
//             onPressed: sendMessage,
//             icon: Icon(Icons.send, color: Colors.blue),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripmates/services/authservices.dart';
import 'package:tripmates/services/chatService.dart';
import 'package:tripmates/widgets/custom_textFields.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;

  ChatScreen({Key? key, required this.receiverEmail, required this.receiverId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();

  String receiverPhotoUrl = "";

  @override
  void initState() {
    super.initState();
    _fetchReceiverDetails();
  }

  void _fetchReceiverDetails() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.receiverId).get();
    if (userDoc.exists) {
      setState(() {
        receiverPhotoUrl = userDoc["photoUrl"] ?? "";
      });
    }
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  void deleteMessage(String messageId) async {
    await _chatService.deleteMessage(widget.receiverId, messageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: receiverPhotoUrl.isNotEmpty
                  ? NetworkImage(receiverPhotoUrl)
                  : AssetImage("assets/images/AppLogo-TripMates.png") as ImageProvider,
            ),
            SizedBox(width: 10),
            Text(widget.receiverEmail),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authServices.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverId, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading messages');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }

        return ListView(
          reverse: true,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data["senderID"] == _authServices.getCurrentUser()!.uid;

    return GestureDetector(
      onLongPress: () {
        if (isCurrentUser) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Delete Message"),
              content: Text("Are you sure you want to delete this message?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    deleteMessage(doc.id);
                    Navigator.pop(context);
                  },
                  child: Text("Delete", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        }
      },
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green[300] : Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(data["messages"] ?? "No Message"),
        ),
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(child: CustomTextField(controller: messageController, hint: 'Type message here', label: '', icon: Icons.edit,)),
          IconButton(onPressed: sendMessage, icon: Icon(Icons.send, color: Colors.blue)),
        ],
      ),
    );
  }
}
