import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class NewbornWellness extends StatefulWidget {
  const NewbornWellness({super.key});

  @override
  State<NewbornWellness> createState() => _NewbornWellnessState();
}

class _NewbornWellnessState extends State<NewbornWellness> {
  final TextEditingController _aiQueryController = TextEditingController();
  String _aiResponse = "";
  bool _isAILoading = false;

  static const String apiKey = "AIzaSyD6qQvrTuEWK6RQa3Fy_ikV6Ws8X9o-mDc";

  void _getAIHealthInsight() async {
    String query = _aiQueryController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isAILoading = true;
      _aiResponse = "";
    });

    String prompt = "Provide a concise, evidence-based health insight for a newborn based on this query: $query. Tailor it for new parents.";
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        _aiResponse = response.text ?? "No insight received.";
        _isAILoading = false;
      });
    } catch (e) {
      setState(() {
        _aiResponse = "Error: $e";
        _isAILoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Newborn Wellness 👶",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Text(
            "⬅️",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Baby Care Hub",
              style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildFeatureTile(context, "Growth", "🌱", Colors.green, const GrowthScreen()),
                  _buildFeatureTile(context, "Vaccines", "💉", Colors.red, const VaccinesScreen()),
                  _buildFeatureTile(context, "Feeding", "🍽️", Colors.orange, const FeedingScreen()),
                  _buildFeatureTile(context, "Health", "🩺", Colors.teal, const HealthScreen()),
                  _buildFeatureTile(context, "Community", "👥", Colors.purple, const CommunityScreen()),
                  _buildFeatureTile(context, "Doctors", "🏥", Colors.cyan, const DoctorsScreen()),
                  _buildFeatureTile(context, "Sleep", "😴", Colors.indigo, const SleepScreen()),
                  _buildFeatureTile(context, "Checklist", "✅", Colors.lime, const ChecklistScreen()),
                  _buildFeatureTile(context, "Emergency", "🚨", Colors.pink, const EmergencyScreen()),
                  _buildFeatureTile(context, "Hygiene", "🛁", Colors.blueGrey, const HygieneScreen()),
                  _buildFeatureTile(context, "Play", "🎲", Colors.amber, const PlayScreen()),
                  _buildFeatureTile(context, "Alerts", "🔔", Colors.yellow, const AlertsScreen()),
                  _buildFeatureTile(context, "Photos", "📸", Colors.deepOrange, const PhotosScreen()),
                  _buildFeatureTile(context, "Mood", "😊", Colors.purpleAccent, const MoodScreen()),
                  _buildFeatureTile(context, "Soothing", "🌙", Colors.lightBlue, const SoothingScreen()),
                  _buildFeatureTile(context, "Gear", "🍼", Colors.brown, const GearScreen()),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle("AI Health Insights 🤖"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _aiQueryController,
                      decoration: InputDecoration(
                        hintText: "Ask about your baby...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Text("❓", style: TextStyle(fontSize: 20, color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _getAIHealthInsight,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Get Insight", style: TextStyle(color: Colors.white)),
                    ),
                    if (_isAILoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: CircularProgressIndicator(color: Colors.blue),
                      )
                    else if (_aiResponse.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          _aiResponse,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, String title, String emoji, Color color, Widget screen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Subdirectory Screens
class GrowthScreen extends StatelessWidget {
  const GrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Baby Growth 🌱",
      "Track milestones:\n- 0-1 Month: Grasping, head lift.\n- 1-3 Months: Smiles, tracks objects.",
      [
        _buildActionButton(context, "Log Milestone", () => _showSnack(context, "Milestone logged!")),
        _buildActionButton(context, "View Chart", () => _showSnack(context, "Chart coming soon!")),
      ],
    );
  }
}

class VaccinesScreen extends StatelessWidget {
  const VaccinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Vaccines 💉",
      "Key shots:\n- Vitamin K: At birth.\n- Hepatitis B: 0, 1-2, 6-18 months.",
      [
        _buildActionButton(context, "Add Record", () => _showSnack(context, "Record added!")),
        _buildActionButton(context, "Set Reminder", () => _showSnack(context, "Reminder set!")),
      ],
    );
  }
}

