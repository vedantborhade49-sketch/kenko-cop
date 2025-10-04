import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Insurance Plan Model
class InsurancePlan {
  final String name;
  final String type;
  final String memberLimit;
  final List<String> coveredFeatures;
  final String description;

  InsurancePlan({
    required this.name,
    required this.type,
    required this.memberLimit,
    required this.coveredFeatures,
    required this.description,
  });
}

// Sample Insurance Plans (abbreviated for brevity, full list from your original)
final List<InsurancePlan> insurancePlans = [
  InsurancePlan(
    name: "Blue Cross Blue Shield PPO",
    type: "PPO",
    memberLimit: "Family (up to 6)",
    coveredFeatures: ["Hospitalization", "Outpatient care", "Prescription drugs", "Preventive care", "Specialist visits"],
    description: "A widely accepted PPO plan offering flexibility with a large network of providers.",
  ),
  InsurancePlan(
    name: "Aetna HMO",
    type: "HMO",
    memberLimit: "Family (up to 5)",
    coveredFeatures: ["Hospitalization", "Primary care", "Preventive care", "Emergency services"],
    description: "Cost-effective HMO with a focus on coordinated care within a network.",
  ),
  // Add the rest of your 15 plans here as in the original
];

// Main App
void main() {
  runApp(const InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

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
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black87)),
      ),
      home: const InsuranceScreen(), // Fixed to match your original name
    );
  }
}

