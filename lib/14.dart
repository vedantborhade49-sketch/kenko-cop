import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyDietCoach extends StatefulWidget {
  const MyDietCoach({super.key});

  @override
  State<MyDietCoach> createState() => _MyDietCoachState();
}

class _MyDietCoachState extends State<MyDietCoach> {
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _needsController = TextEditingController();

  String _dietRecommendation = "";
  bool _isLoading = false;

  static const String apiKey = "AIzaSyD6qQvrTuEWK6RQa3Fy_ikV6Ws8X9o-mDc"; // Same API key as main.dart

  void _generateDietPlan() async {
    setState(() {
      _isLoading = true;
      _dietRecommendation = "";
    });

    String prompt = """
    Generate a personalized daily diet plan based on the following user inputs:
    - Daily calorie intake from calorimeter: ${_caloriesController.text.isEmpty ? "2000" : _caloriesController.text} calories
    - Health goal: ${_goalsController.text.isEmpty ? "maintain weight" : _goalsController.text}
    - Available foods: ${_availabilityController.text.isEmpty ? "common foods like rice, chicken, vegetables, fruits" : _availabilityController.text}
    - Budget: ${_budgetController.text.isEmpty ? "moderate" : _budgetController.text}
    - Allergies: ${_allergiesController.text.isEmpty ? "none" : _allergiesController.text}
    - Nutritional needs: ${_needsController.text.isEmpty ? "balanced diet" : _needsController.text}
    
    Provide a simple meal plan with breakfast, lunch, dinner, and snacks, including portion sizes and approximate calorie counts. Keep it affordable and practical based on the inputs.
    """;

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        _dietRecommendation = response.text ?? "No recommendation received.";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _dietRecommendation = "Error generating diet plan: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Diet Coach 🍽️",
          style: TextStyle(color: Colors.black87),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Section
              _buildSectionTitle("Enter Your Details 📋"),
              _buildInputField(
                controller: _caloriesController,
                label: "Daily Calories (e.g., 2000)",
                hint: "From calorimeter",
                icon: "🔥",
              ),
              _buildInputField(
                controller: _goalsController,
                label: "Health Goal (e.g., lose weight)",
                hint: "Lose weight, gain muscle, etc.",
                icon: "🎯",
              ),
              _buildInputField(
                controller: _availabilityController,
                label: "Available Foods (e.g., rice, chicken)",
                hint: "What you have access to",
                icon: "🍎",
              ),
              _buildInputField(
                controller: _budgetController,
                label: "Budget (e.g., low, moderate)",
                hint: "Your affordability level",
                icon: "💰",
              ),
              _buildInputField(
                controller: _allergiesController,
                label: "Allergies (e.g., nuts, dairy)",
                hint: "List any allergies",
                icon: "🚫",
              ),
              _buildInputField(
                controller: _needsController,
                label: "Nutritional Needs (e.g., more vitamins)",
                hint: "Specific needs like vitamins",
                icon: "💊",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateDietPlan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Generate Diet Plan",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              // Diet Recommendation Section
              const SizedBox(height: 20),
              _buildSectionTitle("Your Diet Plan 🍲"),
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: Colors.blue))
              else if (_dietRecommendation.isNotEmpty)
                _buildSectionContent(_dietRecommendation)
              else
                _buildSectionContent(
                  "Enter your details above and press 'Generate Diet Plan' to get a personalized diet recommendation.",
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Text(
            icon,
            style: const TextStyle(fontSize: 20, color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}