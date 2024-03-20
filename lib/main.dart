import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const SongPlayerApp());
}

class SongPlayerApp extends StatefulWidget {
  const SongPlayerApp({super.key});

  @override
  _SongPlayerAppState createState() => _SongPlayerAppState();
}

class _SongPlayerAppState extends State<SongPlayerApp> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  Future<void> playSong(path) async {
    await audioPlayer.play(AssetSource(path));
  }

  Future<void> resumeSong() async {
    await audioPlayer.resume();
  }

  Future<void> pauseSong() async {
    await audioPlayer.pause();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sound Player',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.separated(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: Text(names[index]),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/$index.jpg'),
                ),
                trailing: const Text('الإخلاص❤'),
                onTap: () async {
                  await playSong('sounds/elekhlas$index.mp3');
                },
              ),
            );
          },
          separatorBuilder: (context, index){
            return Container(
              color: Theme.of(context).primaryColor,
              height: 1,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 40),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: pauseSong,
                tooltip: 'pause',
                child: const Icon(Icons.pause),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: resumeSong,
                tooltip: 'resume',
                child: const Icon(Icons.video_library_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> names = [
  'الشيخ مشاري العفاسي',
  'الشيخ ياسر الدوسري',
  'الشيخ خالد الجليل',
  'الشيخ ناصر القطامي',
  'الشيخ حسن صالح',
];
