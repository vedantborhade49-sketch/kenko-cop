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
    home: const PatientsDashboard(),
  ));
}

class PatientsDashboard extends StatelessWidget {
  const PatientsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient's Dashboard 🏥"),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Real-Time Clock
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("⏰ ", style: TextStyle(fontSize: 40, color: Colors.blue)),
                          Text(
                            _getCurrentTime(),
                            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Profile Section
              _buildProfileSection(context),
              const SizedBox(height: 20),

              // Quick Actions Section
              _buildQuickActionsSection(context),
              const SizedBox(height: 20),

              // Health Summary Section
              _buildHealthSummarySection(),
              const SizedBox(height: 20),

              // Medication Reminders Section
              _buildMedicationRemindersSection(context),
              const SizedBox(height: 20),

              // Recent Medical Reports & Prescriptions
              _buildRecentReportsSection(context),
              const SizedBox(height: 20),

              // Personalized Health Insights
              _buildHealthInsightsSection(),
              const SizedBox(height: 20),

              // Emergency Contacts Section
              _buildEmergencyContactsSection(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Dashboard refreshed! 🔄")),
          );
        },
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Text("🔄", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  // Profile Section
  Widget _buildProfileSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue,
              child: Text("👤", style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello, User! 👋",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const Text(
                    "Stay healthy & track your records!",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileDetailsPage()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Opening profile...")),
                      );
                    },
                    icon: const Text("📋", style: TextStyle(fontSize: 24, color: Colors.white)),
                    label: const Text("View Profile", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Actions Section
  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions ⚡",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuickAction("Book Appointment", "📅", Colors.green, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAppointmentPage()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Opening appointment booking...")),
              );
            }),
            _buildQuickAction("View Reports", "📄", Colors.orange, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewReportsPage()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Opening reports...")),
              );
            }),
            _buildQuickAction("Contact Doctor", "📞", Colors.red, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactDoctorPage()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Opening doctor contact...")),
              );
            }),
          ],
        ),
      ],
    );
  }

  // Health Summary Section
  Widget _buildHealthSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Health Summary 📊",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHealthCard("Heart Rate", "78 bpm", Colors.red.shade100, "❤️"),
            _buildHealthCard("Blood Pressure", "120/80", Colors.green.shade100, "🩺"),
            _buildHealthCard("Sugar Level", "95 mg/dL", Colors.purple.shade100, "💉"),
          ],
        ),
      ],
    );
  }

  // Medication Reminders Section
  Widget _buildMedicationRemindersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Medication Reminders 💊",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildMedicationReminder("Paracetamol", "8:00 AM", "Take after breakfast"),
        _buildMedicationReminder("Metformin", "1:00 PM", "Take with lunch"),
        _buildMedicationReminder("Atorvastatin", "8:00 PM", "Take before bed"),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicationRemindersPage()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Opening all reminders...")),
            );
          },
          icon: const Text("⏰", style: TextStyle(fontSize: 24, color: Colors.white)),
          label: const Text("View All Reminders", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  // Recent Medical Reports & Prescriptions
  Widget _buildRecentReportsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Medical Reports & Prescriptions 📋",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildRecentItem("Blood Test Report", "12 Feb 2025", "View Details", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportDetailsPage()));
        }),
        _buildRecentItem("X-Ray Report", "10 Feb 2025", "View Details", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportDetailsPage()));
        }),
        _buildRecentItem("Prescription: Diabetes Control", "8 Feb 2025", "View Details", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrescriptionDetailsPage()));
        }),
      ],
    );
  }

  // Personalized Health Insights
  Widget _buildHealthInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Personalized Health Insights 💡",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildInsightItem("Your blood pressure is stable. Keep monitoring it weekly!"),
        _buildInsightItem("Consider a low-sugar diet to maintain a healthy glucose level."),
      ],
    );
  }

  // Emergency Contacts Section
  Widget _buildEmergencyContactsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Emergency Contacts 🚨",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildEmergencyContact("Dr. John Doe", "Cardiologist", "+91 9876543210"),
        _buildEmergencyContact("Dr. Jane Smith", "General Physician", "+91 9876543211"),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const EmergencyContactsPage()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Opening all contacts...")),
            );
          },
          icon: const Text("📞", style: TextStyle(fontSize: 24, color: Colors.white)),
          label: const Text("View All Contacts", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  // Reusable Widgets
  Widget _buildHealthCard(String title, String value, Color color, String emoji) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, String emoji, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(emoji, style: TextStyle(fontSize: 30, color: color)),
            ),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRecentItem(String title, String date, String actionText, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      child: ListTile(
        leading: const Text("📄", style: TextStyle(fontSize: 24, color: Colors.blue)),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text(date, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        trailing: TextButton(
          onPressed: onTap,
          child: const Text("View Details", style: TextStyle(color: Colors.blue)),
        ),
      ),
    );
  }

  Widget _buildInsightItem(String insight) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Text("💡", style: TextStyle(fontSize: 24, color: Colors.orange)),
            const SizedBox(width: 10),
            Expanded(child: Text(insight, style: const TextStyle(fontSize: 14, color: Colors.black87))),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationReminder(String medicine, String time, String instructions) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      child: ListTile(
        leading: const Text("💊", style: TextStyle(fontSize: 24, color: Colors.green)),
        title: Text(medicine, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text("Time: $time\n$instructions", style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String specialization, String phone) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      child: ListTile(
        leading: const Text("👨‍⚕️", style: TextStyle(fontSize: 24, color: Colors.red)),
        title: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text("$specialization\n$phone", style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ),
    );
  }
}

// Redirectory Pages (Placeholder Pages)
class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Details 👤"),
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
        child: const Center(child: Text("Profile Details Page")),
      ),
    );
  }
}

class BookAppointmentPage extends StatelessWidget {
  const BookAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment 📅"),
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
        child: const Center(child: Text("Book Appointment Page")),
      ),
    );
  }
}

class ViewReportsPage extends StatelessWidget {
  const ViewReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Reports 📄"),
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
        child: const Center(child: Text("View Reports Page")),
      ),
    );
  }
}

class ContactDoctorPage extends StatelessWidget {
  const ContactDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Doctor 📞"),
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
        child: const Center(child: Text("Contact Doctor Page")),
      ),
    );
  }
}

class MedicationRemindersPage extends StatelessWidget {
  const MedicationRemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Reminders 💊"),
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
        child: const Center(child: Text("Medication Reminders Page")),
      ),
    );
  }
}

class ReportDetailsPage extends StatelessWidget {
  const ReportDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Details 📄"),
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
        child: const Center(child: Text("Report Details Page")),
      ),
    );
  }
}

class PrescriptionDetailsPage extends StatelessWidget {
  const PrescriptionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription Details 📋"),
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
        child: const Center(child: Text("Prescription Details Page")),
      ),
    );
  }
}

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts 🚨"),
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
        child: const Center(child: Text("Emergency Contacts Page")),
      ),
    );
  }
}