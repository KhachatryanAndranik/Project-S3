import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:library_app/core.dart';
import 'package:library_app/shared.dart';

class PythonDataScraper implements DataScraper {
  const PythonDataScraper({required JsonStringConverter jsonStringConverter})
    : _jsonStringConverter = jsonStringConverter;

  final JsonStringConverter _jsonStringConverter;

  @override
  Future<T> scrapeData<T>(String source) async {
    final scriptBytes = await rootBundle.load('assets/scrape.py');
    final scriptStr = utf8.decode(scriptBytes.buffer.asUint8List());

    final tmpDir = await Directory.systemTemp.createTemp('py-scrape-');
    final scriptFile = File('${tmpDir.path}/scrape.py');
    await Process.run('chmod', ['+x', scriptFile.path]);
    await scriptFile.writeAsString(scriptStr);

    final result = await Process.run('python', [scriptFile.path, source]);

    await tmpDir.delete(recursive: true);

    if (result.exitCode != 0) {
      throw Exception('Python error: ${result.stderr}');
    }

    return _jsonStringConverter.fromJsonString<T>(result.stdout.toString());
  }
}
