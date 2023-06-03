// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project_4them/open_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher_string.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();

  String speech = 'Hi, I am your Assistant. How may I help you?';
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> systemspeak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          child: const Text(
            '4Them',
            style: TextStyle(fontSize: 25),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
                width: 20,
              ),
              ZoomIn(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(209, 243, 249, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      height: 123,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/virtualAssistant.png'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FadeInRight(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 40)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(200, 200, 200, 1),
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Text(
                    speech,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 60)
                    .copyWith(top: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(200, 200, 200, 1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  lastWords,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: const Duration(seconds: 2),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              await stopListening();
              final result = lastWords.contains('WhatsApp');
              if (result) {
                speech = await openAIService.isArtPromptAPI(lastWords);
                await systemspeak(speech);
                setState(() {});

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homescreen(),
                  ),
                );
              } else {
                speech = await openAIService.isArtPromptAPI(lastWords);
                await systemspeak(speech);
                setState(() {});
              }
            } else {
              initSpeechToText();
            }
          },
          backgroundColor: const Color.fromRGBO(165, 231, 244, 1),
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  OverlayEntry? overlayEntry;
  int currentPageIndex = 0;

  void createHighlightOverlay({
    required AlignmentDirectional alignment,
    required Color borderColor,
  }) {
    removeHighlightOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return SafeArea(
          child: Align(
            alignment: alignment,
            heightFactor: 1.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Tap here for'),
                  Builder(builder: (BuildContext context) {
                    switch (currentPageIndex) {
                      case 0:
                        return Column(
                          children: const <Widget>[
                            Text(
                              'chat page',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ],
                        );
                      case 1:
                        return Column(
                          children: const <Widget>[
                            Text(
                              'Status page',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                            ),
                          ],
                        );
                      case 2:
                        return Column(
                          children: const <Widget>[
                            Text(
                              'Calls page',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.orange,
                            ),
                          ],
                        );
                      default:
                        return const Text('No page selected.');
                    }
                  }),
                  SizedBox(
                    width: 80,
                    height: 40.0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Whatsapp",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
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
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                controller: _controller,
                indicatorColor: Colors.white,
                onTap: (text) {},
                tabs: const [
                  Tab(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
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
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(18, 140, 126, 1),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const ListTile(
            leading: CircleAvatar(
              radius: 40,
            ),
            title: Text("Contact 1"),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          const SizedBox(
            height: 500,
          ),
          ElevatedButton(
            onPressed: () {
              openWhatsApp();
            },
            child: const Text('Open Whatsapp'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(18, 140, 126, 1),
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}

void openWhatsApp() async {
  String phoneNumber = '916238415142';

  //final Uri url = Uri.parse('https://api.whatsapp.com/send/?phone=1916238415142&text=Hi+%EF%BF%BD&type=phone_number&app_absent=0');
  final Uri url = Uri.parse('https://web.whatsapp.com/send/?phone=1916238415142&text=Hi+%EF%BF%BD&type=phone_number&app_absent=0');
  //final Uri url = Uri.parse('https://web.whatsapp.com/');
  //final Uri url = Uri.parse('https://wa.me/1$phoneNumber');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Contact {
  final String name;

  Contact({required this.name});
}
