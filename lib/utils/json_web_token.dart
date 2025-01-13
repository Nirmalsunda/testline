library json_web_token;

// Dart imports:
import 'dart:convert';

// Project imports:
import 'json_web_signature.dart';

class JsonWebTokenEncoder extends Converter<Map, String> {
  static const jwsEncoder = JsonWebSignatureEncoder();

  const JsonWebTokenEncoder();
  @override
  String convert(Map input, {Map? header, String? secret}) {
    return jwsEncoder.convert(jsonEncode(input).codeUnits,
        header: header, secret: secret);
  }
}

class JsonWebTokenDecoder extends Converter<String, Map> {
  static const jwsDecoder = JsonWebSignatureDecoder();

  const JsonWebTokenDecoder();

  bool isValid(String input, String secret) =>
      jwsDecoder.isValid(input, secret);

  @override
  Map convert(String input, {Map? header, String? secret}) {
    // return JSON.decode(new String.fromCharCodes(jwsDecoder.convert(token, secret: secret)));
    return jsonDecode(
        String.fromCharCodes(jwsDecoder.convert(input, secret: secret)));
  }
}

class JsonWebTokenCodec extends Codec<Map, String> {
  static const defaultHeader = {'typ': 'JWT', 'alg': 'HS256'};

  final Map? _header;
  final String? _secret;

  const JsonWebTokenCodec({Map? header, String? secret})
      : _header = header ?? defaultHeader,
        _secret = secret;

  @override
  JsonWebTokenEncoder get encoder => const JsonWebTokenEncoder();

  @override
  JsonWebTokenDecoder get decoder => const JsonWebTokenDecoder();

  @override
  String encode(Map input, {Map? header, String? secret}) {
    return encoder.convert(input,
        header: (header ?? _header), secret: (secret ?? _secret));
  }

  @override
  Map decode(String encoded, {String? secret}) {
    return decoder.convert(encoded, secret: (secret ?? _secret));
  }

  bool isValid(String input, {String? secret}) {
    return decoder.isValid(input, secret!);
  }
}
