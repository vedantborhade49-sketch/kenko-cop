import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// Health metric model
class HealthMetric {
  final String name;
  final String unit;
  final Map<String, Map<String, double>> ranges; // e.g., {'normal': {'min': 70, 'max': 100}}

  HealthMetric(this.name, this.unit, this.ranges);
}

// Comprehensive list of medical metrics with standard ranges
final Map<String, HealthMetric> healthRanges = {
  'glucose': HealthMetric('Glucose', 'mg/dL', {
    'normal': {'min': 70, 'max': 100},
    'prediabetes': {'min': 100, 'max': 125},
    'diabetes': {'min': 126, 'max': double.infinity},
    'low': {'min': 0, 'max': 70},
  }),
  'cholesterol_total': HealthMetric('Total Cholesterol', 'mg/dL', {
    'normal': {'min': 0, 'max': 200},
    'borderline': {'min': 200, 'max': 239},
    'high': {'min': 240, 'max': double.infinity},
  }),
  'hdl_cholesterol': HealthMetric('HDL Cholesterol', 'mg/dL', {
    'low': {'min': 0, 'max': 40},
    'normal': {'min': 40, 'max': 60},
    'high': {'min': 60, 'max': double.infinity}, // High HDL is good
  }),
  'ldl_cholesterol': HealthMetric('LDL Cholesterol', 'mg/dL', {
    'optimal': {'min': 0, 'max': 100},
    'near_optimal': {'min': 100, 'max': 129},
    'borderline': {'min': 130, 'max': 159},
    'high': {'min': 160, 'max': 189},
    'very_high': {'min': 190, 'max': double.infinity},
  }),
  'triglycerides': HealthMetric('Triglycerides', 'mg/dL', {
    'normal': {'min': 0, 'max': 150},
    'borderline': {'min': 150, 'max': 199},
    'high': {'min': 200, 'max': 499},
    'very_high': {'min': 500, 'max': double.infinity},
  }),
  'systolic_bp': HealthMetric('Systolic Blood Pressure', 'mmHg', {
    'normal': {'min': 0, 'max': 120},
    'elevated': {'min': 120, 'max': 129},
    'hypertension_stage_1': {'min': 130, 'max': 139},
    'hypertension_stage_2': {'min': 140, 'max': double.infinity},
  }),
  'diastolic_bp': HealthMetric('Diastolic Blood Pressure', 'mmHg', {
    'normal': {'min': 0, 'max': 80},
    'hypertension_stage_1': {'min': 80, 'max': 89},
    'hypertension_stage_2': {'min': 90, 'max': double.infinity},
  }),
  'hemoglobin': HealthMetric('Hemoglobin', 'g/dL', {
    'normal_male': {'min': 13.8, 'max': 17.2},
    'normal_female': {'min': 12.1, 'max': 15.1},
    'low': {'min': 0, 'max': 12.1}, // Adjust based on gender later
  }),
  'creatinine': HealthMetric('Creatinine', 'mg/dL', {
    'normal_male': {'min': 0.7, 'max': 1.2},
    'normal_female': {'min': 0.6, 'max': 1.1},
    'high': {'min': 1.2, 'max': double.infinity},
  }),
  'urea': HealthMetric('Urea (BUN)', 'mg/dL', {
    'normal': {'min': 7, 'max': 20},
    'high': {'min': 20, 'max': double.infinity},
  }),
};

// Analysis logic
Map<String, String> analyzeHealthReport(String text) {
  final Map<String, String> results = {};
  final RegExp bpPattern = RegExp(r'(?:bp|blood pressure)[:\s]*(\d+)/(\d+)\s*mmHg', caseSensitive: false);

  // Extract BP separately
  final bpMatch = bpPattern.firstMatch(text);
  if (bpMatch != null) {
    final systolic = double.tryParse(bpMatch.group(1)!) ?? 0;
    final diastolic = double.tryParse(bpMatch.group(2)!) ?? 0;
    results['systolic_bp'] = _getStatus('systolic_bp', systolic);
    results['diastolic_bp'] = _getStatus('diastolic_bp', diastolic);
  }

  // Extract other metrics
  healthRanges.forEach((key, metric) {
    if (key.contains('bp')) return; // Skip BP, handled above
    final pattern = RegExp('${metric.name}\\s*[:=]?\\s*(\\d+\\.?\\d*)\\s*${metric.unit}', caseSensitive: false);
    final match = pattern.firstMatch(text);
    if (match != null) {
      final value = double.tryParse(match.group(1)!) ?? 0;
      results[key] = _getStatus(key, value);
    }
  });

  return results.isNotEmpty ? results : {'no_data': 'No key data found in the provided text.'};
}

String _getStatus(String key, double value) {
  final metric = healthRanges[key]!;
  String status = 'Unknown';
  metric.ranges.forEach((rangeName, range) {
    final min = range['min'] ?? 0;
    final max = range['max'] ?? double.infinity;
    if (value >= min && value < max) {
      status = rangeName.replaceAll('_', ' ').capitalize();
    }
  });
  return '$value ${metric.unit} - $status';
}

// Extension for capitalization
extension StringExtension on String {
  String capitalize() {
    return split(' ').map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '').join(' ');
  }
}

// Main app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Report Scanner',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HealthScannerScreen(),
    );
  }
}

class HealthScannerScreen extends StatefulWidget {
  const HealthScannerScreen({super.key});

  @override
  _HealthScannerScreenState createState() => _HealthScannerScreenState();
}

class _HealthScannerScreenState extends State<HealthScannerScreen> {
  final TextEditingController _textController = TextEditingController();
  Map<String, String> _results = {};
  String _fileName = 'No file selected';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt', 'png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        // For now, prompt user to enter text manually since PDF/OCR is unavailable
        _textController.text = 'Please enter the text from $_fileName manually.';
        _results = {};
      });
    }
  }

  void _analyzeText() {
    setState(() {
      _results = analyzeHealthReport(_textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Report Scanner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File picker section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload Report'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                Text(
                  _fileName,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Text input section
            const Text(
              'Enter Report Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'e.g., Glucose: 110 mg/dL, BP: 130/85 mmHg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16),
            // Analyze button
            Center(
              child: ElevatedButton(
                onPressed: _analyzeText,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Analyze Report'),
              ),
            ),
            const SizedBox(height: 16),
            // Results section
            const Text(
              'Health Insights:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _results.entries.map((entry) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          entry.key == 'no_data' ? 'Result' : entry.key.replaceAll('_', ' ').capitalize(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(entry.value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}