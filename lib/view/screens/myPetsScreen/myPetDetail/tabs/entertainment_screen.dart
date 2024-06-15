import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// class EntertainmentScreen extends StatefulWidget {
//   const EntertainmentScreen({super.key});
//
//   @override
//   _EntertainmentScreenState createState() => _EntertainmentScreenState();
// }
//
// class _EntertainmentScreenState extends State<EntertainmentScreen> {
//   late AudioPlayer _audioPlayer;
//   bool _isPlaying = false;
//   int _currentMusicIndex = 0;
//   final List<String> _musicAssets = [
//     'music/funny-dancing-kids-158822.mp3',
//     'music/holiday-at-the-zoo-207450.mp3',
//     'music/leva-serene-and-gentle-181125.mp3',
//     'music/lo-fi-150946.mp3',
//     'music/sunshine-108600.mp3',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _audioPlayer.dispose();
//   }
//
//   Future _playMusic() async {
//    await _audioPlayer.play(AssetSource(_musicAssets[_currentMusicIndex]));
//    _isPlaying = true;
//    setState(() {
//
//    });
//     // if (result == 1) {
//     //   setState(() {
//     //
//     //   });
//     // }
//   }
//
//   Future<void> _pauseMusic() async {
//     await _audioPlayer.pause();
//     setState(() {
//       _isPlaying = false;
//     });
//     // if (result == 1) {
//     //
//     // }
//   }
//
//   Future<void> _toggleMusic() async {
//     if (_isPlaying) {
//       await _pauseMusic();
//     } else {
//       await _playMusic();
//     }
//   }
//
//   void _nextMusic() {
//     setState(() {
//       _currentMusicIndex = (_currentMusicIndex + 1) % _musicAssets.length;
//       if (_isPlaying) {
//         _playMusic();
//       }
//     });
//   }
//
//   void _previousMusic() {
//     setState(() {
//       _currentMusicIndex = (_currentMusicIndex - 1 + _musicAssets.length) % _musicAssets.length;
//       if (_isPlaying) {
//         _playMusic();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: Icon(Icons.skip_previous),
//               iconSize: 48,
//               onPressed: _previousMusic,
//             ),
//             SizedBox(width: 10),
//             _isPlaying
//                 ? IconButton(
//               icon: Icon(Icons.pause,color: Colors.green,),
//               iconSize: 48,
//               onPressed: _toggleMusic,
//             )
//                 : IconButton(
//               icon: Icon(Icons.play_arrow),
//               iconSize: 48,
//               onPressed: _toggleMusic,
//             ),
//             SizedBox(width: 10),
//             IconButton(
//               icon: Icon(Icons.skip_next),
//               iconSize: 48,
//               onPressed: _nextMusic,
//             ),
//           ],
//         ),
//             SizedBox(height: 20),
//             Text(
//               'Music ${_currentMusicIndex + 1} out of ${_musicAssets.length}',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///
class EntertainmentScreen extends StatefulWidget {
  const EntertainmentScreen({Key? key});

  @override
  _EntertainmentScreenState createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  late int _currentMusicIndex;
  final List<String> _musicAssets = [
    'music/funny-dancing-kids-158822.mp3',
    'music/holiday-at-the-zoo-207450.mp3',
    'music/leva-serene-and-gentle-181125.mp3',
    'music/lo-fi-150946.mp3',
    'music/sunshine-108600.mp3',
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentMusicIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  Future<void> _playMusic(int index) async {
    await _audioPlayer.play(AssetSource(_musicAssets[index]));
    setState(() {
      _isPlaying = true;
      _currentMusicIndex = index;
    });
  }

  Future<void> _pauseMusic() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _toggleMusic() async {
    if (_isPlaying) {
      await _pauseMusic();
    } else {
      await _playMusic(_currentMusicIndex);
    }
  }

  void _nextMusic() {
    setState(() {
      _currentMusicIndex = (_currentMusicIndex + 1) % _musicAssets.length;
      if (_isPlaying) {
        _playMusic(_currentMusicIndex);
      }
    });
  }

  void _previousMusic() {
    setState(() {
      _currentMusicIndex = (_currentMusicIndex - 1 + _musicAssets.length) % _musicAssets.length;
      if (_isPlaying) {
        _playMusic(_currentMusicIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _musicAssets.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  color: _currentMusicIndex == index ? Colors.green.withOpacity(0.3) : null,
                  child: ListTile(
                    title: Text('Music ${index + 1}'),
                    trailing: _isPlaying && _currentMusicIndex == index
                        ? IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: _pauseMusic,
                    )
                        : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () => _playMusic(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 48,
                  onPressed: _previousMusic,
                ),
                IconButton(
                  icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  iconSize: 48,
                  onPressed: _toggleMusic,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 48,
                  onPressed: _nextMusic,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





