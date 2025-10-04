import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
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
    home: const GovernmentSchemes(),
  ));
}

class GovernmentSchemes extends StatefulWidget {
  const GovernmentSchemes({Key? key}) : super(key: key);

  @override
  _GovernmentSchemesState createState() => _GovernmentSchemesState();
}

class _GovernmentSchemesState extends State<GovernmentSchemes> {
  String? _selectedGender;
  String? _selectedAge;
  String? _selectedIncome;

  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _ages = ["Below 18", "18-40", "Above 40"];
  final List<String> _incomes = ["Below ₹1 Lakh", "₹1-5 Lakh", "Above ₹5 Lakh"];

  List<Scheme> _filteredSchemes = [];

  @override
  void initState() {
    super.initState();
    _filteredSchemes = _schemes; // Initially show all schemes
  }

  void _applyFilters() {
    setState(() {
      _filteredSchemes = _schemes.where((scheme) {
        bool matchesGender = _selectedGender == null || scheme.gender == _selectedGender;
        bool matchesAge = _selectedAge == null || scheme.age == _selectedAge;
        bool matchesIncome = _selectedIncome == null || scheme.income == _selectedIncome;
        return matchesGender && matchesAge && matchesIncome;
      }).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Filters applied! ✅")),
    );
  }

  void _resetFilters() {
    setState(() {
      _selectedGender = null;
      _selectedAge = null;
      _selectedIncome = null;
      _filteredSchemes = _schemes;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Filters reset! 🔄")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Govt Schemes ✅"),
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
        child: Column(
          children: [
            // Filter Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("👤 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedGender,
                              decoration: InputDecoration(
                                labelText: "Gender",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: _genders.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("🎂 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedAge,
                              decoration: InputDecoration(
                                labelText: "Age",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: _ages.map((String age) {
                                return DropdownMenuItem<String>(
                                  value: age,
                                  child: Text(age),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedAge = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("💰 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedIncome,
                              decoration: InputDecoration(
                                labelText: "Family Income",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: _incomes.map((String income) {
                                return DropdownMenuItem<String>(
                                  value: income,
                                  child: Text(income),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedIncome = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _applyFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              "Apply ✅",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // List of Schemes
            Expanded(
              child: _filteredSchemes.isEmpty
                  ? const Center(child: Text("No schemes match your filters!", style: TextStyle(fontSize: 16, color: Colors.black87)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _filteredSchemes.length,
                      itemBuilder: (context, index) {
                        final scheme = _filteredSchemes[index];
                        return SchemeCard(
                          title: scheme.title,
                          description: scheme.description,
                          emoji: _getEmojiForScheme(scheme.icon),
                          color: scheme.color,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetFilters,
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Text("🔄", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  String _getEmojiForScheme(IconData icon) {
    // Replaced switch with if-else to avoid IconData error
    if (icon == Icons.health_and_safety) return "🩺";
    if (icon == Icons.monetization_on) return "💰";
    if (icon == Icons.medical_services) return "🏥";
    if (icon == Icons.child_care) return "👶";
    if (icon == Icons.psychology) return "🧠";
    if (icon == Icons.school) return "🎓";
    if (icon == Icons.vaccines) return "💉";
    if (icon == Icons.medical_information) return "ℹ️";
    if (icon == Icons.people) return "👥";
    if (icon == Icons.pregnant_woman) return "🤰";
    if (icon == Icons.healing) return "🩹";
    if (icon == Icons.medication) return "💊";
    if (icon == Icons.elderly) return "👴";
    return "✅"; // Default case
  }
}

class Scheme {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String? gender;
  final String? age;
  final String? income;

  Scheme({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.gender,
    this.age,
    this.income,
  });
}

final List<Scheme> _schemes = [
  Scheme(
    title: "Ayushman Bharat Yojana",
    description: "Health insurance for low-income families.",
    icon: Icons.health_and_safety,
    color: Colors.blueAccent,
    gender: null,
    age: null,
    income: "Below ₹1 Lakh",
  ),
  Scheme(
    title: "Pradhan Mantri Jan Arogya Yojana (PMJAY)",
    description: "Provides health cover of ₹5 lakh per family per year.",
    icon: Icons.monetization_on,
    color: Colors.greenAccent,
    gender: null,
    age: null,
    income: "Below ₹1 Lakh",
  ),
  Scheme(
    title: "National Health Mission (NHM)",
    description: "Improves healthcare infrastructure across India.",
    icon: Icons.medical_services,
    color: Colors.orangeAccent,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "Rashtriya Swasthya Bima Yojana (RSBY)",
    description: "Health insurance for below-poverty-line families.",
    icon: Icons.health_and_safety,
    color: Colors.purpleAccent,
    gender: null,
    age: null,
    income: "Below ₹1 Lakh",
  ),
  Scheme(
    title: "Janani Shishu Suraksha Karyakram (JSSK)",
    description: "Free delivery and postnatal care for pregnant women.",
    icon: Icons.child_care,
    color: Colors.pinkAccent,
    gender: "Female",
    age: "18-40",
    income: null,
  ),
  Scheme(
    title: "National Mental Health Programme (NMHP)",
    description: "Provides mental health services and awareness.",
    icon: Icons.psychology,
    color: Colors.blueAccent,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "Pradhan Mantri Swasthya Suraksha Yojana (PMSSY)",
    description: "Improves medical education and infrastructure.",
    icon: Icons.school,
    color: Colors.greenAccent,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "Mission Indradhanush",
    description: "Immunization program for children and pregnant women.",
    icon: Icons.vaccines,
    color: Colors.orangeAccent,
    gender: null,
    age: "Below 18",
    income: null,
  ),
  Scheme(
    title: "National Programme for Prevention and Control of Cancer, Diabetes, CVDs, and Stroke (NPCDCS)",
    description: "Prevents and controls non-communicable diseases.",
    icon: Icons.medical_information,
    color: Colors.purpleAccent,
    gender: null,
    age: "Above 40",
    income: null,
  ),
  Scheme(
    title: "Ayushman Sahakar Scheme",
    description: "Supports healthcare cooperatives.",
    icon: Icons.people,
    color: Colors.pinkAccent,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "Pradhan Mantri Matru Vandana Yojana (PMMVY)",
    description: "Provides financial assistance to pregnant and lactating women.",
    icon: Icons.pregnant_woman,
    color: Colors.tealAccent,
    gender: "Female",
    age: "18-40",
    income: "Below ₹1 Lakh",
  ),
  Scheme(
    title: "National Tuberculosis Elimination Programme (NTEP)",
    description: "Aims to eliminate tuberculosis by 2025.",
    icon: Icons.medical_services,
    color: Colors.redAccent,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "National AIDS Control Programme (NACP)",
    description: "Prevents and controls HIV/AIDS in India.",
    icon: Icons.healing,
    color: Colors.deepPurpleAccent,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "Pradhan Mantri Bhartiya Janaushadhi Pariyojana (PMBJP)",
    description: "Provides affordable generic medicines to all.",
    icon: Icons.medication,
    color: Colors.blueGrey,
    gender: null,
    age: null,
    income: null,
  ),
  Scheme(
    title: "National Programme for Healthcare of the Elderly (NPHCE)",
    description: "Provides healthcare services for senior citizens.",
    icon: Icons.elderly,
    color: Colors.amberAccent,
    gender: null,
    age: "Above 40",
    income: null,
  ),
];

class SchemeCard extends StatelessWidget {
  final String title;
  final String description;
  final String emoji;
  final Color color;

  const SchemeCard({
    Key? key,
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchemeDetails(
                title: title,
                description: description,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 40, color: color)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchemeDetails extends StatelessWidget {
  final String title;
  final String description;

  const SchemeDetails({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title ✅"),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("📜 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text("👥 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Text(
                      "Who Can Benefit?",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Low-income families, pregnant women, children, and individuals with specific health conditions can benefit from this scheme.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}