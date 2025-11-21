import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final String apiKey;

  ChatRepoImpl(this.apiKey);

  @override
  Stream<String> grokStream(String message) async* {
    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
    print("Sending message to Groq API: $message");
    var request = http.Request('POST', url);
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    request.body = jsonEncode({
      "model": "groq/compound-mini",
      "messages": [
        {"role": "system", "content": "أنت مساعد ذكي وودود يرد بالعربية الفصحى أو العامية حسب الطلب."},
        {"role": "user", "content": message}
      ],
      "stream": true,
      "temperature": 0.7
    });

    var response = await request.send();
    print("Request sent, waiting for stream...");

    await for (var chunk in response.stream.transform(utf8.decoder)) {
      print("Chunk received: $chunk");
      for (var line in chunk.split('\n')) {
        if (line.startsWith('data: ') && !line.contains('[DONE]')) {
          try {
            var data = jsonDecode(line.substring(6));
            final text = data['choices'][0]['delta']?['content'] ?? '';
            if (text.isNotEmpty){
              print("Delta received: $text");
              yield text;
            }
          } catch (e) {
            print("Error decoding chunk: $e");
          }
        }
      }
    }
  print("Stream ended");
  }
}
