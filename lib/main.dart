import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '1.dart'; // MedicineAlarm
import '2.dart'; // AboutMe
import '3.dart'; // ConnectNGO
import '4.dart'; // WhatsGoingOn
import '5.dart'; // SaveYourReports
import '6.dart'; // NearbyFacilities
import '7.dart'; // BoxScreen (Health Options)
import '8.dart'; // GovernmentSchemes
import '9.dart'; // PatientsDashboard
import '10.dart'; // RemindersScreen
import '11.dart'; // ConsultDoctorScreen
import '12.dart'; // TrackHealthScreen
import '13.dart'; // NewbornWellness
import '14.dart'; // MyDietCoach
import '15.dart'; // HealthScannerScreen
import '16.dart'; // InsuranceScreen
import '17.dart'; // HealthTipsScreen
import '18.dart'; // LabTestHomeScreen
import '19.dart'; // FinanceHomeScreen
import '20.dart'; // HealthLoansDashboard
import '21.dart'; // SymptomCheckerScreen
import '22.dart'; // AyurvedaHomeScreen

void main() {
  runApp(const KenkoApp());
}

class KenkoApp extends StatelessWidget {
  const KenkoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue.shade700,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue.shade700,
          secondary: Colors.blue.shade100,
          background: Colors.white,
          onPrimary: Colors.white,
          onBackground: Colors.black87,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(
          const TextTheme(
            titleLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
            titleMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
            labelMedium: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            elevation: 3,
            shadowColor: Colors.blue.shade100.withOpacity(0.5),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintStyle: const TextStyle(color: Colors.black38),
          prefixIconColor: Colors.blue.shade700,
          labelStyle: const TextStyle(color: Colors.black54),
        ),
        cardColor: Colors.white,
        shadowColor: Colors.blue.shade100.withOpacity(0.5),
      ),
      home: const PasswordScreen(),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => PasswordScreenState();
}

class PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final String correctPassword = "1234";
  String errorMessage = "";
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void _checkPassword() {
    if (_passwordController.text == correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      setState(() {
        errorMessage = "Incorrect password. Try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "🩺",
                    style: TextStyle(fontSize: 120, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Kenko",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Enter Password to Access",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: errorMessage.isNotEmpty ? errorMessage : null,
                      errorStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _checkPassword,
                    child: const Text("Unlock"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: const AssetImage('assets/logo (2).png'),
                      backgroundColor: Colors.blue.shade100,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zeth",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Mumbai, India",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Search Bar
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Search health services...",
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 32),

                // Hero Section
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(
                      image: AssetImage('assets/hero.jpg'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Key Features Section
                Text(
                  "Key Features",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _keyFeatureCard(context, "About Me", "👤", const AboutMe()),
                const SizedBox(height: 12),
                _keyFeatureCard(context, "Patients Dashboard", "📊",
                    const PatientsDashboard()),
                const SizedBox(height: 12),
                _keyFeatureCard(context, "Consult Doctor", "📞",
                    const ConsultDoctorScreen()),
                const SizedBox(height: 32),

                // Upcoming Appointments
                _upcomingAppointmentsCard(context),
                const SizedBox(height: 32),

                // Hospitals Near You
                Text(
                  "Hospitals Near You",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _hospitalCard("Symbiosis Hospital", "2.3 km",
                          'assets/hospital1.png'),
                      const SizedBox(width: 16),
                      _hospitalCard("Skn Sinhgad Hospital", "3.1 km",
                          'assets/hospital2.jpg'),
                      const SizedBox(width: 16),
                      _hospitalCard("Dr DY Patil Hospital", "4.5 km",
                          'assets/hospital3.jpg'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Features Grid
                Text(
                  "All Features",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: _featureTiles(context),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotPage()),
              );
            },
            backgroundColor: Colors.blue.shade700,
            elevation: 3,
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Location feature coming soon!")),
              );
            },
            backgroundColor: Colors.blue.shade700,
            elevation: 3,
            heroTag: "locationButton",
            child: const Icon(Icons.location_on, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  // Key Feature Card
  Widget _keyFeatureCard(
      BuildContext context, String title, String emoji, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 10,
              offset: const Offset(-2, -2),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 32, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.blue.shade700,
            ),
          ],
        ),
      ),
    );
  }

  // Appointments Card
  Widget _upcomingAppointmentsCard(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 10,
            offset: const Offset(-2, -2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.blue.shade700,
            size: 40,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Appointment",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              const Text(
                "Dr. Smith • 12 Aug 2025",
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hospital Card
  Widget _hospitalCard(String name, String distance, String imagePath) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 10,
            offset: const Offset(-2, -2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
          ),
          Text(
            distance,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Feature Tiles
  List<Widget> _featureTiles(BuildContext context) {
    return [
      _tile(context, "Health Options", "❤️", const BoxScreen()),
      _tile(context, "Nearby Facilities", "🏥", const NearbyFacilities()),
      _tile(context, "Medicine Alarm", "⏰", const MedicineAlarm()),
      _tile(context, "Save Your Data", "💾", const SaveYourReports()),
      _tile(context, "What’s Going On", "📰", const WhatsGoingOn()),
      _tile(context, "Connect to NGO", "👥", const ConnectNGO()),
      _tile(context, "Govt Schemes", "✅", const GovernmentSchemes()),
      _tile(context, "Reminders", "🔔", const RemindersScreen()),
      _tile(context, "Track Health", "🩺", const TrackHealthScreen()),
      _tile(context, "Newborn Wellness", "👶", const NewbornWellness()),
      _tile(context, "My Diet Coach", "🍽️", const MyDietCoach()),
      _tile(context, "Health Scanner", "📋", const HealthScannerScreen()),
      _tile(context, "Medical Insurance", "💰", const InsuranceScreen()),
      _tile(context, "Health Tips", "🌟", const HealthTipsScreen()),
      _tile(context, "Lab Tests", "🧪", const LabTestHomeScreen()),
      _tile(context, "Finance Manager", "💸", const FinanceHomeScreen()),
      _tile(context, "Health Loans", "💳", const HealthLoansDashboard()),
      _tile(context, "Symptom Checker", "🤒", const SymptomCheckerScreen()),
      _tile(context, "Ayurveda Remedies", "🌿", const AyurvedaHomeScreen()),
    ];
  }

  // Feature Tile Widget
  Widget _tile(BuildContext context, String title, String emoji, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 10,
              offset: const Offset(-2, -2),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 40, color: Colors.blue.shade700),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => ChatbotPageState();
}

class ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  static const String apiKey = "YOUR_API_KEY"; // Replace with valid key

  void _sendMessage() async {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
      _controller.clear();
      _isLoading = true;
    });

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final response = await model.generateContent([Content.text(userMessage)]);
      setState(() {
        _messages.add(
            ChatMessage(text: response.text ?? "No response", isUser: false));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: "Error: $e", isUser: false));
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kenko Assistant",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(
                    text: message.text,
                    isUser: message.isUser,
                    index: index,
                  );
                },
              ),
            ),
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircularProgressIndicator(color: Colors.blue.shade700),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask a question...",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: Colors.blue.shade700),
                          onPressed: _sendMessage,
                        ),
                      ),
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
}

class ChatMessage {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser});
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final int index;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isUser ? Colors.blue.shade700 : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black87,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
