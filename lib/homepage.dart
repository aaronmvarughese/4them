// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project_4them/open_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher_string.dart';

//import 'package:call_log/call_log.dart';
import 'package:project_4them/whatsapp.dart';
import 'package:project_4them/CallerScreen.dart';

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
    await flutterTts.setLanguage('Malayalam');
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
              final result1 = lastWords.contains('call');
             final result2 = lastWords.contains('WhatsApp');
              if (result1) {
                //speech = await openAIService.isArtPromptAPI(lastWords);
                await systemspeak(speech);
                setState(() {});

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CallerScreen(),
                  ),
                );
              } else if (result2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WhatsApp(),
                  ),
                );
              } else {
                //speech = await openAIService.isArtPromptAPI(lastWords);
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
