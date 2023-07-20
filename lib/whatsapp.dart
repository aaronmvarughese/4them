import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class WhatsApp extends StatefulWidget {
  const WhatsApp({Key? key}) : super(key: key);

  @override
  WhatsAppState createState() => WhatsAppState();
}

class WhatsAppState extends State<WhatsApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Whatsapp",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(18, 140, 126, 1),
        actions: [
          Tooltip(
            message: 'Here WhatsApp Camera can be opened',
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.photo_camera_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Tooltip(
            message: 'Search',
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: 'Click Here for a Pop Up Menu',
            child: PopupMenuButton<String>(
              onSelected: (value) {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
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
            ),
          )
        ],
      ),

      //alignment: Alignment.bottomCenter,
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(18, 140, 126, 1),
            child: TabBar(
              labelColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
              controller: _tabController,
              indicatorColor: const Color.fromARGB(255, 255, 255, 255),
              //onTap: (text) {},
              tabs: const [
                Tooltip(
                  message: 'Here Community Chats are shown',
                  child: Tab(
                    icon: Icon(Icons.groups_3, color: Colors.white),
                  ),
                ),
                Tooltip(
                  message: 'Here WhatsApp Chats are shown',
                  child: Tab(
                    text: "CHATS",
                  ),
                ),
                Tooltip(
                  message: 'Here WhatsApp Status are shown',
                  child: Tab(
                    text: "STATUS",
                  ),
                ),
                Tooltip(
                  message: 'Here WhatsApp Calls are shown',
                  child: Tab(
                    text: "CALLS",
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('Community')),
                Center(child: Text('Chats')),
                Center(child: Text('Status')),
                Center(child: Text('Calls')),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: Tooltip(
        message: 'Chat Menu',
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromRGBO(18, 140, 126, 1),
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      ),
    );
  }
}
