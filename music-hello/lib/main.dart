import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ... (Rest of your code)

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  String? _selectedFilePath;

  // ... (Other methods)

  Future<void> _pickFile() async {
    try {
      String? path = await FilePicker.platform
          .pickFiles(
            type: FileType.audio,
            allowMultiple: false,
          )
          .then((value) => value.files.single.path);

      if (path != null) {
        setState(() {
          _selectedFilePath = path;
          _audioPlayer.play(_selectedFilePath!);
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... (Other UI elements)

            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Choose Music'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_isPlaying) {
                  await _audioPlayer.pause();
                } else {
                  if (_selectedFilePath != null) {
                    await _audioPlayer.play(_selectedFilePath!);
                  }
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              child: Icon(
                _isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