class FeedingScreen extends StatelessWidget {
  const FeedingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Feeding 🍽️",
      "Guide:\n- Breast: 8-12 times/day.\n- Formula: 1-3 oz, 3-4 hours.",
      [
        _buildActionButton(context, "Log Feed", () => _showSnack(context, "Feed logged!")),
        _buildActionButton(context, "View History", () => _showSnack(context, "History coming soon!")),
      ],
    );
  }
}

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Health 🩺",
      "Daily checks:\n- Temp: 36.6-38°C.\n- Weight: 0.5-1 oz/day gain.",
      [
        _buildActionButton(context, "Log Vitals", () => _showSnack(context, "Vitals logged!")),
        _buildActionButton(context, "Trends", () => _showSnack(context, "Trends coming soon!")),
      ],
    );
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Community 👥",
      "Connect:\n- Join forums.\n- Access helplines.",
      [
        _buildActionButton(context, "Join Forum", () => _showSnack(context, "Forum link coming soon!")),
        _buildActionButton(context, "Call Helpline", () => _showSnack(context, "Helpline coming soon!")),
      ],
    );
  }
}

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Doctors 🏥",
      "Find care:\n- Pediatricians.\n- Hospitals.",
      [
        _buildActionButton(context, "Search", () => _showSnack(context, "Search coming soon!")),
        _buildActionButton(context, "Book Now", () => _showSnack(context, "Booking coming soon!")),
      ],
    );
  }
}

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Sleep 😴",
      "Track:\n- 14-17 hrs/day.\n- Safe sleep: Back position.",
      [
        _buildActionButton(context, "Log Sleep", () => _showSnack(context, "Sleep logged!")),
        _buildActionButton(context, "Sleep Tips", () => _showSnack(context, "Tips coming soon!")),
      ],
    );
  }
}

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Checklist ✅",
      "Tasks:\n- Cord care.\n- Bathing.",
      [
        _buildActionButton(context, "Add Task", () => _showSnack(context, "Task added!")),
        _buildActionButton(context, "View List", () => _showSnack(context, "List coming soon!")),
      ],
    );
  }
}

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Emergency 🚨",
      "Guide:\n- Fever >38°C.\n- Breathing issues.",
      [
        _buildActionButton(context, "Call 911", () => _showSnack(context, "Emergency call coming soon!")),
        _buildActionButton(context, "First Aid", () => _showSnack(context, "Guide coming soon!")),
      ],
    );
  }
}

class HygieneScreen extends StatelessWidget {
  const HygieneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Hygiene 🛁",
      "Routine:\n- Sponge bath 2-3x/week.\n- Nail trimming.",
      [
        _buildActionButton(context, "Log Bath", () => _showSnack(context, "Bath logged!")),
        _buildActionButton(context, "Hygiene Tips", () => _showSnack(context, "Tips coming soon!")),
      ],
    );
  }
}

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Play 🎲",
      "Activities:\n- Rattles.\n- Mirror play.",
      [
        _buildActionButton(context, "Log Play", () => _showSnack(context, "Play logged!")),
        _buildActionButton(context, "More Ideas", () => _showSnack(context, "Ideas coming soon!")),
      ],
    );
  }
}

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Alerts 🔔",
      "Set alerts:\n- Feeds.\n- Vaccines.",
      [
        _buildActionButton(context, "Add Alert", () => _showSnack(context, "Alert added!")),
        _buildActionButton(context, "View All", () => _showSnack(context, "List coming soon!")),
      ],
    );
  }
}

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Photos 📸",
      "Capture:\n- First smile.\n- Growth moments.",
      [
        _buildActionButton(context, "Add Photo", () => _showSnack(context, "Photo added!")),
        _buildActionButton(context, "View Album", () => _showSnack(context, "Album coming soon!")),
      ],
    );
  }
}

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Mood 😊",
      "Track:\n- Happy moments.\n- Fussy periods.",
      [
        _buildActionButton(context, "Log Mood", () => _showSnack(context, "Mood logged!")),
        _buildActionButton(context, "Mood Trends", () => _showSnack(context, "Trends coming soon!")),
      ],
    );
  }
}

class SoothingScreen extends StatelessWidget {
  const SoothingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Soothing 🌙",
      "Calm baby:\n- White noise.\n- Swaddling.",
      [
        _buildActionButton(context, "Log Technique", () => _showSnack(context, "Technique logged!")),
        _buildActionButton(context, "More Tips", () => _showSnack(context, "Tips coming soon!")),
      ],
    );
  }
}

class GearScreen extends StatelessWidget {
  const GearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSubScreen(
      context,
      "Gear 🍼",
      "Essentials:\n- Crib.\n- Bottles.",
      [
        _buildActionButton(context, "Add Item", () => _showSnack(context, "Item added!")),
        _buildActionButton(context, "View List", () => _showSnack(context, "List coming soon!")),
      ],
    );
  }
}

// Helper Functions
Widget _buildSubScreen(BuildContext context, String title, String info, List<Widget> actions) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black87)),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Text("⬅️", style: TextStyle(fontSize: 24, color: Colors.white)),
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
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  info,
                  style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Tools",
              style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: actions,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildActionButton(BuildContext context, String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
}

void _showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}