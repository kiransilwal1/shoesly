import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:shoesly/core/common/theme/app_theme.dart';

class MusicPlayer extends StatelessWidget {
  MusicPlayer({super.key});
  String title = 'Jubilant Day (Upbeat Lo-fi Hip Hop Mix)';
  String artist = 'Normandy Beach Party';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.canvasPlinko,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleAndOnline(),
              const SizedBox(
                height: 16,
              ),
              BackButton(size: size),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: AppTheme.body600.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                artist,
                style: AppTheme.body200
                    .copyWith(color: Colors.white.withOpacity(0.6)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 0.6 * size.height,
                decoration: const BoxDecoration(
                    color: Color(0xFF342E33),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
              const SizedBox(
                height: 16,
              ),
              PlayerButtons(size: size),
              const SizedBox(
                height: 32,
              ),
              VolumeControl(currentVolume: 0.5)
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerButtons extends StatefulWidget {
  const PlayerButtons({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _PlayerButtonsState createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool _isPlaying = false;
  double _amplitude = 0.0;
  StreamSubscription? _audioPlayerSubscription;

  @override
  void dispose() {
    _audioPlayer.dispose();
    _audioPlayerSubscription?.cancel();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _audioPlayerSubscription?.cancel();
    } else {
      await _audioPlayer.play(AssetSource('mymusic.mp3'));
      _startAmplitudeMonitoring();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _startAmplitudeMonitoring() {
    _audioPlayerSubscription =
        _audioPlayer.onPositionChanged.listen((Duration position) async {
      final result = await _flutterFFmpeg.executeWithArguments([
        '-i',
        '/Users/kiransilwal/StudioProjects/shoesly/assets/mymusic.mp3', // Specify the correct path to the audio file
        '-af',
        'volumedetect',
        '-f',
        'null',
        '-'
      ]);

      if (result == 0) {
        // Example parsing logic
        String output = await _flutterFFmpeg.toString();
        RegExp regExp = RegExp(r'max_volume: (-?\d+\.\d+) dB');
        RegExpMatch? match = regExp.firstMatch(output);
        if (match != null) {
          double maxVolume = double.parse(match.group(1)!);
          setState(() {
            _amplitude = pow(10, maxVolume / 20) as double;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: widget.size.width / 4,
              decoration: const BoxDecoration(
                color: Color(0xFF342E33),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: const Icon(
                Icons.fast_rewind,
                size: 40,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                height: 60,
                width: widget.size.width / 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF342E33),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 60,
              width: widget.size.width / 4,
              decoration: const BoxDecoration(
                color: Color(0xFF342E33),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Icon(
                Icons.fast_forward,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text('Amplitude: $_amplitude'),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: size.width,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 1, color: AppTheme.plinko200)],
        color: Color(0xFF884987),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
          child: Text(
        'Back to Plinko',
        style: AppTheme.headline500
            .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
      )),
    );
  }
}

class TitleAndOnline extends StatelessWidget {
  const TitleAndOnline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Music',
          style: AppTheme.headline400.copyWith(color: Colors.white),
        ),
        Row(
          children: [
            Text(
              '237',
              style: AppTheme.body400.copyWith(color: Colors.white),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Online',
              style: AppTheme.body200
                  .copyWith(color: Colors.white.withOpacity(0.6)),
            )
          ],
        )
      ],
    );
  }
}

class VolumeControl extends StatelessWidget {
  final double currentVolume; // Current volume level (0.0 to 1.0)
  final double barHeight = 10;
  final Color backgroundColor = Color(0xFF342E33);
  final Color volumeColor = AppTheme.plinko200;

  VolumeControl({required this.currentVolume});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.volume_mute,
            color: Colors.white.withOpacity(0.6),
          ),
          Stack(
            children: [
              Container(
                height: barHeight,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              Container(
                height: barHeight,
                width: (size.width * 0.5) * currentVolume,
                decoration: BoxDecoration(
                  color: volumeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    topRight: currentVolume == 1.0
                        ? Radius.circular(16)
                        : Radius.zero,
                    bottomRight: currentVolume == 1.0
                        ? Radius.circular(16)
                        : Radius.zero,
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.volume_up,
            color: Colors.white.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
