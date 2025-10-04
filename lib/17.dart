import 'package:flutter/material.dart';

void main() {
  runApp(const HealthTipsApp());
}

class HealthTipsApp extends StatelessWidget {
  const HealthTipsApp({super.key});

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
      home: const HealthTipsScreen(),
    );
  }
}

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});

  @override
  _HealthTipsScreenState createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  int? _age;
  final List<String> _selectedConditions = [];
  List<String> _tips = [];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _conditions = [
    'Diabetes',
    'Hypertension',
    'High Cholesterol',
    'Asthma',
    'None',
  ];

  void _generateTips() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _tips = _createHealthTips(_selectedGender, _age, _selectedConditions);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TipsResultScreen(tips: _tips),
        ),
      );
    }
  }

  List<String> _createHealthTips(String? gender, int? age, List<String> conditions) {
    List<String> tips = [];

    // General tips based on age
    if (age != null) {
      if (age < 18) {
        tips.add('🧒 Ensure regular check-ups and vaccinations for healthy growth.');
      } else if (age <= 40) {
        tips.add('🏃 Stay active with at least 30 minutes of exercise most days.');
      } else {
        tips.add('👴 Prioritize bone health with calcium and vitamin D intake.');
      }
    }

    // Gender-specific tips
    if (gender == 'Female') {
      tips.add('👩 Schedule regular gynecological screenings (e.g., Pap smear).');
    } else if (gender == 'Male') {
      tips.add('👨 Consider prostate health checks after age 50.');
    }

    // Condition-specific tips
    if (conditions.contains('Diabetes')) {
      tips.add('🍎 Monitor blood sugar daily and maintain a balanced diet.');
    }
    if (conditions.contains('Hypertension')) {
      tips.add('🧂 Reduce salt intake and manage stress levels.');
    }
    if (conditions.contains('High Cholesterol')) {
      tips.add('🥑 Opt for heart-healthy fats like avocado and nuts.');
    }
    if (conditions.contains('Asthma')) {
      tips.add('💨 Avoid triggers like smoke and keep an inhaler handy.');
    }
    if (conditions.contains('None')) {
      tips.add('✅ Maintain a healthy lifestyle to prevent future issues.');
    }

    return tips.isNotEmpty ? tips : ['ℹ️ Enter more details for personalized tips!'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips Generator 🌟'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text("👤 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: _genders.map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                          onChanged: (value) => setState(() => _selectedGender = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text("🎂 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => value!.isEmpty ? 'Enter your age' : null,
                          onSaved: (value) => _age = int.tryParse(value!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Known Conditions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: _conditions.map((condition) {
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
                      onPressed: _generateTips,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Get Tips 🌿',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TipsResultScreen extends StatelessWidget {
  final List<String> tips;

  const TipsResultScreen({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Health Tips 🌟'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    tips[index],
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}