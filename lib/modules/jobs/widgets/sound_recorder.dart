import 'dart:io';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const pathToSaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
    throw RecordingPermissionException("Microphone Permission");
    }

    await _audioRecorder!.openAudioSession();
    }

  void dispose() {
    _audioRecorder!.closeAudioSession();
  }

  Future _record() async {
    var dir = (await getExternalStorageDirectory())?.path;
    var paths = "$dir/recorder.aac";
    print("pths -------$paths");
    await _audioRecorder!.startRecorder(toFile: paths);
    print("//////path////${paths}");
  }

  Future _stop() async {
    await _audioRecorder?.stopRecorder();
    var dir = (await getExternalStorageDirectory())?.path;
    var paths = "$dir/recorder.aac";
    File audiofile = File(paths);
    print("//////audiofile////?????${audiofile}");
    // await File.fromUri(Uri.file("assets/audio/music.mp3")).readAsBytes();

    // var url =
    //     Uri.parse("https://readymade4trade.omkatech.in/api/SendAppointment");

    // final request = http.MultipartRequest('POST', url)
    //   ..fields['user_id'] = "11"
    //   ..fields['customer_id'] = "32"
    //   ..files.add(http.MultipartFile.fromBytes('audio_file',
    //       await File(paths).readAsBytesSync(),

    //       //File.fromUri(Uri.file(audiofile.path)).readAsBytes()
    //       //await File.fromUri(

    //       //   Uri(path: "assets/audio/music.mp3",)
    //       // ).readAsBytes(),

    //       ));
    // request.headers["Content-Type"] = 'multipart/form-data';
    // final response = await request.send();
    // final responseStr = await response.stream.bytesToString();
    // print("//////////////////////////music p");
    // print(responseStr);

    // final file = File(filePath!);
    // print("Recorded file path///////////${file}");
  }

  Future<bool> delete() async {
    var dir = (await getExternalStorageDirectory())?.path;
    try {
      var paths = "$dir/recorder.aac";
      // print(isRecording);
      File file = File.fromUri(Uri.file(paths));
      var res = await file.delete();
      // await _audioRecorder!.deleteRecord(fileName: paths);
      print("/////delted paths///????/${res}");
      //  await file.delete();
      //ScaffoldMessenger.of(context).showSnackBar();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
