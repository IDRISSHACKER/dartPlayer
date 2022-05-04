import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{

  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_MyApp();
}

class _MyApp extends State<MyApp>{
  //const MyApp({Key? key}) : super(key: key);

  AudioPlayer audioPlayer = AudioPlayer();

  final String appTitle = "Coda Music";
  final String poster   = "images/montero.jpg";

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState((){
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState((){
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState((){
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          centerTitle: true,
        ),
        body:  SingleChildScrollView(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(poster,
                        fit: BoxFit.cover,
                      )
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Call me by your name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Lil nax X",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Slider(
                        min: 0,
                        max: 100,
                        value: 20,
                        onChanged: (newValue) async{
                          final position = Duration(seconds: newValue.toInt());
                          await audioPlayer.seek(position);

                          await audioPlayer.resume();
                        }
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("02:38"),
                        Text("03:05"),
                      ],
                    ),
                    CircleAvatar(
                      radius: 35,
                      child: IconButton(
                        icon: Icon(
                            isPlaying ? Icons.play_circle_outline_sharp : Icons.play_arrow
                        ),
                        iconSize: 50,
                        onPressed: () async {
                          const String musicUrl = "https://codabee.com/wp-content/uploads/2018/06/un.mp3";
                          if(isPlaying){
                            await audioPlayer.pause();
                          }else{
                            await audioPlayer.play(musicUrl);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}


