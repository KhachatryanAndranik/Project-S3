import 'dart:convert';

import 'package:library_app/shared/converters/custom_json_decoder.dart';

class JsonStringConverter {
  JsonStringConverter({required CustomJsonDecoder jsonDecoder})
    : _jsonDecoder = jsonDecoder;

  final CustomJsonDecoder _jsonDecoder;

  String toJsonString<T>(T value) => jsonEncode(value);

  T fromJsonString<T>(dynamic value) {
    if (value is! String) {
      return _jsonDecoder.decode<T>(value);
    }

    return _jsonDecoder.decode<T>(jsonDecode(value));
  }
}
