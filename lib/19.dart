import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const HealthcareFinanceApp());
}

class HealthcareFinanceApp extends StatelessWidget {
  const HealthcareFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          elevation: 4,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black87),
        ),
      ),
      home: const FinanceHomeScreen(),
    );
  }
}

class FinanceHomeScreen extends StatefulWidget {
  const FinanceHomeScreen({super.key});

  @override
  _FinanceHomeScreenState createState() => _FinanceHomeScreenState();
}

class _FinanceHomeScreenState extends State<FinanceHomeScreen> {
  final List<FinanceStrategy> _strategies = const [
    FinanceStrategy(
      title: 'Use Health Savings Account (HSA)',
      description: 'Contribute pre-tax dollars to an HSA for medical expenses.',
      details: 'Max contribution: \$3,850 (individual) or \$7,750 (family) in 2025. Tax-free withdrawals for qualified costs.',
      emoji: '💰',
    ),
    FinanceStrategy(
      title: 'Opt for Generic Medications',
      description: 'Save by choosing generics over brand-name drugs.',
      details: 'Generics can cost 80-85% less. Ask your doctor or pharmacist.',
      emoji: '💊',
    ),
    FinanceStrategy(
      title: 'Preventive Care Focus',
      description: 'Invest in free or low-cost preventive screenings.',
      details: 'Covered by most insurance (e.g., annual check-ups, vaccines). Reduces future costs.',
      emoji: '🩺',
    ),
    FinanceStrategy(
      title: 'Shop Around for Tests',
      description: 'Compare prices for lab tests and imaging.',
      details: 'Use apps or call labs. Prices vary widely (e.g., MRI: \$300-\$1,200).',
      emoji: '🔍',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Finance Manager 💸'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Manage Your Healthcare Finances',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              ..._strategies.map((strategy) => _StrategyCard(strategy: strategy)),
              const SizedBox(height: 24),
              const Text(
                'Ask kenko finance manager 🤖',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatbotScreen()),
                  );
                },
                icon: const Icon(Icons.chat),
                label: const Text('Ask a Question'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StrategyCard extends StatelessWidget {
  final FinanceStrategy strategy;

  const _StrategyCard({required this.strategy});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Text(strategy.emoji, style: const TextStyle(fontSize: 30)),
        title: Text(strategy.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(strategy.description),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(strategy.details, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class FinanceStrategy {
  final String title;
  final String description;
  final String details;
  final String emoji;

  const FinanceStrategy({
    required this.title,
    required this.description,
    required this.details,
    required this.emoji,
  });
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyA7Z_b1EuJkikrTbkmNbeD5aGFcbcL5ek8', // Replace with your full API key (e.g., AIzaSyCPgqN8lM...)
    );
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': _controller.text});
    });

    try {
      final content = [Content.text(_controller.text)];
      final response = await _model.generateContent(content);
      setState(() {
        _messages.add({'role': 'bot', 'text': response.text ?? 'No response'});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'text': 'Error: $e'});
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('kenko finance assistant Chatbot 🤖'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['role'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(color: isUser ? Colors.blue.shade900 : Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about earnings, savings, etc. (e.g., "I earn \$50k, how much can I save?")',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}