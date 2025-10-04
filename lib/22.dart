import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const AyurvedaApp());
}

class AyurvedaApp extends StatelessWidget {
  const AyurvedaApp({super.key});

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
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black87),
        ),
        buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
      ),
      home: const AyurvedaHomeScreen(),
    );
  }
}

class AyurvedaHomeScreen extends StatelessWidget {
  const AyurvedaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayurveda Wellness 🌿'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
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
              _buildIntroCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Explore Ayurveda'),
              const SizedBox(height: 16),
              _buildExploreTiles(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Take the Dosha Quiz'),
              const SizedBox(height: 16),
              _buildDoshaQuizButton(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Ask Ayurvedic Baba'),
              const SizedBox(height: 16),
              _buildAyurvedicBabaButton(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Learn More'),
              const SizedBox(height: 16),
              _buildLearnMoreCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Ayurveda Wellness 🌱',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Ayurveda, the "Science of Life," is a 5,000-year-old Indian system of medicine rooted in the Vedas. It emphasizes balance between mind, body, and spirit.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildExploreTiles(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildExploreTile(
            context, 'Remedies', '💊', Colors.red, const RemediesScreen()),
        _buildExploreTile(
            context, 'Principles', '📜', Colors.blue, const PrinciplesScreen()),
        _buildExploreTile(context, 'Daily Tips', '💡', Colors.orange,
            const DailyTipsScreen()),
        _buildExploreTile(context, 'About Ayurveda', 'ℹ️', Colors.green,
            const AboutAyurvedaScreen()),
      ],
    );
  }

  Widget _buildExploreTile(BuildContext context, String title, String emoji,
      Color color, Widget page) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: TextStyle(fontSize: 40, color: color)),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoshaQuizButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DoshaQuizScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'Start Quiz 📝',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAyurvedicBabaButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AyurvedicBabaScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'Ask Ayurvedic Baba 🧙',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLearnMoreCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Did You Know? 🌿',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Ayurveda uses over 1,200 medicinal plants! Common ones include Tulsi for immunity, Turmeric for inflammation, and Ashwagandha for stress relief.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class RemediesScreen extends StatelessWidget {
  const RemediesScreen({super.key});

  final List<Map<String, String>> remedies = const [
    {
      "illness": "Cold & Cough",
      "emoji": "🤧",
      "remedy":
          "Drink warm Tulsi tea with honey. Add ginger and black pepper. Benefits: Boosts immunity, clears congestion."
    },
    {
      "illness": "Fever",
      "emoji": "🌡️",
      "remedy":
          "Boil water with coriander seeds. Rest well. Benefits: Reduces heat, aids recovery."
    },
    {
      "illness": "Digestive Issues",
      "emoji": "🍽️",
      "remedy":
          "Take Triphala churna at night. Chew fennel seeds post-meal. Benefits: Improves digestion, reduces bloating."
    },
    {
      "illness": "Stress & Anxiety",
      "emoji": "😟",
      "remedy":
          "Practice Pranayama, take Ashwagandha with milk. Benefits: Calms mind, reduces cortisol."
    },
    {
      "illness": "Headache",
      "emoji": "🤕",
      "remedy":
          "Apply sandalwood paste on forehead. Drink ghee water. Benefits: Relieves pain, cools head."
    },
    {
      "illness": "Diabetes",
      "emoji": "💉",
      "remedy":
          "Drink bitter gourd juice daily. Use turmeric and amla. Benefits: Regulates blood sugar."
    },
    {
      "illness": "Joint Pain",
      "emoji": "🦴",
      "remedy":
          "Massage with sesame oil and turmeric. Take Guggulu. Benefits: Reduces inflammation, eases stiffness."
    },
    {
      "illness": "Insomnia",
      "emoji": "😴",
      "remedy":
          "Drink warm milk with nutmeg. Meditate. Benefits: Promotes sleep, relaxes nerves."
    },
    {
      "illness": "Skin Issues",
      "emoji": "🧴",
      "remedy":
          "Apply neem paste. Drink aloe vera juice. Benefits: Clears skin, detoxifies."
    },
    {
      "illness": "Hypertension",
      "emoji": "❤️",
      "remedy":
          "Take Arjuna powder with water. Reduce salt. Benefits: Lowers BP, strengthens heart."
    },
    {
      "illness": "Asthma",
      "emoji": "🌬️",
      "remedy":
          "Inhale steam with eucalyptus oil. Use licorice tea. Benefits: Opens airways, reduces wheezing."
    },
    {
      "illness": "Fatigue",
      "emoji": "😩",
      "remedy":
          "Eat dates soaked in ghee. Practice yoga. Benefits: Boosts energy, restores vitality."
    },
    {
      "illness": "Constipation",
      "emoji": "🚽",
      "remedy":
          "Drink warm lemon water. Take Isabgol. Benefits: Softens stool, aids bowel movement."
    },
    {
      "illness": "Sore Throat",
      "emoji": "🗣️",
      "remedy":
          "Gargle with saltwater and turmeric. Benefits: Soothes throat, fights infection."
    },
    {
      "illness": "Acidity",
      "emoji": "🔥",
      "remedy":
          "Drink cold milk with ghee. Avoid spicy food. Benefits: Neutralizes acid, cools stomach."
    },
    {
      "illness": "Hair Loss",
      "emoji": "💇",
      "remedy":
          "Massage scalp with coconut oil and amla. Benefits: Strengthens roots, promotes growth."
    },
    {
      "illness": "Allergies",
      "emoji": "🌸",
      "remedy":
          "Take nettle tea. Use black cumin seeds. Benefits: Reduces sensitivity, clears symptoms."
    },
    {
      "illness": "Low Immunity",
      "emoji": "🛡️",
      "remedy":
          "Drink giloy juice daily. Benefits: Enhances immunity, fights infections."
    },
    {
      "illness": "Menstrual Cramps",
      "emoji": "🌺",
      "remedy":
          "Drink cumin seed tea. Apply castor oil pack. Benefits: Eases pain, regulates flow."
    },
    {
      "illness": "Eye Strain",
      "emoji": "👁️",
      "remedy":
          "Wash eyes with Triphala water. Rest them. Benefits: Refreshes eyes, reduces fatigue."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayurveda Remedies 💊'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
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
                'Traditional Solutions',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: remedies.length,
                itemBuilder: (context, index) {
                  return _buildRemedyCard(
                    context,
                    remedies[index]['illness']!,
                    remedies[index]['emoji']!,
                    remedies[index]['remedy']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemedyCard(
      BuildContext context, String illness, String emoji, String remedy) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: () => _showRemedyDialog(context, illness, remedy),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 8),
              Text(
                illness,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRemedyDialog(BuildContext context, String illness, String remedy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$illness Remedy 🌿',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(remedy, style: const TextStyle(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

class PrinciplesScreen extends StatelessWidget {
  const PrinciplesScreen({super.key});

  final List<Map<String, String>> principles = const [
    {
      "title": "The Three Doshas",
      "description":
          "Vata (air & space), Pitta (fire & water), and Kapha (earth & water) govern health. Imbalances cause illness."
    },
    {
      "title": "Panchakarma",
      "description":
          "A five-step detox process (vomiting, purgation, enema, nasal therapy, bloodletting) to cleanse toxins."
    },
    {
      "title": "Dinacharya",
      "description":
          "Daily routines like waking early, oil pulling, and yoga to maintain balance."
    },
    {
      "title": "Ritucharya",
      "description":
          "Seasonal adjustments in diet and lifestyle to adapt to weather changes."
    },
    {
      "title": "Agni",
      "description":
          "Digestive fire essential for metabolism and health. Weak Agni leads to toxins (Ama)."
    },
    {
      "title": "Prakriti",
      "description":
          "Your unique constitution determined by dosha balance at birth."
    },
    {
      "title": "Ojas",
      "description":
          "Vital energy from balanced digestion, key to immunity and vitality."
    },
    {
      "title": "Sattva",
      "description":
          "Mental clarity and harmony achieved through a balanced lifestyle."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayurveda Principles 📜'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
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
                'Key Principles of Ayurveda',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Column(
                children: principles
                    .map((principle) => _buildPrincipleCard(principle))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrincipleCard(Map<String, String> principle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: ExpansionTile(
        title: Text(
          principle['title']!,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              principle['description']!,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class DailyTipsScreen extends StatelessWidget {
  const DailyTipsScreen({super.key});

  final List<Map<String, String>> dailyTips = const [
    {
      "category": "Morning",
      "tip": "Start with warm water and lemon to detoxify."
    },
    {
      "category": "Morning",
      "tip": "Practice 10 minutes of Pranayama for energy."
    },
    {"category": "Morning", "tip": "Massage with sesame oil before showering."},
    {
      "category": "Day",
      "tip": "Add turmeric to meals for anti-inflammatory benefits."
    },
    {"category": "Day", "tip": "Eat seasonal fruits for better digestion."},
    {
      "category": "Day",
      "tip": "Take a short walk after meals to aid digestion."
    },
    {
      "category": "Evening",
      "tip": "Drink warm herbal tea instead of cold drinks."
    },
    {"category": "Evening", "tip": "Meditate for 10 minutes to relax."},
    {"category": "Evening", "tip": "Avoid heavy meals close to bedtime."},
    {
      "category": "Anytime",
      "tip": "Chew fennel seeds post-meal for freshness."
    },
    {"category": "Anytime", "tip": "Use ghee in cooking for healthy fats."},
    {"category": "Anytime", "tip": "Avoid processed foods for better health."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Ayurveda Tips 💡'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
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
                'Daily Health Tips',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Column(
                children: dailyTips.map((tip) => _buildTipCard(tip)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(Map<String, String> tip) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text("🌟",
                style: TextStyle(fontSize: 24, color: Colors.blue)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "${tip['category']}: ${tip['tip']}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutAyurvedaScreen extends StatelessWidget {
  const AboutAyurvedaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Ayurveda ℹ️'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is Ayurveda?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 16),
              Text(
                'Ayurveda, originating 5,000 years ago in India, is a holistic healing system focusing on mind-body-spirit balance.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 24),
              Text(
                'History',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 8),
              Text(
                'Developed by ancient sages, Ayurveda’s principles are in texts like Charaka Samhita.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 24),
              Text(
                'Benefits',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 8),
              Text(
                'Improves digestion, boosts immunity, reduces stress, and promotes longevity.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AyurvedicBabaScreen extends StatefulWidget {
  const AyurvedicBabaScreen({super.key});

  @override
  State<AyurvedicBabaScreen> createState() => _AyurvedicBabaScreenState();
}

class _AyurvedicBabaScreenState extends State<AyurvedicBabaScreen> {
  final TextEditingController _questionController = TextEditingController();
  String _response = '';
  String _timestamp = '';
  bool _isLoading = false;
  String? _selectedExample;

  final List<String> _exampleQuestions = [
    'What is a remedy for headaches?',
    'How can I improve my digestion?',
    'What herbs help with stress?',
    'What is the best diet for Vata dosha?',
    'How do I balance Pitta naturally?',
  ];

  Future<void> _askAyurvedicBaba(String question) async {
    setState(() {
      _isLoading = true;
      _response = '';
      _timestamp = DateTime.now().toString().substring(0, 19);
    });

    const apiKey = 'AIzaSyA7Z_b1EuJkikrTbkmNbeD5aGFcbcL5ek8';
    const url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': apiKey,
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Act as an Ayurvedic expert. Answer this question: $question"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _response = data['candidates'][0]['content']['parts'][0]['text'] ??
              'No response found.';
        });
      } else {
        setState(() {
          _response =
              'Error: Could not fetch response (Status: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearInput() {
    setState(() {
      _questionController.clear();
      _response = '';
      _timestamp = '';
      _selectedExample = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents overflow when keyboard appears
      appBar: AppBar(
        title: const Text('Ayurvedic Baba 🧙'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
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
                'Ask Your Question',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  hintText: 'E.g., What is a remedy for headaches?',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedExample,
                hint: const Text('Try an example question'),
                items: _exampleQuestions.map((question) {
                  return DropdownMenuItem<String>(
                    value: question,
                    child: Text(question),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedExample = value;
                    _questionController.text = value ?? '';
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _askAyurvedicBaba(_questionController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(width: 8),
                              Text('Consulting Baba...',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          )
                        : const Text('Ask Baba 🧙',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _clearInput,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Clear',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_response.isNotEmpty)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ayurvedic Baba Says:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _response,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Received: $_timestamp',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoshaQuizScreen extends StatefulWidget {
  const DoshaQuizScreen({super.key});

  @override
  State<DoshaQuizScreen> createState() => _DoshaQuizScreenState();
}

class _DoshaQuizScreenState extends State<DoshaQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<bool?> answers = List.filled(10, null);

  final List<Map<String, dynamic>> quizQuestions = const [
    {
      "question": "What are the three doshas in Ayurveda?",
      "options": [
        "Vata, Pitta, Kapha",
        "Fire, Water, Earth",
        "Air, Space, Fire",
        "Sun, Moon, Stars"
      ],
      "correctAnswer": 0,
    },
    {
      "question": "Which dosha is linked to air and space?",
      "options": ["Pitta", "Kapha", "Vata", "None"],
      "correctAnswer": 2,
    },
    {
      "question": "What does Panchakarma aim to do?",
      "options": [
        "Build muscle",
        "Detoxify the body",
        "Increase appetite",
        "Cure colds"
      ],
      "correctAnswer": 1,
    },
    {
      "question": "Which herb is used for stress relief?",
      "options": ["Turmeric", "Ashwagandha", "Neem", "Cumin"],
      "correctAnswer": 1,
    },
    {
      "question": "True or False: Dinacharya is a daily routine.",
      "options": ["True", "False"],
      "correctAnswer": 0,
    },
    {
      "question": "Which dosha relates to fire and water?",
      "options": ["Vata", "Pitta", "Kapha", "All"],
      "correctAnswer": 1,
    },
    {
      "question": "What is Ritucharya?",
      "options": [
        "Daily meditation",
        "Seasonal adjustments",
        "Herbal tea",
        "Yoga poses"
      ],
      "correctAnswer": 1,
    },
    {
      "question": "Which plant is known for immunity?",
      "options": ["Tulsi", "Pepper", "Ginger", "Salt"],
      "correctAnswer": 0,
    },
    {
      "question": "True or False: Agni is digestive fire.",
      "options": ["True", "False"],
      "correctAnswer": 0,
    },
    {
      "question": "What does Ojas represent?",
      "options": ["Toxins", "Vital energy", "Sleep", "Pain"],
      "correctAnswer": 1,
    },
  ];

  void _answerQuestion(int selectedAnswerIndex) {
    bool isCorrect = selectedAnswerIndex ==
        quizQuestions[currentQuestionIndex]["correctAnswer"];
    setState(() {
      answers[currentQuestionIndex] = isCorrect;
      if (isCorrect) score++;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < quizQuestions.length - 1) {
        setState(() {
          currentQuestionIndex++;
        });
      } else {
        _showQuizResult();
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      answers = List.filled(10, null);
    });
  }

  void _showQuizResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Result 🎉'),
        content: Text('Your score: $score/${quizQuestions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetQuiz();
            },
            child: const Text('Restart', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dosha Quiz 📝'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / quizQuestions.length,
                color: Colors.blue,
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                'Question ${currentQuestionIndex + 1}/${quizQuestions.length}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    quizQuestions[currentQuestionIndex]["question"],
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: List.generate(
                  quizQuestions[currentQuestionIndex]["options"].length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: answers[currentQuestionIndex] == null
                          ? () => _answerQuestion(index)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: answers[currentQuestionIndex] == null
                            ? Colors.blue
                            : (index ==
                                        quizQuestions[currentQuestionIndex]
                                            ["correctAnswer"] &&
                                    answers[currentQuestionIndex] != null)
                                ? Colors.green
                                : (index ==
                                            (answers[currentQuestionIndex] ==
                                                    true
                                                ? quizQuestions[
                                                        currentQuestionIndex]
                                                    ["correctAnswer"]
                                                : index) &&
                                        answers[currentQuestionIndex] != null)
                                    ? Colors.red
                                    : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        quizQuestions[currentQuestionIndex]["options"][index],
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (answers[currentQuestionIndex] != null)
                Text(
                  answers[currentQuestionIndex]! ? 'Correct! ✅' : 'Wrong! ❌',
                  style: TextStyle(
                    fontSize: 16,
                    color: answers[currentQuestionIndex]!
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: _resetQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Reset Quiz',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
