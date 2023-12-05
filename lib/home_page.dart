import 'package:flutter/material.dart';
import 'package:maya_app/colours.dart';
import 'package:maya_app/features.dart';
import 'package:maya_app/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final OpenAiService openAiService = OpenAiService();
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      print(_lastWords);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
    // flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      ///App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Maya",
          style: TextStyle(
            fontFamily: "Cera Pro",
            color: Colours.blackColor,
          ),
        ),
        centerTitle: true,
      ),

      ///Body
      body: Container(
        height: _size.height,
        width: _size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Ai Logo
              // Stack(
              //   children: [
              //     //Background Colour
              //     Container(
              //       margin: const EdgeInsets.only(
              //         top: 4.0,
              //       ),
              //       height: 120,
              //       width: 120,
              //       decoration: const BoxDecoration(
              //         color: Colours.firstSuggestionBoxColor,
              //         shape: BoxShape.circle,
              //       ),
              //     ),
              //     //Foreground Image
              //     Container(
              //       height: 123,
              //       width: 120,
              //       decoration: const BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage("assets/images/virtualAssistant.png"),
              //         ),
              //         shape: BoxShape.circle,
              //       ),
              //     ),
              //   ],
              // ),

              Container(
                height: 123,
                width: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/robo-image.jpg"),
                  ),
                  shape: BoxShape.circle,
                ),
              ),

              ///Result Text

              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                  top: 20.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: Colours.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0).copyWith(
                    topLeft: Radius.zero,
                  ),
                ),
                child: const Text(
                  "Hello ,What task can i do for you?",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Cera Pro",
                    color: Colours.mainFontColor,
                  ),
                ),
              ),

              ///Features
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                  top: 20.0,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Here are few commands.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: "Cera Pro",
                    color: Colours.mainFontColor,
                  ),
                ),
              ),
              //
              const Column(
                children: [
                  //ChatGpt
                  Features(
                    title: "ChatGpt",
                    description:
                        "A smarter way to stay organized and informed with chatGpt.",
                    colour: Colours.firstSuggestionBoxColor,
                  ),
                  //Dall-E
                  Features(
                    title: "Dall-E",
                    description:
                        "Get inspired and stay creative with your personal assistant Dall-E.",
                    colour: Colours.secondSuggestionBoxColor,
                  ),
                  //Smart voice assistant
                  Features(
                    title: "Smart voice assistant",
                    description:
                        "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGpt.",
                    colour: Colours.thirdSuggestionBoxColor,
                  ),
                  //
                ],
              ),

              ///
            ],
          ),
        ),
      ),

      ///Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colours.firstSuggestionBoxColor,
        onPressed: () async {
          if (await _speechToText.hasPermission &&
              _speechToText.isNotListening) {
            await _startListening();
          } else if (_speechToText.isListening) {
            final speech = await openAiService.isArtPromptApi(_lastWords);
            print("ncduoijsdbvcib" + speech);
            if (speech.contains('https')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedImageUrl = null;
              generatedContent = speech;
              setState(() {});
              // await systemSpeak(speech);
            }
            await _stopListening();
          } else {
            _initSpeech();
          }


          // if (await _speechToText.hasPermission &&
          //     _speechToText.isNotListening) {
          //   await _startListening();
          // } else if(_speechToText.isListening) {
          //   await _stopListening();
          // } else {
          //   await _initSpeech();
          // }
        },
        child: Icon(_speechToText.isNotListening ? Icons.mic : Icons.pause),
      ),
    );
  }
}
