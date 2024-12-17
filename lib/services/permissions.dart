import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

class ModularPermissionManager {
  ModularPermissionManager._privateConstructor(); 
  //Request permission based on the mobile version and these permissions help us to download file 
  //There is two methods for download file one for web and one for mobile 
  static final ModularPermissionManager _instance =
      ModularPermissionManager._privateConstructor();

  factory ModularPermissionManager() {
    return _instance;
  }

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Request storage permission
  Future<bool> requestStoragePermission() async {
    final androidInfo = await _deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt < 33) {
      final status = await Permission.storage.request();
      return status.isGranted;
    } else {
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
  }

  /// Download movie on mobile
  Future<void> downloadMovieMobile({
    required BuildContext context,
    required String name,
  }) async {
    final storageGranted = await requestStoragePermission();

    if (storageGranted) {
      try {
        final directory = await getDownloadsDirectory();
        if (directory != null) {
          final filePath = join(directory.path, 'CityName.txt');

          ///sotrage/0/android/data/example.movie_app/files/downloads/movieT.txt
          // print(directory.path);
          final file = File(filePath);
          await file.writeAsString(name);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  ' $name  downloaded successfully to $filePath'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download movie: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission denied. Cannot download the movie.'),
        ),
      );
    }
  }

  /// Download movie on web
  Future<void> downloadMovieWeb(String name) async {
    try {
      final bytes = utf8.encode(name);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'CityWeather.txt';

      anchor.click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      throw Exception('Failed to download movie: $e');
    }
  }

  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  /// Request microphone permission
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> requestAllPermissions() async {
    final storageGranted = await requestStoragePermission();
    final locationGranted = await requestLocationPermission();
    final microphoneGranted = await requestMicrophonePermission();

    return storageGranted && locationGranted && microphoneGranted;
  }

  /// Unified download method
  Future<void> downloadMovie({
    required BuildContext context,
    required String name,
  }) async {
    if (kIsWeb) {
      await downloadMovieWeb(name);
    } else {
      await downloadMovieMobile(
          context: context,
          name: name);
    }
  }
}
