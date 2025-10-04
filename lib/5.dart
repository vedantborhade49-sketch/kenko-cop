import 'package:flutter/material.dart';

void main() {
  runApp(const SaveReportsApp());
}

class SaveReportsApp extends StatelessWidget {
  const SaveReportsApp({super.key});

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
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SaveYourReports(),
    );
  }
}

class SaveYourReports extends StatelessWidget {
  const SaveYourReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Your Reports 💾'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Report Types'),
              const SizedBox(height: 16),
              _buildReportTypeCard(
                  context, 'MRI Reports', '🧠', const MRIReportsScreen()),
              _buildReportTypeCard(context, 'CT Scan Reports', '🖥️',
                  const CTScanReportsScreen()),
              _buildReportTypeCard(
                  context, 'X-Ray Reports', '🦴', const XRayReportsScreen()),
              _buildReportTypeCard(context, 'Lab Test Reports', '🧪',
                  const LabTestReportsScreen()),
              _buildReportTypeCard(context, 'Ultrasound Reports', '📡',
                  const UltrasoundReportsScreen()),
              const SizedBox(height: 24),
              _buildSectionTitle('Report Categories'),
              const SizedBox(height: 16),
              _buildReportCategoryCard(context, 'Transitory Reports', '📄',
                  const TransitoryReportsScreen()),
              _buildReportCategoryCard(context, 'Official Reports', '📑',
                  const OfficialReportsScreen()),
              _buildReportCategoryCard(context, 'Permanent Reports', '📂',
                  const PermanentReportsScreen()),
              const SizedBox(height: 24),
              _buildSectionTitle('Additional Features'),
              const SizedBox(height: 16),
              _buildFeatureCard(
                  context, 'Search Reports', '🔍', const SearchReportsScreen()),
              _buildFeatureCard(
                  context, 'Export Reports', '📤', const ExportReportsScreen()),
              _buildFeatureCard(
                  context, 'Backup Reports', '💾', const BackupReportsScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildReportTypeCard(
      BuildContext context, String title, String emoji, Widget page) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
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
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Upload or capture your reports',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Text("➡️",
                  style: TextStyle(fontSize: 24, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCategoryCard(
      BuildContext context, String title, String emoji, Widget page) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
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
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Organize your reports by category',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Text("➡️",
                  style: TextStyle(fontSize: 24, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, String emoji, Widget page) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
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
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explore additional features',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Text("➡️",
                  style: TextStyle(fontSize: 24, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}

// MRI Reports Screen
class MRIReportsScreen extends StatelessWidget {
  const MRIReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MRI Reports 🧠'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MRI Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('MRI Report 1', 'Brain Scan', context),
              _buildReportItem('MRI Report 2', 'Spine Scan', context),
              _buildReportItem('MRI Report 3', 'Knee Scan', context),
            ],
          ),
        ),
      ),
    );
  }
}

// CT Scan Reports Screen
class CTScanReportsScreen extends StatelessWidget {
  const CTScanReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CT Scan Reports 🖥️'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CT Scan Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('CT Scan Report 1', 'Chest Scan', context),
              _buildReportItem('CT Scan Report 2', 'Abdomen Scan', context),
              _buildReportItem('CT Scan Report 3', 'Head Scan', context),
            ],
          ),
        ),
      ),
    );
  }
}

// X-Ray Reports Screen
class XRayReportsScreen extends StatelessWidget {
  const XRayReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X-Ray Reports 🦴'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'X-Ray Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('X-Ray Report 1', 'Chest X-Ray', context),
              _buildReportItem('X-Ray Report 2', 'Leg X-Ray', context),
              _buildReportItem('X-Ray Report 3', 'Spine X-Ray', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Lab Test Reports Screen
class LabTestReportsScreen extends StatelessWidget {
  const LabTestReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Test Reports 🧪'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lab Test Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem(
                  'Blood Test Report', 'Complete Blood Count', context),
              _buildReportItem('Urine Test Report', 'Urinalysis', context),
              _buildReportItem(
                  'Biochemistry Report', 'Liver Function Test', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Ultrasound Reports Screen
class UltrasoundReportsScreen extends StatelessWidget {
  const UltrasoundReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultrasound Reports 📡'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ultrasound Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Ultrasound Report 1', 'Abdomen Scan', context),
              _buildReportItem('Ultrasound Report 2', 'Pelvic Scan', context),
              _buildReportItem('Ultrasound Report 3', 'Thyroid Scan', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Transitory Reports Screen
class TransitoryReportsScreen extends StatelessWidget {
  const TransitoryReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transitory Reports 📄'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transitory Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Report 1', 'Temporary Report', context),
              _buildReportItem('Report 2', 'Preliminary Findings', context),
              _buildReportItem('Report 3', 'Draft Report', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Official Reports Screen
class OfficialReportsScreen extends StatelessWidget {
  const OfficialReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Reports 📑'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Official Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Report 1', 'Final Diagnosis', context),
              _buildReportItem('Report 2', 'Discharge Summary', context),
              _buildReportItem('Report 3', 'Lab Results', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Permanent Reports Screen
class PermanentReportsScreen extends StatelessWidget {
  const PermanentReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permanent Reports 📂'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Permanent Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Report 1', 'Medical History', context),
              _buildReportItem('Report 2', 'Surgical Records', context),
              _buildReportItem('Report 3', 'Insurance Documents', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Search Reports Screen
class SearchReportsScreen extends StatelessWidget {
  const SearchReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Reports 🔍'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Report 1', 'Search by Date', context),
              _buildReportItem('Report 2', 'Search by Type', context),
              _buildReportItem('Report 3', 'Search by Category', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Export Reports Screen
class ExportReportsScreen extends StatelessWidget {
  const ExportReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Reports 📤'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Export Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Report 1', 'Export as PDF', context),
              _buildReportItem('Report 2', 'Export as CSV', context),
              _buildReportItem('Report 3', 'Export as Image', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Backup Reports Screen
class BackupReportsScreen extends StatelessWidget {
  const BackupReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup Reports 💾'),
        centerTitle: true,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Backup Reports',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              _buildReportItem('Report 1', 'Backup to Cloud', context),
              _buildReportItem('Report 2', 'Backup to Device', context),
              _buildReportItem('Report 3', 'Backup to External Drive', context),
            ],
          ),
        ),
      ),
    );
  }
}

// Report Item Widget
Widget _buildReportItem(
    String title, String description, BuildContext context) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      leading:
          const Text("📄", style: TextStyle(fontSize: 24, color: Colors.blue)),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87)),
      subtitle:
          Text(description, style: const TextStyle(color: Colors.black54)),
      trailing:
          const Text("➡️", style: TextStyle(fontSize: 24, color: Colors.blue)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportDetailsPage(
              title: title,
              content: "This is a sample $description. Random data goes here.",
            ),
          ),
        );
      },
    ),
  );
}

// Report Details Page
class ReportDetailsPage extends StatelessWidget {
  final String title;
  final String content;

  const ReportDetailsPage(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title 📄"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade100],
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
                    const Text("📝",
                        style: TextStyle(fontSize: 24, color: Colors.blue)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
