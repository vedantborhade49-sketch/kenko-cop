import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey =
    "AIzaSyD6qQvrTuEWK6RQa3Fy_ikV6Ws8X9o-mDc"; // Replace with your API key
const String endpoint =
    "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateText";

Future<void> fetchGeminiResponse(String prompt) async {
  final Uri url = Uri.parse("$endpoint?key=$apiKey");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "prompt": {"text": prompt},
    }),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print("Gemini Response: ${responseData['candidates'][0]['output']}");
  } else {
    print("Error: ${response.body}");
  }
}

void main() async {
  String userPrompt = "What are the benefits of AI in healthcare?";
  await fetchGeminiResponse(userPrompt);
}
