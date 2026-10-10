import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

const tapSoundAsset = 'audio/notification-alert-sound.mp3';
const victorySoundAsset = 'audio/victory.mp3';

void main() {
  runApp(const TapGameApp());
}

class TapGameApp extends StatelessWidget {
  const TapGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xfff5b84b),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff101317),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'DUAL TAP',
                style: TextStyle(
                  color: Color(0xfff5b84b),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tap your way\nto the top.',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  height: 0.98,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Two players. One finish line.\nThe faster side wins.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.62),
                  fontSize: 17,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GamePage()),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start game'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xfff5b84b),
                    foregroundColor: const Color(0xff19140b),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'PLAYER B  •  TOP     PLAYER A  •  BOTTOM',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double blueProgress = 0.5;
  int scorePlayerA = 0;
  int scorePlayerB = 0;
  bool roundOver = false;
  final AudioPlayer tapPlayer = AudioPlayer();
  final AudioPlayer victoryPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    tapPlayer.setReleaseMode(ReleaseMode.stop);
    tapPlayer.setVolume(0.8);
    victoryPlayer.setReleaseMode(ReleaseMode.stop);
    victoryPlayer.setVolume(1);
  }

  void _tap(bool isPlayerA) {
    if (roundOver) return;

    tapPlayer.play(AssetSource(tapSoundAsset));
    setState(() {
      if (isPlayerA) {
        blueProgress = (blueProgress - 0.04).clamp(0.08, 0.92);
        scorePlayerA += 5;
      } else {
        blueProgress = (blueProgress + 0.04).clamp(0.08, 0.92);
        scorePlayerB += 5;
      }
    });

    final playerAWon = blueProgress <= 0.08;
    final playerBWon = blueProgress >= 0.92;
    if (playerAWon || playerBWon) {
      roundOver = true;
      final winner = playerAWon ? 'Player A' : 'Player B';
      final score = playerAWon ? scorePlayerA : scorePlayerB;
      victoryPlayer.play(AssetSource(victorySoundAsset));
      Future<void>.delayed(const Duration(milliseconds: 260), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(score: score, player: winner),
          ),
        );
      });
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: (blueProgress * 100).round(),
              child: _PlayerPanel(
                label: 'PLAYER B',
                score: scorePlayerB,
                color: const Color(0xff3c7eff),
                alignment: Alignment.topLeft,
                onTap: () => _tap(false),
              ),
            ),
            Container(height: 1, color: Colors.white24),
            Expanded(
              flex: ((1 - blueProgress) * 100).round(),
              child: _PlayerPanel(
                label: 'PLAYER A',
                score: scorePlayerA,
                color: const Color(0xffef625d),
                alignment: Alignment.bottomLeft,
                onTap: () => _tap(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerPanel extends StatelessWidget {
  const _PlayerPanel({
    required this.label,
    required this.score,
    required this.color,
    required this.alignment,
    required this.onTap,
  });

  final String label;
  final int score;
  final Color color;
  final Alignment alignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Align(
            alignment: alignment,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Text(
                  '$score',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({required this.score, required this.player, super.key});

  final int score;
  final String player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: player == 'Player A'
          ? const Color(0xffef625d)
          : const Color(0xff3c7eff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'WINNER',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              player,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text('$score points', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GamePage()),
              ),
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Play again'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
