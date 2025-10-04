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
    home: const TrackHealthScreen(),
  ));
}

class HealthGoal {
  final String title;
  final String description;
  bool isCompleted;

  HealthGoal({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class TrackHealthScreen extends StatefulWidget {
  const TrackHealthScreen({super.key});

  @override
  _TrackHealthScreenState createState() => _TrackHealthScreenState();
}

class _TrackHealthScreenState extends State<TrackHealthScreen> {
  List<HealthGoal> healthGoals = [
    HealthGoal(
      title: "Proper Protein Intake",
      description: "Ensure you consume enough protein daily.",
    ),
    HealthGoal(
      title: "Proper Calorie Intake",
      description: "Track your daily calorie consumption.",
    ),
    HealthGoal(
      title: "Physical Exercise",
      description: "Engage in at least 30 minutes of exercise daily.",
    ),
    HealthGoal(
      title: "Water Intake",
      description: "Drink at least 8 glasses of water daily.",
    ),
    HealthGoal(
      title: "Sleep",
      description: "Get 7-8 hours of sleep every night.",
    ),
  ];

  void _resetGoals() {
    setState(() {
      for (var goal in healthGoals) {
        goal.isCompleted = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All goals reset! 🔄")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track My Health 💪"),
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
            ...healthGoals.map((goal) => _buildGoalCard(goal)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetGoals,
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

  String _getEmojiForGoal(String title) {
    switch (title) {
      case "Proper Protein Intake":
        return "🍗";
      case "Proper Calorie Intake":
        return "🍽️";
      case "Physical Exercise":
        return "🏃";
      case "Water Intake":
        return "💧";
      case "Sleep":
        return "😴";
      default:
        return "✅";
    }
  }

  Widget _buildGoalCard(HealthGoal goal) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
      color: Colors.white,
      child: ListTile(
        leading: Text(
          _getEmojiForGoal(goal.title),
          style: const TextStyle(fontSize: 24, color: Colors.blue),
        ),
        title: Text(
          goal.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        subtitle: Text(goal.description, style: const TextStyle(color: Colors.black54)),
        trailing: Checkbox(
          value: goal.isCompleted,
          onChanged: (value) {
            setState(() {
              goal.isCompleted = value ?? false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  goal.isCompleted ? "${goal.title} completed! 🎉" : "${goal.title} marked incomplete",
                ),
              ),
            );
          },
          activeColor: Colors.blue,
        ),
      ),
    );
  }
}