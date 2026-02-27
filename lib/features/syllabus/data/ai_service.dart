import 'package:google_generative_ai/google_generative_ai.dart';

class AiService {
  final String _apiKey = 'AIzaSyDmBfljrs2u9btl-ajn1qlvAg3Zf-iHtuk';

  Future<String> generateSyllabus(String topic) async {
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(
        "You are an AI syllabus generator. "
        "Respond ONLY in valid JSON format.",
      ),
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    final prompt =
        """
Generate a detailed syllabus for "$topic".

Return JSON in this structure:

{
  "title": "string",
  "modules": [
    {
      "module_number": number,
      "module_title": "string",
      "topics": ["string"],
      "learning_outcomes": ["string"]
    }
  ]
}
""";

    final response = await model.generateContent([Content.text(prompt)]);

    if (response.text == null) {
      throw Exception("AI returned null response");
    }

    return response.text!;
  }
}
