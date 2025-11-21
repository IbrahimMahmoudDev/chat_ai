import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final String apiKey;

  ChatRepoImpl(this.apiKey);

  @override
  Stream<String> grokStream(String message) async* {
    final url = Uri.parse('https://api.x.ai/v1/chat/completions');

    var request = http.Request('POST', url);
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    request.body = jsonEncode({
      "messages": [
        {"role": "system", "content": "أنت مساعد ذكي وودود."},
        {"role": "user", "content": message}
      ],
      "model": "grok-4",
      "stream": true
    });

    var response = await request.send();

    await for (var chunk in response.stream.transform(utf8.decoder)) {
      for (var line in chunk.split('\n')) {
        if (line.startsWith('data: ') && !line.contains('[DONE]')) {
          try {
            var json = jsonDecode(line.substring(6));
            var delta = json['choices'][0]['delta']['content'] ?? '';
            if (delta.isNotEmpty) yield delta;
          } catch (_) {}
        }
      }
    }
  }
}