// Insurance Screen (Main Hub)
class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insurance 💼"),
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
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildTile(context, "My Insurance", "📋", Colors.green, const MyInsurancePage()),
            _buildTile(context, "Explore Plans", "🔍", Colors.orange, const ExplorePlansPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, String emoji, Color color, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// My Insurance Page
class MyInsurancePage extends StatefulWidget {
  const MyInsurancePage({super.key});

  @override
  State<MyInsurancePage> createState() => _MyInsurancePageState();
}

class _MyInsurancePageState extends State<MyInsurancePage> {
  final TextEditingController _claimReasonController = TextEditingController();
  final TextEditingController _claimDateController = TextEditingController();
  List<Map<String, String>> claims = [
    {"reason": "Hospital Admission - Dengue", "date": "March 15, 2025", "status": "Approved"},
  ];

  void _submitClaim() {
    String reason = _claimReasonController.text.trim();
    String date = _claimDateController.text.trim();
    if (reason.isEmpty || date.isEmpty) {
      _showSnack(context, "Please fill all fields");
      return;
    }
    setState(() {
      claims.add({"reason": reason, "date": date, "status": "Pending"});
      _claimReasonController.clear();
      _claimDateController.clear();
    });
    _showSnack(context, "Claim submitted!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Insurance 📋"),
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
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Plan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                    SizedBox(height: 8),
                    Text("Name: Blue Cross Blue Shield PPO"),
                    Text("Type: PPO"),
                    Text("Member Limit: Family (up to 6)"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Claims", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                    const SizedBox(height: 8),
                    ...claims.map((claim) => ListTile(
                          title: Text(claim["reason"]!),
                          subtitle: Text("Date: ${claim["date"]} | Status: ${claim["status"]}"),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _claimReasonController,
                      decoration: InputDecoration(
                        hintText: "Claim Reason (e.g., Dengue)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Text("🏥", style: TextStyle(fontSize: 20, color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _claimDateController,
                      decoration: InputDecoration(
                        hintText: "Date (e.g., March 22, 2025)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Text("📅", style: TextStyle(fontSize: 20, color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(context, "Submit Claim", _submitClaim),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildActionButton(context, "View Records", () => _showSnack(context, "Records coming soon!")),
          ],
        ),
      ),
    );
  }
}

// Explore Plans Page with Filters, Comparison, and Premium Estimator
class ExplorePlansPage extends StatefulWidget {
  const ExplorePlansPage({super.key});

  @override
  State<ExplorePlansPage> createState() => _ExplorePlansPageState();
}

class _ExplorePlansPageState extends State<ExplorePlansPage> {
  final TextEditingController _familySizeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<InsurancePlan> filteredPlans = insurancePlans;
  List<InsurancePlan> selectedPlans = [];
  String _aiSuggestion = "";
  String _premiumEstimate = "";
  bool _isLoading = false;
  static const String apiKey = "AIzaSyD6qQvrTuEWK6RQa3Fy_ikV6Ws8X9o-mDc";

  void _filterPlans() {
    String familySize = _familySizeController.text.trim();
    String age = _ageController.text.trim();
    setState(() {
      filteredPlans = insurancePlans.where((plan) {
        bool matchesSize = familySize.isEmpty || plan.memberLimit.contains(familySize);
        bool matchesAge = age.isEmpty || _isAgeSuitable(plan, int.tryParse(age) ?? 0);
        return matchesSize && matchesAge;
      }).toList();
    });
    if (familySize.isNotEmpty && age.isNotEmpty) {
      _getAISuggestion(familySize, age);
      _getPremiumEstimate(familySize, age);
    }
  }

  bool _isAgeSuitable(InsurancePlan plan, int age) {
    if (plan.name.contains("Gold Plus") && age >= 60) return true;
    if (plan.name.contains("Ambetter") && age < 40) return true;
    return age >= 18 && age <= 65;
  }

  void _getAISuggestion(String familySize, String age) async {
    setState(() {
      _isLoading = true;
      _aiSuggestion = "";
    });

    String prompt = "Suggest an insurance plan for a family of $familySize people with an average age of $age years. Provide a brief reason.";
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final response = await model.generateContent([Content.text(prompt)]);
      setState(() {
        _aiSuggestion = response.text ?? "No suggestion received.";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _aiSuggestion = "Error: $e";
        _isLoading = false;
      });
    }
  }

  void _getPremiumEstimate(String familySize, String age) async {
    setState(() {
      _isLoading = true;
      _premiumEstimate = "";
    });

    String prompt = "Estimate the monthly premium for an insurance plan for a family of $familySize people with an average age of $age years. Provide a rough figure and a brief explanation.";
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final response = await model.generateContent([Content.text(prompt)]);
      setState(() {
        _premiumEstimate = response.text ?? "No estimate received.";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _premiumEstimate = "Error: $e";
        _isLoading = false;
      });
    }
  }

  void _togglePlanSelection(InsurancePlan plan) {
    setState(() {
      if (selectedPlans.contains(plan)) {
        selectedPlans.remove(plan);
      } else if (selectedPlans.length < 2) {
        selectedPlans.add(plan);
      } else {
        _showSnack(context, "You can compare only 2 plans at a time.");
      }
    });
  }

  void _comparePlans() {
    if (selectedPlans.length < 2) {
      _showSnack(context, "Select 2 plans to compare.");
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ComparePlansPage(plans: selectedPlans),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Plans 🔍"),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _familySizeController,
                      decoration: InputDecoration(
                        hintText: "Family Size (e.g., 4)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Text("👨‍👩‍👧‍👦", style: TextStyle(fontSize: 20, color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        hintText: "Average Age (e.g., 35)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Text("🎂", style: TextStyle(fontSize: 20, color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(context, "Filter", _filterPlans),
                        _buildActionButton(context, "Compare", _comparePlans),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: Colors.blue))
            else
              Column(
                children: [
                  if (_aiSuggestion.isNotEmpty)
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("AI Suggestion: $_aiSuggestion", style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  if (_premiumEstimate.isNotEmpty) const SizedBox(height: 12),
                  if (_premiumEstimate.isNotEmpty)
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Premium Estimate: $_premiumEstimate", style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlans.length,
                itemBuilder: (context, index) {
                  final plan = filteredPlans[index];
                  bool isSelected = selectedPlans.contains(plan);
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => _togglePlanSelection(plan),
                          ),
                          Expanded(
                            child: Text(plan.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      subtitle: Text("${plan.type} - ${plan.memberLimit}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Covered Features:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                              const SizedBox(height: 8),
                              ...plan.coveredFeatures.map((feature) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check_circle, size: 16, color: Colors.green),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(feature)),
                                      ],
                                    ),
                                  )),
                              const SizedBox(height: 12),
                              const Text("Description:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                              const SizedBox(height: 8),
                              Text(plan.description),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Compare Plans Page
class ComparePlansPage extends StatelessWidget {
  final List<InsurancePlan> plans;

  const ComparePlansPage({super.key, required this.plans});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compare Plans ⚖️"),
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
        child: Row(
          children: plans.map((plan) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(plan.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text("Type: ${plan.type}"),
                            Text("Members: ${plan.memberLimit}"),
                            const SizedBox(height: 12),
                            const Text("Features:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
                            ...plan.coveredFeatures.map((feature) => Text("- $feature")),
                            const SizedBox(height: 12),
                            Text(plan.description),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )).toList(),
        ),
      ),
    );
  }
}

// Helper Functions
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