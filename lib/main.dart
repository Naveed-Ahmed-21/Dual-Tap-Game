import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main(){
  runApp(MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatelessWidget{
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         Container(
           color: Colors.blueAccent,
           height: MediaQuery.of(context).size.height/2,
           width: double.infinity,
           child: Center(
             child: MaterialButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>GamePage()));
             },
               color: Colors.white,
               shape: CircleBorder(),
               height: 150,
               minWidth: 150,
               child: Text('Start'),
             ),
           )
         ),
         Container(
           color: Colors.redAccent,
           height: MediaQuery.of(context).size.height/2,
           width: double.infinity,
           child: Center(
             child: MaterialButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>GamePage()));
             },
               color: Colors.white,
               shape: CircleBorder(),
               height: 150,
               minWidth: 150,
               child: Text('Start'),
               ),
             ),
           )
       ],
     ),
    );
  }
}

class GamePage extends StatefulWidget{
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double bluesize = 0;
  double redsize = 0;
  bool init = false;
  int scoreplayerA = 0;
  int scoreplayerB = 0;
  late AudioPlayer tapPlayer;
  late AudioPlayer victoryPlayer;

  @override
  void initState() {
    super.initState();
    tapPlayer = AudioPlayer();
    victoryPlayer = AudioPlayer();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    try {
      // Configure tap player for rapid-fire sounds
      await tapPlayer.setReleaseMode(ReleaseMode.stop);
      await tapPlayer.setVolume(0.8);
      
      // Configure victory player
      await victoryPlayer.setReleaseMode(ReleaseMode.stop);
      await victoryPlayer.setVolume(1.0);
      
      // Warm up audio system by preloading
      await tapPlayer.play(AssetSource('audio/tap.mp3'));
      await Future.delayed(Duration(milliseconds: 100));
      await tapPlayer.stop();
    } catch (e) {
      // Silently fail if audio files don't exist
      print('Audio setup failed: $e');
    }
  }

  @override
  void dispose() {
    tapPlayer.dispose();
    victoryPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (init == false) {
      bluesize = MediaQuery.of(context).size.height / 2;
      redsize = MediaQuery.of(context).size.height / 2;
      init = true;
    }
    return Scaffold(
      body: Column(
        children: [
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // Play tap sound immediately without await
              tapPlayer.play(AssetSource('audio/tap.mp3')).catchError((_) {});
              
              setState(() {
                bluesize = bluesize + 30;
                redsize = redsize - 30;
              });
              scoreplayerB = scoreplayerB + 5;

              double winsize=MediaQuery.of(context).size.height-80;
              if(bluesize>winsize){
                print("Player B wins");
                victoryPlayer.play(AssetSource('audio/victory.mp3')).catchError((_) {});
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultPage(scoreplayerB,"Player B Wins")));
              }
            },
            child: Container(
              color: Colors.blueAccent,
              height: bluesize,
              width: double.infinity,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child:
                  Text('Player B',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)
                  )
                  ),
                  Text(scoreplayerB.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // Play tap sound immediately without await
              tapPlayer.play(AssetSource('audio/tap.mp3')).catchError((_) {});
              
              setState(() {
                redsize = redsize + 30;
                bluesize = bluesize - 30;
              });
              scoreplayerA = scoreplayerA + 5;

              double winsize=MediaQuery.of(context).size.height-80;
              print(redsize);
              print(winsize);

              if(redsize>winsize){
                print("Player A Wins");
                victoryPlayer.play(AssetSource('audio/victory.mp3')).catchError((_) {});
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultPage(scoreplayerA,"Player A Wins")));
              }
            },
            child: Container(
              color: Colors.redAccent,
              height: redsize,
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child:
                  Text('Player A',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)
                  )
                  ),
                  Text(scoreplayerA.toString(),
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



class ResultPage extends StatelessWidget{
  int score=0;
  String player="";
  ResultPage(this.score,this.player, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: player=="Player A Wins"?Colors.redAccent:Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(player,
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),
            ),
            Text(score.toString()),
            MaterialButton(onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
              color: Colors.white,
              child: Text('Restart'),
            )
          ]
        ),
      ),
    );
  }
}

