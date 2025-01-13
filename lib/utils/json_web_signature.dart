// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:crypto/crypto.dart';

class JsonWebSignatureEncoder extends Converter<List<int>, String> {
  const JsonWebSignatureEncoder();
  @override
  String convert(List<int> input, {Map? header, String? secret}) {
    final msg =
        '${base64Url.encode(jsonEncode(header).codeUnits)}.${base64Url.encode(input)}';
    return '$msg.${_signMessage(msg, secret!)}';
  }
}

class JsonWebSignatureDecoder extends Converter<String, List<int>> {
  const JsonWebSignatureDecoder();

  bool isValid(String input, String secret) {
    final parts = input.split('.'),
        header = parts[0],
        payload = parts[1],
        signature = parts[2];

    return _verifyParts(header, payload, signature, secret);
  }

  bool _verifyParts(
      String header, String payload, String signature, String secret) {
    return signature == _signMessage('$header.$payload', secret);
  }

  @override
  List<int> convert(String input, {String? secret}) {
    final parts = input.split('.'),
        header = parts[0],
        payload = parts[1],
        signature = parts[2];

    if (_verifyParts(header, payload, signature, secret!)) {
      return base64Url.decode(payload);
    } else {
      throw ArgumentError('Invalid signature');
    }
  }
}

class JsonWebSignatureCodec extends Codec<List<int>, String> {
  final Map? _header;
  final String? _secret;

  const JsonWebSignatureCodec({Map? header, String? secret})
      : _header = header,
        _secret = secret;

  @override
  JsonWebSignatureEncoder get encoder => const JsonWebSignatureEncoder();

  @override
  JsonWebSignatureDecoder get decoder => const JsonWebSignatureDecoder();

  @override
  String encode(List<int> input, {Map? header, String? secret}) {
    return encoder.convert(input,
        header: (header ?? _header), secret: (secret ?? _secret));
  }

  @override
  List<int> decode(String encoded, {String? secret}) {
    return decoder.convert(encoded, secret: (secret ?? _secret));
  }

  bool isValid(String input, {String? secret}) {
    return decoder.isValid(input, secret!);
  }
}

String _signMessage(String msg, String secret) {
  var hmac = Hmac(sha256, secret.codeUnits);
  var digest = hmac.convert(msg.codeUnits);
  return base64Url.encode(digest.bytes);
}
