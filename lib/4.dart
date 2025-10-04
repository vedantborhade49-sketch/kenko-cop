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
      home: const WhatsGoingOn(),
    );
  }
}

class WhatsGoingOn extends StatelessWidget {
  const WhatsGoingOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What’s Going On 📰"),
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
            _buildSectionBlock(
              context,
              "Tips to Stay Healthy",
              "🩺",
              Colors.green,
              const TipsToStayHealthyPage(),
            ),
            _buildSectionBlock(
              context,
              "Mental Health Tips",
              "🧠",
              Colors.purple,
              const MentalHealthTipsPage(),
            ),
            _buildSectionBlock(
              context,
              "Physical Fitness",
              "💪",
              Colors.orange,
              const PhysicalFitnessPage(),
            ),
            _buildSectionBlock(
              context,
              "General Wellness",
              "🌿",
              Colors.blue,
              const GeneralWellnessPage(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Content refreshed! 🔄")),
          );
        },
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Text("🔄", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  Widget _buildSectionBlock(
    BuildContext context,
    String title,
    String emoji,
    Color color,
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
            children: [
              Text(emoji, style: TextStyle(fontSize: 50, color: color)),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tips to Stay Healthy Page
class TipsToStayHealthyPage extends StatelessWidget {
  const TipsToStayHealthyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tips to Stay Healthy 🩺"),
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
            _buildArticleCard(
              context,
              "Stay Hydrated",
              "Drinking enough water is essential for overall health.",
              const ArticleDetailsPage(
                title: "Stay Hydrated",
                content:
                    "Water is crucial for maintaining bodily functions. It helps regulate body temperature, transport nutrients, and flush out toxins. Dehydration can lead to fatigue, headaches, and impaired cognitive function. Aim to drink at least 8 glasses of water a day, and more if you're physically active or in a hot climate.",
              ),
            ),
            _buildArticleCard(
              context,
              "Eat a Balanced Diet",
              "A balanced diet provides the nutrients your body needs.",
              const ArticleDetailsPage(
                title: "Eat a Balanced Diet",
                content:
                    "A balanced diet includes a variety of foods that provide essential nutrients for your body. Focus on fruits, vegetables, lean proteins, whole grains, and healthy fats. Avoid processed foods and excessive sugar. Eating a balanced diet helps maintain a healthy weight, supports immune function, and reduces the risk of chronic diseases.",
              ),
            ),
            _buildArticleCard(
              context,
              "Get Enough Sleep",
              "Sleep is vital for physical and mental health.",
              const ArticleDetailsPage(
                title: "Get Enough Sleep",
                content:
                    "Sleep plays a critical role in physical and mental health. It allows the body to repair itself, improves memory, and regulates mood. Lack of sleep can lead to fatigue, impaired cognitive function, and increased stress. Aim for 7-9 hours of quality sleep each night by maintaining a consistent sleep schedule and creating a relaxing bedtime routine.",
              ),
            ),
            _buildArticleCard(
              context,
              "Exercise Regularly",
              "Regular exercise improves physical and mental health.",
              const ArticleDetailsPage(
                title: "Exercise Regularly",
                content:
                    "Regular exercise is essential for maintaining physical and mental health. It helps improve cardiovascular health, strengthen muscles, and boost energy levels. Exercise also reduces stress and anxiety by releasing endorphins, the body's natural mood elevators. Aim for at least 30 minutes of moderate exercise, such as walking, cycling, or swimming, most days of the week.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Mental Health Tips Page
class MentalHealthTipsPage extends StatelessWidget {
  const MentalHealthTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Health Tips 🧠"),
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
            _buildArticleCard(
              context,
              "Practice Mindfulness",
              "Mindfulness can help reduce stress and anxiety.",
              const ArticleDetailsPage(
                title: "Practice Mindfulness",
                content:
                    "Mindfulness is the practice of being fully present in the moment, aware of where you are and what you're doing. It can help reduce stress, improve focus, and promote emotional well-being. Techniques include meditation, deep breathing exercises, and mindful walking. Start with just 5 minutes a day and gradually increase the duration.",
              ),
            ),
            _buildArticleCard(
              context,
              "Stay Connected",
              "Social connections are important for mental health.",
              const ArticleDetailsPage(
                title: "Stay Connected",
                content:
                    "Social connections are vital for mental health. They provide emotional support, reduce feelings of loneliness, and improve overall well-being. Make an effort to stay in touch with friends and family, even if it's just a quick phone call or text message. Join social groups or clubs to meet new people and build a support network.",
              ),
            ),
            _buildArticleCard(
              context,
              "Seek Professional Help",
              "Therapy can provide support for mental health issues.",
              const ArticleDetailsPage(
                title: "Seek Professional Help",
                content:
                    "If you're experiencing persistent feelings of sadness, anxiety, or stress, it's important to seek professional help. Therapists and counselors can provide valuable support and guidance. Cognitive-behavioral therapy (CBT), medication, and lifestyle changes are common treatment options. Don't hesitate to reach out for help if you need it.",
              ),
            ),
            _buildArticleCard(
              context,
              "Take Breaks",
              "Regular breaks can reduce stress and improve productivity.",
              const ArticleDetailsPage(
                title: "Take Breaks",
                content:
                    "Taking regular breaks is essential for maintaining mental health and productivity. Step away from work or stressful situations to recharge and refocus. Engage in activities that relax you, such as reading, walking, or listening to music. Even a short break can make a big difference in your overall well-being.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Physical Fitness Page
class PhysicalFitnessPage extends StatelessWidget {
  const PhysicalFitnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Physical Fitness 💪"),
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
            _buildArticleCard(
              context,
              "Cardio Workouts",
              "Cardio improves heart health and burns calories.",
              const ArticleDetailsPage(
                title: "Cardio Workouts",
                content:
                    "Cardiovascular exercise, also known as cardio, includes activities that increase your heart rate and improve circulation. Examples include running, cycling, swimming, and dancing. Regular cardio exercise strengthens the heart, improves lung capacity, and reduces the risk of heart disease. Aim for at least 150 minutes of moderate-intensity cardio each week.",
              ),
            ),
            _buildArticleCard(
              context,
              "Strength Training",
              "Build muscle and improve bone density.",
              const ArticleDetailsPage(
                title: "Strength Training",
                content:
                    "Strength training involves exercises that improve muscle strength and endurance. It can be done using free weights, resistance bands, or bodyweight exercises like push-ups and squats. Strength training increases metabolism, improves bone density, and enhances overall physical performance. Beginners should start with light weights and focus on proper form to avoid injury.",
              ),
            ),
            _buildArticleCard(
              context,
              "Flexibility and Stretching",
              "Stretching improves flexibility and prevents injuries.",
              const ArticleDetailsPage(
                title: "Flexibility and Stretching",
                content:
                    "Stretching is an important part of any fitness routine. It improves flexibility, reduces muscle tension, and helps prevent injuries. Incorporate stretching exercises into your daily routine, especially after workouts. Yoga and Pilates are great ways to improve flexibility and overall fitness.",
              ),
            ),
            _buildArticleCard(
              context,
              "Stay Consistent",
              "Consistency is key to achieving fitness goals.",
              const ArticleDetailsPage(
                title: "Stay Consistent",
                content:
                    "Consistency is crucial for achieving and maintaining fitness goals. Create a workout schedule that fits your lifestyle and stick to it, even on busy days. Set realistic goals and track your progress to stay motivated. Remember, small, consistent efforts lead to long-term results.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// General Wellness Page
class GeneralWellnessPage extends StatelessWidget {
  const GeneralWellnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("General Wellness 🌿"),
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
            _buildArticleCard(
              context,
              "Manage Stress",
              "Practice relaxation techniques to reduce stress.",
              const ArticleDetailsPage(
                title: "Manage Stress",
                content:
                    "Chronic stress can have a negative impact on both physical and mental health. It can lead to high blood pressure, weakened immune function, and mental health issues like anxiety and depression. Practice relaxation techniques such as deep breathing, meditation, or yoga to manage stress effectively. Regular exercise and a healthy diet can also help reduce stress levels.",
              ),
            ),
            _buildArticleCard(
              context,
              "Healthy Habits",
              "Small habits can impact your overall wellness.",
              const ArticleDetailsPage(
                title: "Healthy Habits",
                content:
                    "Small daily habits can significantly impact your overall wellness. Focus on eating a balanced diet, staying physically active, and getting enough sleep. Avoid smoking and limit alcohol consumption. Incorporate mindfulness practices like meditation or journaling to improve mental well-being. Remember, consistency is key to building healthy habits.",
              ),
            ),
            _buildArticleCard(
              context,
              "Stay Positive",
              "A positive mindset improves well-being.",
              const ArticleDetailsPage(
                title: "Stay Positive",
                content:
                    "A positive mindset can have a profound impact on your overall well-being. Practice gratitude by focusing on the good things in your life and expressing appreciation for them. Surround yourself with positive people and engage in activities that bring you joy. A positive attitude can help you cope with stress and improve your mental health.",
              ),
            ),
            _buildArticleCard(
              context,
              "Regular Check-ups",
              "Detect issues early with regular check-ups.",
              const ArticleDetailsPage(
                title: "Regular Check-ups",
                content:
                    "Regular health check-ups are essential for maintaining overall wellness. They help detect potential health issues early, allowing for timely intervention and treatment. Schedule annual visits with your healthcare provider for routine screenings and assessments. Don't ignore any unusual symptoms and seek medical advice when needed.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Article Details Page
class ArticleDetailsPage extends StatelessWidget {
  final String title;
  final String content;

  const ArticleDetailsPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title 📝"),
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
                    const Text("📖 ", style: TextStyle(fontSize: 24, color: Colors.blue)),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
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

// Helper function to build article cards
Widget _buildArticleCard(
  BuildContext context,
  String title,
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
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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