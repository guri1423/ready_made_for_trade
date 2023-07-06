import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

const pathToSaveAudio = 'audio_example.aac';

class SoundPlayer {
  FlutterSoundPlayer? _audoPlayer;

  bool get isPlaying => _audoPlayer!.isPlaying;

  Future init() async {
    _audoPlayer = FlutterSoundPlayer();
    await _audoPlayer!.openAudioSession();
  }

  Future dispose() async {
    _audoPlayer!.closeAudioSession();
    _audoPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    var dir = (await getExternalStorageDirectory())?.path;
    var paths = "$dir/recorder.aac";
    await _audoPlayer!.startPlayer(
      fromURI: paths,
      whenFinished: whenFinished,
    );
    print("///////path of recording///////${pathToSaveAudio}");
  }

  Future _stop() async {
    await _audoPlayer!.startPlayer();
  }
  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_audoPlayer!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}
