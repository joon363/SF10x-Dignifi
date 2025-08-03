import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';


Future<String?> callAPI(String message) async {
  final url = Uri.parse(SERVER_ADDR);
  // await Future.delayed(Duration(seconds: 1));
  // return dummyResponse;
  final payload = {
    "input_value": message,
    "output_type": "chat",
    "input_type": "chat"
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['outputs']?[0]?['outputs']?[0]?['results']?['message']?['text'];
      return text;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

String dummyResponse = '''hello# Exploring the Future of AI: A GPT Perspective

Artificial Intelligence (AI) has rapidly transformed various industries, reshaping how we work, communicate, and solve problems. Among the many breakthroughs, **Generative Pre-trained Transformers (GPT)** stand out as a remarkable advancement.

## What is GPT?

GPT is a type of large language model developed by OpenAI that leverages deep learning to generate human-like text. By training on vast amounts of data, GPT can:

- Compose essays and articles
- Answer questions intelligently
- Generate creative content like poetry and stories
- Assist with coding and debugging

## Applications of GPT

The versatility of GPT opens up exciting possibilities across domains:

1. **Education**: Personalized tutoring and instant feedback
2. **Healthcare**: Assisting in medical documentation and research summarization
3. **Entertainment**: Interactive storytelling and game dialogue generation
4. **Business**: Automated customer support and report generation

## Challenges and Ethical Considerations

While GPT models are powerful, they also raise important questions:

- How do we ensure responsible use?
- What about biases in training data?
- How to balance automation with human creativity?

## Conclusion

GPT and similar AI models are ushering in a new era of intelligent tools. As technology evolves, fostering ethical development and inclusive design will be key to unlocking their full potential.

---

*Powered by GPT technology — shaping the future, one word at a time.*
''';