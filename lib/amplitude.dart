import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session.dart';

class AudioAmplitude extends StatefulWidget {
  @override
  _AudioAmplitudeState createState() => _AudioAmplitudeState();
}

class _AudioAmplitudeState extends State<AudioAmplitude> {
  Future<void> getAmplitude(String filePath, int intervalInSeconds) async {
    // The FFmpeg command to extract audio amplitude at specified intervals
    String command = '-i $filePath -filter:a "volumedetect" -f null -';

    // Execute the FFmpeg command
    FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      final output = await session.getOutput();

      if (ReturnCode.isSuccess(returnCode)) {
        // Success, parse the output to get the amplitude
        print('FFmpeg command executed successfully.');
        // Parse the `output` to find amplitude values
        print(output);
      } else if (ReturnCode.isCancel(returnCode)) {
        print('FFmpeg command cancelled.');
      } else {
        print('FFmpeg command failed with return code $returnCode.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Amplitude'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String audioFilePath = 'mymusic.mp3';
            int intervalInSeconds = 5;
            getAmplitude(audioFilePath, intervalInSeconds);
          },
          child: Text('Get Amplitude'),
        ),
      ),
    );
  }
}
