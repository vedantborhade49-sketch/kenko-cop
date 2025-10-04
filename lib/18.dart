import 'package:flutter/material.dart';

void main() {
  runApp(const LabTestApp());
}

class LabTestApp extends StatelessWidget {
  const LabTestApp({super.key});

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
      home: const LabTestHomeScreen(),
    );
  }
}

class LabTestHomeScreen extends StatelessWidget {
  const LabTestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Test Hub 🧪'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Testing Option',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _OptionCard(
                title: 'Order Lab Tests at Home 🏠',
                description: 'Get samples collected from your doorstep.',
                emoji: '💉',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeLabTestScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _OptionCard(
                title: 'Visit Nearby Labs 📍',
                description: 'Find and book tests at local labs.',
                emoji: '🩺',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NearbyLabScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String emoji;
  final VoidCallback onTap;

  const _OptionCard({required this.title, required this.description, required this.emoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(description, style: const TextStyle(fontSize: 14, color: Colors.black54)),
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

// --- Home Lab Test Screen ---
class HomeLabTestScreen extends StatelessWidget {
  const HomeLabTestScreen({super.key});

  final List<LabTest> _tests = const [
    LabTest(
      name: 'Complete Blood Count (CBC)',
      purpose: 'Evaluates overall health, detects infections, anemia, and blood disorders.',
      howTo: 'A phlebotomist collects a small blood sample from your arm.',
      prep: 'No fasting required, but avoid heavy meals before.',
      emoji: '🩺',
    ),
    LabTest(
      name: 'Lipid Profile',
      purpose: 'Measures cholesterol levels to assess heart disease risk.',
      howTo: 'Blood sample taken after fasting for 9-12 hours.',
      prep: 'Fast for 9-12 hours; drink only water.',
      emoji: '❤️',
    ),
    LabTest(
      name: 'Blood Glucose Test',
      purpose: 'Checks blood sugar levels to screen for diabetes.',
      howTo: 'Finger prick or venous blood sample, often after fasting.',
      prep: 'Fast for 8 hours if fasting glucose is required.',
      emoji: '🍬',
    ),
    LabTest(
      name: 'Thyroid Function Test',
      purpose: 'Assesses thyroid hormone levels for metabolism issues.',
      howTo: 'Blood sample from your arm, no special prep.',
      prep: 'Inform about medications; no fasting needed.',
      emoji: '🦋',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Lab Tests at Home 🏠'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _tests.length,
          itemBuilder: (context, index) {
            final test = _tests[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                leading: Text(test.emoji, style: const TextStyle(fontSize: 30)),
                title: Text(test.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Purpose: ${test.purpose}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('How It’s Done: ${test.howTo}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('Preparation: ${test.prep}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Booking ${test.name} for home collection! 📅')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Order Now 🏠', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- Nearby Lab Screen ---
class NearbyLabScreen extends StatelessWidget {
  const NearbyLabScreen({super.key});

  final List<LabLocation> _labs = const [
    LabLocation(
      name: 'City Diagnostics',
      distance: '2.5 km',
      tests: ['CBC', 'Lipid Profile', 'Blood Glucose', 'Urinalysis'],
      address: '123 Health St, Downtown',
      contact: '+1-555-123-4567',
      emoji: '🏥',
    ),
    LabLocation(
      name: 'Suburban Labs',
      distance: '5.8 km',
      tests: ['Thyroid Function', 'CBC', 'Vitamin D', 'Kidney Panel'],
      address: '456 Wellness Ave, Suburbia',
      contact: '+1-555-987-6543',
      emoji: '🩺',
    ),
    LabLocation(
      name: 'QuickTest Center',
      distance: '1.2 km',
      tests: ['Blood Glucose', 'Cholesterol', 'STD Panel'],
      address: '789 Fast Ln, Nearby',
      contact: '+1-555-456-7890',
      emoji: '⚡',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Labs 📍'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _labs.length,
          itemBuilder: (context, index) {
            final lab = _labs[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                leading: Text(lab.emoji, style: const TextStyle(fontSize: 30)),
                title: Text('${lab.name} (${lab.distance})', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(lab.address),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Available Tests: ${lab.tests.join(", ")}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('Contact: ${lab.contact}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        const Text('Hours: Mon-Fri 8 AM - 6 PM, Sat 9 AM - 2 PM', style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Booking a visit to ${lab.name}! 📅')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Book Visit 📍', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- Data Models ---
class LabTest {
  final String name;
  final String purpose;
  final String howTo;
  final String prep;
  final String emoji;

  const LabTest({required this.name, required this.purpose, required this.howTo, required this.prep, required this.emoji});
}

class LabLocation {
  final String name;
  final String distance;
  final List<String> tests;
  final String address;
  final String contact;
  final String emoji;

  const LabLocation({
    required this.name,
    required this.distance,
    required this.tests,
    required this.address,
    required this.contact,
    required this.emoji,
  });
}