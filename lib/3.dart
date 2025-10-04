import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const ConnectNGO(),
    );
  }
}

class ConnectNGO extends StatelessWidget {
  const ConnectNGO({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to NGO 🤝"),
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildOptionCard(
              context,
              "Request for Funds",
              "💵",
              Colors.blue,
              "Apply for financial assistance from NGOs.",
              const NGOListPage(type: "Request for Funds"),
            ),
            _buildOptionCard(
              context,
              "Donate Money",
              "💰",
              Colors.green,
              "Contribute to NGOs and support their causes.",
              const NGOListPage(type: "Donate Money"),
            ),
            _buildOptionCard(
              context,
              "Volunteer Opportunities",
              "🙋",
              Colors.orange,
              "Find volunteering opportunities with NGOs.",
              const NGOListPage(type: "Volunteer Opportunities"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("NGO list refreshed! 🔄")),
          );
        },
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Text("🔄", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    String title,
    String emoji,
    Color color,
    String description,
    Widget page,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Opening $title...")),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(emoji, style: TextStyle(fontSize: 40, color: color)),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// NGO List Page
class NGOListPage extends StatelessWidget {
  final String type;

  const NGOListPage({super.key, required this.type});

  // Dummy data for NGOs
  final List<Map<String, String>> ngos = const [
    {
      "name": "HelpAge India",
      "mission": "Working for the elderly in India.",
      "contact": "+91 11 4168 8960",
      "website": "https://www.helpageindia.org",
      "eligibility": "Open to all individuals and organizations.",
    },
    {
      "name": "Sankara Eye Foundation",
      "mission": "Providing free eye care to the underprivileged.",
      "contact": "+91 80 2217 0000",
      "website": "https://www.sankaraeye.com",
      "eligibility": "Focuses on eye care patients in rural areas.",
    },
    {
      "name": "Smile Foundation",
      "mission": "Empowering underprivileged children and communities.",
      "contact": "+91 11 4312 3700",
      "website": "https://www.smilefoundationindia.org",
      "eligibility": "Focuses on education, health, and livelihood.",
    },
    {
      "name": "CARE India",
      "mission": "Fighting poverty and social injustice.",
      "contact": "+91 11 4606 4000",
      "website": "https://www.careindia.org",
      "eligibility": "Focuses on women and girls in rural areas.",
    },
    {
      "name": "Goonj",
      "mission": "Addressing basic needs like clothing and sanitation.",
      "contact": "+91 11 4140 1216",
      "website": "https://www.goonj.org",
      "eligibility": "Open to all individuals and organizations.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$type 🌍"),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: ngos.length,
          itemBuilder: (context, index) {
            final ngo = ngos[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200, width: 0.5),
              ),
              color: Colors.white,
              child: ListTile(
                leading: const Text("🏢", style: TextStyle(fontSize: 24, color: Colors.blue)),
                title: Text(
                  ngo["name"]!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mission: ${ngo["mission"]}", style: const TextStyle(color: Colors.black54)),
                    Text("Contact: ${ngo["contact"]}", style: const TextStyle(color: Colors.black54)),
                  ],
                ),
                trailing: type == "Donate Money"
                    ? IconButton(
                        icon: const Text("💸", style: TextStyle(fontSize: 24, color: Colors.green)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DonationPage(ngo: ngo)),
                          );
                        },
                      )
                    : const Text("➡️", style: TextStyle(fontSize: 24, color: Colors.blue)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NGODetailsPage(ngo: ngo)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// NGO Details Page
class NGODetailsPage extends StatelessWidget {
  final Map<String, String> ngo;

  const NGODetailsPage({super.key, required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${ngo["name"]} 🌍"),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("🎯 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Expanded(
                      child: Text(
                        "Mission: ${ngo["mission"]}",
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("📞 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Text(
                      "Contact: ${ngo["contact"]}",
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("🌐 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Text(
                      "Website: ${ngo["website"]}",
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("✅ ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Expanded(
                      child: Text(
                        "Eligibility: ${ngo["eligibility"]}",
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Donation Page
class DonationPage extends StatelessWidget {
  final Map<String, String> ngo;

  const DonationPage({super.key, required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donate to ${ngo["name"]} 💰"),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Payment Method:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                _buildPaymentOption("Credit/Debit Card", "💳"),
                _buildPaymentOption("UPI", "📱"),
                _buildPaymentOption("Net Banking", "🏦"),
                const SizedBox(height: 20),
                const Text(
                  "Enter Amount:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter amount in INR",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("₹", style: TextStyle(fontSize: 24, color: Colors.green)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Donation to ${ngo["name"]} successful! 🎉")),
                      );
                    },
                    icon: const Text("💸", style: TextStyle(fontSize: 24, color: Colors.white)),
                    label: const Text("Donate Now", style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String emoji) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      color: Colors.white,
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 24, color: Colors.blue)),
        title: Text(title, style: const TextStyle(color: Colors.black87)),
        onTap: () {
          // Add payment method functionality here
        },
      ),
    );
  }
}