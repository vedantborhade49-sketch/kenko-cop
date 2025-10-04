import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
      ),
      home: const NearbyFacilities(),
    );
  }
}

class NearbyFacilities extends StatelessWidget {
  const NearbyFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Facilities 🏥"),
        leading: IconButton(
          icon: const Text("⬅️", style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Text("📍", style: TextStyle(fontSize: 24, color: Colors.white)),
            onPressed: () => _showLocationSnackBar(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: _facilityOptions(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Chatbot coming soon! 🤖")),
          );
        },
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Text("🤖", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  void _showLocationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fetching your location... 📍")),
    );
  }

  List<Widget> _facilityOptions(BuildContext context) => [
        _buildFacilityCard(
          context,
          "Doctors Near Me",
          "🩺",
          Colors.green,
          const DoctorsNearMePage(),
        ),
        _buildFacilityCard(
          context,
          "Ambulance Services",
          "🚑",
          Colors.red,
          const AmbulanceServicesPage(),
        ),
        _buildFacilityCard(
          context,
          "Blood Banks",
          "🩺",
          Colors.pink,
          const BloodBanksPage(),
        ),
        _buildFacilityCard(
          context,
          "Medicals Near Me",
          "💊",
          Colors.orange,
          const MedicalsNearMePage(),
        ),
        _buildFacilityCard(
          context,
          "Generic Medical",
          "🏥",
          Colors.teal,
          const GenericMedicalPage(),
        ),
      ];

  Widget _buildFacilityCard(
    BuildContext context,
    String title,
    String emoji,
    Color color,
    Widget page,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: TextStyle(fontSize: 50, color: color)),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String location;
  final String phone;

  const ProfileCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.location,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "👤 ",
                  style: TextStyle(fontSize: 24, color: Colors.blue.shade900),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (subtitle != null)
              Text(
                "Specialty: $subtitle",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            Text(
              "📍 Location: $location",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Text(
              "📞 Phone: $phone",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

class FacilityPage extends StatefulWidget {
  final String title;

  const FacilityPage({super.key, required this.title});

  @override
  State<FacilityPage> createState() => _FacilityPageState();
}

class _FacilityPageState extends State<FacilityPage> {
  final TextEditingController _cityController = TextEditingController();
  List<ProfileCard> profiles = [];
  bool _isLoading = false;
  static const String apiKey = "AIzaSyD6qQvrTuEWK6RQa3Fy_ikV6Ws8X9o-mDc";

  void _fetchFacilities() async {
    String city = _cityController.text.trim();
    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a city name")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      profiles.clear();
    });

    String prompt = "List 3 ${widget.title.toLowerCase()} in $city, India. Provide name, location, and phone number in a concise format.";
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final response = await model.generateContent([Content.text(prompt)]);

      String? result = response.text;
      if (result != null) {
        List<ProfileCard> fetchedProfiles = _parseGeminiResponse(result, widget.title);
        setState(() {
          profiles = fetchedProfiles;
          _isLoading = false;
        });
      } else {
        _showError("No results found.");
      }
    } catch (e) {
      _showError("Error fetching data: $e");
    }
  }

  void _showError(String message) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<ProfileCard> _parseGeminiResponse(String response, String type) {
    List<ProfileCard> parsed = [];
    List<String> lines = response.split('\n').where((line) => line.trim().isNotEmpty).toList();

    for (String line in lines) {
      RegExp regex = RegExp(r'(.*?)\s*-\s*(.*?)\s*-\s*(.*)');
      Match? match = regex.firstMatch(line);
      if (match != null) {
        String name = match.group(1)?.trim() ?? "Unknown";
        String location = match.group(2)?.trim() ?? "Unknown Location";
        String phone = match.group(3)?.trim() ?? "Unknown Phone";
        parsed.add(ProfileCard(
          title: name,
          subtitle: type.contains("Doctor") ? "Specialist" : null,
          location: location,
          phone: phone,
        ));
      }
    }
    return parsed.isEmpty ? [const ProfileCard(title: "No data", location: "N/A", phone: "N/A")] : parsed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} 🏥"),
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
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: "Enter city (e.g., Pune, Mumbai)",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Text("🌆", style: TextStyle(fontSize: 20, color: Colors.blue)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _fetchFacilities,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Search", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                  : ListView(
                      children: profiles.isEmpty
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Enter a city to find facilities",
                                  style: TextStyle(fontSize: 16, color: Colors.black87),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]
                          : profiles,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Specific Facility Pages
class DoctorsNearMePage extends StatelessWidget {
  const DoctorsNearMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FacilityPage(title: "Doctors Near Me");
  }
}

class AmbulanceServicesPage extends StatelessWidget {
  const AmbulanceServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FacilityPage(title: "Ambulance Services");
  }
}

class BloodBanksPage extends StatelessWidget {
  const BloodBanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FacilityPage(title: "Blood Banks");
  }
}

class MedicalsNearMePage extends StatelessWidget {
  const MedicalsNearMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FacilityPage(title: "Medicals Near Me");
  }
}

class GenericMedicalPage extends StatelessWidget {
  const GenericMedicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FacilityPage(title: "Generic Medical");
  }
}