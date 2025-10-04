import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
          ),
        ),
      ),
      home: const BoxScreen(),
    );
  }
}

class BoxScreen extends StatefulWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  _BoxScreenState createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  final List<String> quotes = [
    "Health is wealth! 🌟",
    "Stay strong, live long! 💪",
    "Every step counts! 🚶",
    "You’ve got this! ✨",
  ];
  final List<String> tips = [
    "Drink water first thing in the morning! 💧",
    "Take a 5-minute stretch break! 🧘",
    "Eat a colorful salad today! 🥗",
    "Aim for 7-8 hours of sleep! 🌙",
  ];
  String currentQuote = "Health is wealth! 🌟";
  String currentTip = "Drink water first thing in the morning! 💧";

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentQuote = quotes[Random().nextInt(quotes.length)];
        currentTip = tips[Random().nextInt(tips.length)];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health Dashboard 🩺")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Quick Stats 📈", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem("Last BMI", "22.5"),
                        _buildStatItem("Last RHR", "68 bpm"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(currentQuote, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Daily Tip 💡", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(currentTip, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Progress Overview 🌟", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.65, // Mock progress (65%)
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                      minHeight: 10,
                    ),
                    const SizedBox(height: 5),
                    const Text("65% to your weekly health goal!", style: TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildGridButton(context, 'Body Metrics', '🏋️', Colors.blue.shade600, const SubScreen2()),
                _buildGridButton(context, 'Vital Signs', '❤️', Colors.red.shade600, const SubScreen4()),
                _buildGridButton(context, 'Metabolic Health', '⚡', Colors.teal.shade600, const SubScreen5()),
                _buildGridButton(context, 'Body Ratios', '📏', Colors.purple.shade600, const SubScreen6()),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Dashboard refreshed! 🔄"))),
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }

  Widget _buildGridButton(BuildContext context, String title, String emoji, Color emojiColor, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening $title...")));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: TextStyle(fontSize: 40, color: emojiColor)),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// Body Metrics Sub-Screen
class SubScreen2 extends StatelessWidget {
  const SubScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Metrics 🏋️')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSubBoxButton(context, 'BMI Calculator 📊', [Colors.blue.shade300, Colors.blue.shade600], const SubScreen2A()),
            _buildSubBoxButton(context, 'Body Fat Calculator ⚖️', [Colors.blue.shade400, Colors.blue.shade700], const SubScreen2B()),
            _buildSubBoxButton(context, 'Waist Circumference 📏', [Colors.blue.shade500, Colors.blue.shade800], const SubScreen2C()),
          ],
        ),
      ),
    );
  }

  Widget _buildSubBoxButton(BuildContext context, String title, List<Color> gradientColors, Widget page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

// Vital Signs Sub-Screen
class SubScreen4 extends StatelessWidget {
  const SubScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vital Signs ❤️')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSubBoxButton(context, 'Breath Holding ⏳', [Colors.blue.shade300, Colors.blue.shade600], const SubScreen4A()),
            _buildSubBoxButton(context, 'Resting Heart Rate 💓', [Colors.blue.shade400, Colors.blue.shade700], const SubScreen4B()),
          ],
        ),
      ),
    );
  }

  Widget _buildSubBoxButton(BuildContext context, String title, List<Color> gradientColors, Widget page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

// Metabolic Health Sub-Screen
class SubScreen5 extends StatelessWidget {
  const SubScreen5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metabolic Health ⚡')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSubBoxButton(context, 'BMR Calculator 🔥', [Colors.blue.shade300, Colors.blue.shade600], const SubScreen5A()),
            _buildSubBoxButton(context, 'TDEE Calculator ⚡', [Colors.blue.shade400, Colors.blue.shade700], const SubScreen5B()),
          ],
        ),
      ),
    );
  }

  Widget _buildSubBoxButton(BuildContext context, String title, List<Color> gradientColors, Widget page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

// Body Ratios Sub-Screen
class SubScreen6 extends StatelessWidget {
  const SubScreen6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Ratios 📏')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSubBoxButton(context, 'Waist-to-Hip Ratio 📐', [Colors.blue.shade300, Colors.blue.shade600], const SubScreen6A()),
            _buildSubBoxButton(context, 'Waist-to-Height Ratio 📏', [Colors.blue.shade400, Colors.blue.shade700], const SubScreen6B()),
          ],
        ),
      ),
    );
  }

  Widget _buildSubBoxButton(BuildContext context, String title, List<Color> gradientColors, Widget page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 2A (BMI Calculator)
class SubScreen2A extends StatefulWidget {
  const SubScreen2A({Key? key}) : super(key: key);

  @override
  _SubScreen2AState createState() => _SubScreen2AState();
}

class _SubScreen2AState extends State<SubScreen2A> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;
  String _result = '';

  void _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      setState(() => _result = 'Please enter both height and weight.');
      return;
    }
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;
    if (height <= 0 || weight <= 0) {
      setState(() => _result = 'Please enter valid values.');
      return;
    }
    height = height / 100;
    setState(() {
      _bmi = weight / (height * height);
      _result = _bmi < 18.5 ? 'Underweight' : _bmi < 25 ? 'Normal' : _bmi < 30 ? 'Overweight' : _bmi < 35 ? 'Obese (Class I)' : _bmi < 40 ? 'Obese (Class II)' : 'Obese (Class III)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator 📊')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder(), hintText: 'e.g., 170'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder(), hintText: 'e.g., 70'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMI,
                child: const Text('Calculate BMI'),
              ),
              const SizedBox(height: 20),
              Text('BMI: ${_bmi.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
              Text('Category: $_result', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 2B (Body Fat Calculator)
class SubScreen2B extends StatefulWidget {
  const SubScreen2B({Key? key}) : super(key: key);

  @override
  _SubScreen2BState createState() => _SubScreen2BState();
}

class _SubScreen2BState extends State<SubScreen2B> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _skinfold1Controller = TextEditingController();
  final TextEditingController _skinfold2Controller = TextEditingController();
  final TextEditingController _skinfold3Controller = TextEditingController();
  String _gender = 'Male';
  double _bodyFatPercentage = 0.0;
  String _fatCategory = '';
  double _leanBodyMass = 0.0;

  void _calculateBodyFat() {
    if (_ageController.text.isEmpty || _weightController.text.isEmpty || _skinfold1Controller.text.isEmpty || _skinfold2Controller.text.isEmpty || _skinfold3Controller.text.isEmpty) {
      setState(() => _fatCategory = 'Please enter all required values.');
      return;
    }
    double age = double.tryParse(_ageController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;
    double skinfold1 = double.tryParse(_skinfold1Controller.text) ?? 0;
    double skinfold2 = double.tryParse(_skinfold2Controller.text) ?? 0;
    double skinfold3 = double.tryParse(_skinfold3Controller.text) ?? 0;
    double sumOfSkinfolds = skinfold1 + skinfold2 + skinfold3;
    if (age <= 0 || weight <= 0 || skinfold1 <= 0 || skinfold2 <= 0 || skinfold3 <= 0) {
      setState(() => _fatCategory = 'Please enter valid values.');
      return;
    }
    double bodyDensity = _gender == 'Male'
        ? 1.10938 - (0.0008267 * sumOfSkinfolds) + (0.0000016 * sumOfSkinfolds * sumOfSkinfolds) - (0.0002574 * age)
        : 1.0994921 - (0.0009929 * sumOfSkinfolds) + (0.0000023 * sumOfSkinfolds * sumOfSkinfolds) - (0.0001392 * age);
    setState(() {
      _bodyFatPercentage = (495 / bodyDensity) - 450;
      _leanBodyMass = weight * (1 - (_bodyFatPercentage / 100));
      _fatCategory = _gender == 'Male'
          ? (_bodyFatPercentage <= 6 ? 'Essential Fat' : _bodyFatPercentage <= 14 ? 'Athlete' : _bodyFatPercentage <= 18 ? 'Fitness' : _bodyFatPercentage <= 25 ? 'Average' : 'Obese')
          : (_bodyFatPercentage <= 14 ? 'Essential Fat' : _bodyFatPercentage <= 21 ? 'Athlete' : _bodyFatPercentage <= 25 ? 'Fitness' : _bodyFatPercentage <= 32 ? 'Average' : 'Obese');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Fat Calculator ⚖️')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _gender,
                items: ['Male', 'Female'].map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
              const SizedBox(height: 10),
              Text(_gender == 'Male' ? 'Skinfolds: Chest, Abdomen, Thigh (mm)' : 'Skinfolds: Triceps, Suprailiac, Thigh (mm)', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder(), hintText: 'e.g., 30'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder(), hintText: 'e.g., 70'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _skinfold1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: _gender == 'Male' ? 'Chest (mm)' : 'Triceps (mm)', border: const OutlineInputBorder(), hintText: 'e.g., 10'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _skinfold2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: _gender == 'Male' ? 'Abdomen (mm)' : 'Suprailiac (mm)', border: const OutlineInputBorder(), hintText: 'e.g., 15'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _skinfold3Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Thigh (mm)', border: OutlineInputBorder(), hintText: 'e.g., 12'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBodyFat,
                child: const Text('Calculate Body Fat'),
              ),
              const SizedBox(height: 20),
              Text('Body Fat: ${_bodyFatPercentage.toStringAsFixed(2)}%', style: const TextStyle(fontSize: 18)),
              Text('Category: $_fatCategory', style: const TextStyle(fontSize: 18)),
              Text('Lean Body Mass: ${_leanBodyMass.toStringAsFixed(2)} kg', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 2C (Waist Circumference)
class SubScreen2C extends StatefulWidget {
  const SubScreen2C({Key? key}) : super(key: key);

  @override
  _SubScreen2CState createState() => _SubScreen2CState();
}

class _SubScreen2CState extends State<SubScreen2C> {
  final TextEditingController _waistController = TextEditingController();
  String _gender = 'Male';
  String _risk = '';

  void _assessWaist() {
    if (_waistController.text.isEmpty) {
      setState(() => _risk = 'Please enter waist circumference.');
      return;
    }
    double waist = double.tryParse(_waistController.text) ?? 0;
    if (waist <= 0) {
      setState(() => _risk = 'Please enter a valid value.');
      return;
    }
    setState(() {
      _risk = _gender == 'Male'
          ? (waist <= 94 ? 'Low Risk' : waist <= 102 ? 'Moderate Risk' : 'High Risk')
          : (waist <= 80 ? 'Low Risk' : waist <= 88 ? 'Moderate Risk' : 'High Risk');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waist Circumference 📏')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _gender,
                items: ['Male', 'Female'].map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _waistController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Waist (cm)', border: OutlineInputBorder(), hintText: 'e.g., 85'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _assessWaist,
                child: const Text('Assess Risk'),
              ),
              const SizedBox(height: 20),
              Text('Risk Level: $_risk', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 4A (Breath Holding Capacity)
class SubScreen4A extends StatefulWidget {
  const SubScreen4A({Key? key}) : super(key: key);

  @override
  _SubScreen4AState createState() => _SubScreen4AState();
}

class _SubScreen4AState extends State<SubScreen4A> {
  int _milliseconds = 0;
  bool _isRunning = false;
  String _capacityLevel = '';
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _milliseconds = 0;
      _isRunning = true;
      _capacityLevel = '';
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isRunning) setState(() => _milliseconds += 100);
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      int seconds = _milliseconds ~/ 1000;
      _capacityLevel = seconds < 20 ? 'Poor (Consult a doctor)' : seconds < 40 ? 'Average' : seconds < 60 ? 'Good' : seconds < 90 ? 'Excellent' : 'Superior';
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _milliseconds = 0;
      _capacityLevel = '';
      _timer?.cancel();
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds ~/ 1000);
    int minutes = (seconds ~/ 60);
    seconds = seconds % 60;
    int millis = (milliseconds % 1000) ~/ 100;
    return '$minutes:${seconds.toString().padLeft(2, '0')}.$millis';
  }

  @override
  Widget build(BuildContext context) {
    double progress = _milliseconds / (90 * 1000); // Max 90 seconds
    return Scaffold(
      appBar: AppBar(title: const Text('Breath Holding ⏳')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hold your breath and start the timer.\nStop when you need to breathe.', style: TextStyle(fontSize: 16, color: Colors.black87), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: _isRunning ? progress.clamp(0.0, 1.0) : 0.0,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                    ),
                  ),
                  Text(_formatTime(_milliseconds), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? null : _startTimer,
                    child: const Text('Start'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _isRunning ? _stopTimer : null,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Stop'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Capacity Level: $_capacityLevel', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 4B (Resting Heart Rate)
class SubScreen4B extends StatefulWidget {
  const SubScreen4B({Key? key}) : super(key: key);

  @override
  _SubScreen4BState createState() => _SubScreen4BState();
}

class _SubScreen4BState extends State<SubScreen4B> {
  int _milliseconds = 0;
  bool _isRunning = false;
  int _pulseCount = 0;
  double _rhr = 0.0;
  String _fitnessLevel = '';
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _milliseconds = 0;
      _pulseCount = 0;
      _rhr = 0.0;
      _fitnessLevel = '';
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isRunning) setState(() => _milliseconds += 100);
    });
  }

  void _incrementPulse() {
    if (_isRunning) setState(() => _pulseCount++);
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      double seconds = _milliseconds / 1000;
      _rhr = (_pulseCount / seconds) * 60;
      _fitnessLevel = _rhr < 60 ? 'Athlete' : _rhr <= 74 ? 'Excellent' : _rhr <= 84 ? 'Good' : _rhr <= 100 ? 'Average' : 'Poor (Consult a doctor)';
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _milliseconds = 0;
      _pulseCount = 0;
      _rhr = 0.0;
      _fitnessLevel = '';
      _timer?.cancel();
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds ~/ 1000);
    int minutes = (seconds ~/ 60);
    seconds = seconds % 60;
    int millis = (milliseconds % 1000) ~/ 100;
    return '$minutes:${seconds.toString().padLeft(2, '0')}.$millis';
  }

  @override
  Widget build(BuildContext context) {
    double progress = _pulseCount / 100; // Arbitrary max of 100 pulses
    return Scaffold(
      appBar: AppBar(title: const Text('Resting Heart Rate 💓')),
      body: GestureDetector(
        onTap: _isRunning ? _incrementPulse : null,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Tap anywhere on the screen for each pulse.\nStart the timer when ready.', style: TextStyle(fontSize: 16, color: Colors.black87), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: _isRunning ? progress.clamp(0.0, 1.0) : 0.0,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                      ),
                    ),
                    Text(_formatTime(_milliseconds), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Pulse Count: $_pulseCount', style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isRunning ? null : _startTimer,
                      child: const Text('Start'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isRunning ? _stopTimer : null,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Stop'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _resetTimer,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('RHR: ${_rhr.toStringAsFixed(0)} bpm', style: const TextStyle(fontSize: 18)),
                Text('Fitness Level: $_fitnessLevel', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 5A (BMR Calculator)
class SubScreen5A extends StatefulWidget {
  const SubScreen5A({Key? key}) : super(key: key);

  @override
  _SubScreen5AState createState() => _SubScreen5AState();
}

class _SubScreen5AState extends State<SubScreen5A> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _gender = 'Male';
  double _bmr = 0.0;

  void _calculateBMR() {
    if (_ageController.text.isEmpty || _heightController.text.isEmpty || _weightController.text.isEmpty) {
      setState(() => _bmr = 0.0);
      return;
    }
    double age = double.tryParse(_ageController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;
    if (age <= 0 || height <= 0 || weight <= 0) {
      setState(() => _bmr = 0.0);
      return;
    }
    setState(() {
      _bmr = _gender == 'Male'
          ? 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
          : 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMR Calculator 🔥')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _gender,
                items: ['Male', 'Female'].map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder(), hintText: 'e.g., 30'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder(), hintText: 'e.g., 170'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder(), hintText: 'e.g., 70'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMR,
                child: const Text('Calculate BMR'),
              ),
              const SizedBox(height: 20),
              Text('BMR: ${_bmr.toStringAsFixed(0)} kcal/day', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 5B (TDEE Calculator)
class SubScreen5B extends StatefulWidget {
  const SubScreen5B({Key? key}) : super(key: key);

  @override
  _SubScreen5BState createState() => _SubScreen5BState();
}

class _SubScreen5BState extends State<SubScreen5B> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _gender = 'Male';
  String _activityLevel = 'Sedentary';
  double _tdee = 0.0;

  void _calculateTDEE() {
    if (_ageController.text.isEmpty || _heightController.text.isEmpty || _weightController.text.isEmpty) {
      setState(() => _tdee = 0.0);
      return;
    }
    double age = double.tryParse(_ageController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;
    if (age <= 0 || height <= 0 || weight <= 0) {
      setState(() => _tdee = 0.0);
      return;
    }
    double bmr = _gender == 'Male'
        ? 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
        : 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    double activityFactor = _activityLevel == 'Sedentary' ? 1.2 : _activityLevel == 'Lightly Active' ? 1.375 : _activityLevel == 'Moderately Active' ? 1.55 : _activityLevel == 'Very Active' ? 1.725 : 1.9;
    setState(() => _tdee = bmr * activityFactor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TDEE Calculator ⚡')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _gender,
                items: ['Male', 'Female'].map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder(), hintText: 'e.g., 30'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder(), hintText: 'e.g., 170'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder(), hintText: 'e.g., 70'),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _activityLevel,
                items: ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active', 'Extremely Active']
                    .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) => setState(() => _activityLevel = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateTDEE,
                child: const Text('Calculate TDEE'),
              ),
              const SizedBox(height: 20),
              Text('TDEE: ${_tdee.toStringAsFixed(0)} kcal/day', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 6A (Waist-to-Hip Ratio)
class SubScreen6A extends StatefulWidget {
  const SubScreen6A({Key? key}) : super(key: key);

  @override
  _SubScreen6AState createState() => _SubScreen6AState();
}

class _SubScreen6AState extends State<SubScreen6A> {
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();
  String _gender = 'Male';
  double _whr = 0.0;
  String _risk = '';

  void _calculateWHR() {
    if (_waistController.text.isEmpty || _hipController.text.isEmpty) {
      setState(() => _risk = 'Please enter both measurements.');
      return;
    }
    double waist = double.tryParse(_waistController.text) ?? 0;
    double hip = double.tryParse(_hipController.text) ?? 0;
    if (waist <= 0 || hip <= 0) {
      setState(() => _risk = 'Please enter valid values.');
      return;
    }
    setState(() {
      _whr = waist / hip;
      _risk = _gender == 'Male'
          ? (_whr < 0.9 ? 'Low Risk' : _whr <= 1.0 ? 'Moderate Risk' : 'High Risk')
          : (_whr < 0.85 ? 'Low Risk' : _whr <= 0.9 ? 'Moderate Risk' : 'High Risk');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waist-to-Hip Ratio 📐')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _gender,
                items: ['Male', 'Female'].map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _waistController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Waist (cm)', border: OutlineInputBorder(), hintText: 'e.g., 85'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _hipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Hip (cm)', border: OutlineInputBorder(), hintText: 'e.g., 95'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateWHR,
                child: const Text('Calculate WHR'),
              ),
              const SizedBox(height: 20),
              Text('WHR: ${_whr.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
              Text('Risk Level: $_risk', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-Screen 6B (Waist-to-Height Ratio)
class SubScreen6B extends StatefulWidget {
  const SubScreen6B({Key? key}) : super(key: key);

  @override
  _SubScreen6BState createState() => _SubScreen6BState();
}

class _SubScreen6BState extends State<SubScreen6B> {
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _whtr = 0.0;
  String _risk = '';

  void _calculateWHtR() {
    if (_waistController.text.isEmpty || _heightController.text.isEmpty) {
      setState(() => _risk = 'Please enter both measurements.');
      return;
    }
    double waist = double.tryParse(_waistController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    if (waist <= 0 || height <= 0) {
      setState(() => _risk = 'Please enter valid values.');
      return;
    }
    setState(() {
      _whtr = waist / height;
      _risk = _whtr < 0.5 ? 'Healthy' : _whtr <= 0.6 ? 'Increased Risk' : 'High Risk';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waist-to-Height Ratio 📏')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _waistController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Waist (cm)', border: OutlineInputBorder(), hintText: 'e.g., 85'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder(), hintText: 'e.g., 170'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateWHtR,
                child: const Text('Calculate WHtR'),
              ),
              const SizedBox(height: 20),
              Text('WHtR: ${_whtr.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
              Text('Risk Level: $_risk', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}