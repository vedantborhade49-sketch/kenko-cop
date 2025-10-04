import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const SymptomCheckerApp());
}

class SymptomCheckerApp extends StatelessWidget {
  const SymptomCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.lightBlue.shade50,
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
      home: const SymptomCheckerScreen(),
    );
  }
}

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _severityController = TextEditingController();
  final TextEditingController _previousRecordsController = TextEditingController();
  String? _selectedGender;
  int? _age;
  final List<String> _selectedConditions = [];
  String _analysisResult = '';
  List<Map<String, String>> _risks = [];
  bool _showDetails = false;
  bool _isLoading = false;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _commonConditions = [
    'High Cholesterol',
    'Hypertension',
    'Diabetes',
    'Asthma',
    'Heart Disease',
    'Arthritis',
    'Thyroid Issues',
    'Migraine',
    'Kidney Disease',
    'Liver Disease',
    'None',
  ];

  static const String apiKey = "AIzaSyA7Z_b1EuJkikrTbkmNbeD5aGFcbcL5ek8";

  void _analyzeSymptoms() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
        _analysisResult = '';
        _risks = [];
      });

      String prompt = "Analyze the following symptoms and provide a detailed diagnosis:\n"
          "Symptoms: ${_symptomsController.text}\n"
          "Duration: ${_durationController.text}\n"
          "Severity: ${_severityController.text}\n"
          "Previous Records: ${_previousRecordsController.text}\n"
          "Age: $_age\n"
          "Gender: $_selectedGender\n"
          "Conditions: ${_selectedConditions.join(', ')}\n"
          "Provide a concise diagnosis, potential health risks, and next steps.";

      try {
        final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
        final response = await model.generateContent([Content.text(prompt)]);

        setState(() {
          _analysisResult = response.text ?? 'No analysis available.';
          _risks = _parseRisks(_analysisResult);
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _analysisResult = 'Error: $e';
          _isLoading = false;
        });
      }
    }
  }

  List<Map<String, String>> _parseRisks(String analysis) {
    List<Map<String, String>> risks = [];
    // Basic parsing logic (could be enhanced with regex or NLP)
    if (analysis.contains('heart attack')) {
      risks.add({
        'risk': 'Heart Attack',
        'cause': 'High cholesterol or hypertension',
        'probability': 'Moderate to High',
        'advice': 'Consult a cardiologist, reduce fatty foods.'
      });
    }
    if (analysis.contains('stroke')) {
      risks.add({
        'risk': 'Stroke',
        'cause': 'Hypertension or diabetes',
        'probability': 'Moderate',
        'advice': 'Monitor blood pressure, maintain a healthy diet.'
      });
    }
    if (analysis.contains('infection')) {
      risks.add({
        'risk': 'Infection',
        'cause': 'Fever or fatigue',
        'probability': 'Low to Moderate',
        'advice': 'Rest, hydrate, see a doctor if persistent.'
      });
    }
    return risks.isEmpty ? [{'risk': 'No specific risks identified', 'cause': 'N/A', 'probability': 'N/A', 'advice': 'Monitor symptoms.'}] : risks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker 🤖'),
        centerTitle: true,
        leading: IconButton(
          icon: const Text("⬅️", style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Your Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                _buildInputCard('Symptoms', '🤒', TextFormField(
                  controller: _symptomsController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., fever, cough, fatigue',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Enter symptoms' : null,
                )),
                const SizedBox(height: 16),
                _buildInputCard('Duration of Symptoms', '⏳', TextFormField(
                  controller: _durationController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., 3 days, 1 week',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter duration' : null,
                )),
                const SizedBox(height: 16),
                _buildInputCard('Severity of Symptoms', '📈', TextFormField(
                  controller: _severityController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., mild, moderate, severe',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter severity' : null,
                )),
                const SizedBox(height: 16),
                _buildInputCard('Previous Medical Records', '📋', TextFormField(
                  controller: _previousRecordsController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., previous diagnoses, surgeries',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Enter previous records' : null,
                )),
                const SizedBox(height: 16),
                _buildInputCard('Gender', '👤', DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: const Text('Select Gender'),
                  items: _genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                  onChanged: (value) => setState(() => _selectedGender = value),
                  validator: (value) => value == null ? 'Select gender' : null,
                )),
                const SizedBox(height: 16),
                _buildInputCard('Age', '🎂', TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'e.g., 30',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter age' : null,
                  onSaved: (value) => _age = int.tryParse(value!),
                )),
                const SizedBox(height: 16),
                const Text(
                  'Known Conditions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: _commonConditions.map((condition) {
                    return FilterChip(
                      label: Text(condition),
                      selected: _selectedConditions.contains(condition),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedConditions.add(condition);
                          } else {
                            _selectedConditions.remove(condition);
                          }
                        });
                      },
                      selectedColor: Colors.blue.shade100,
                      checkmarkColor: Colors.blue,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _analyzeSymptoms,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Analyze Symptoms 🔍', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                if (_analysisResult.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Analysis Result 📋',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(_analysisResult, style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 16),
                          const Text(
                            'Potential Health Risks ⚠️',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          ..._risks.map((risk) => _buildRiskTile(risk)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => setState(() => _showDetails = !_showDetails),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              _showDetails ? 'Hide Details' : 'Show More Details',
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          if (_showDetails) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Next Steps ℹ️',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Based on the analysis:\n'
                              '- Consult a doctor if symptoms persist.\n'
                              '- Monitor ${_selectedConditions.isEmpty ? 'general health' : _selectedConditions.join(', ')}.\n'
                              '- Stay hydrated and rest.',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(String label, String emoji, Widget child) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskTile(Map<String, String> risk) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${risk['risk']}: ${risk['probability']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Cause: ${risk['cause']}'),
                Text('Advice: ${risk['advice']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    _durationController.dispose();
    _severityController.dispose();
    _previousRecordsController.dispose();
    super.dispose();
  }
}