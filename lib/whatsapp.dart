/* final Uri phoneNumber = Uri.parse('tel:+916238415142');
final Uri whatsApp = Uri.parse('https://wa.me/+916238415142');
 */
/* import 'package:project_4them/Model/ChatModel.dart';
import 'package:chatapp/Pages/CameraPage.dart';
import 'package:chatapp/Pages/ChatPage.dart'; */
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key/* , this.chatmodels, this.sourchat */}) : super(key: key);
/*   final List<ChatModel> chatmodels;
  final ChatModel sourchat;
 */
  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Whatsapp"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                const PopupMenuItem(
                  value: "New group",
                  child: Text("New group"),
                ),
                const PopupMenuItem(
                  value: "New broadcast",
                  child: Text("New broadcast"),
                ),
                const PopupMenuItem(
                  value: "Whatsapp Web",
                  child: Text("Whatsapp Web"),
                ),
                const PopupMenuItem(
                  value: "Starred messages",
                  child: Text("Starred messages"),
                ),
                const PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings"),
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(18, 140, 126, 1),
      ),
      /* body: TabBarView(
        controller: _controller,
        children: const [
          /* CameraPage(),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourchat: widget.sourchat,
          ), */
          Text("STATUS"),
          Text("Calls"),
        ],
      ), */
    );
  }
}