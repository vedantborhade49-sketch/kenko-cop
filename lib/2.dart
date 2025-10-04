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
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black87),
        ),
        buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
      ),
      home: const AboutMe(),
    );
  }
}

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _fitnessGoalsController = TextEditingController();

  String? _gender;
  String? _bloodGroup;

  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data saved successfully! ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me 👤"),
        leading: IconButton(
          icon: const Text("⬅️",
              style: TextStyle(fontSize: 24, color: Colors.white)),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/profile.png"), // Add your image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Text("📸",
                            style: TextStyle(fontSize: 24, color: Colors.blue)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Upload photo feature coming soon! 📷")),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Name
              _buildTextFieldWithIcon(
                "Name",
                "Enter your name",
                _nameController,
                "👤",
              ),
              // Age
              _buildTextFieldWithIcon(
                "Age",
                "Enter your age",
                _ageController,
                "🎂",
                keyboardType: TextInputType.number,
              ),
              // Gender Dropdown
              _buildDropdownWithIcon(
                "Gender",
                _gender,
                _genders,
                "⚧",
                (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              // Blood Group Dropdown
              _buildDropdownWithIcon(
                "Blood Group",
                _bloodGroup,
                _bloodGroups,
                "🩺",
                (value) {
                  setState(() {
                    _bloodGroup = value;
                  });
                },
              ),
              // Address
              _buildTextFieldWithIcon(
                "Address",
                "Enter your address",
                _addressController,
                "🏠",
              ),
              // Phone Number
              _buildTextFieldWithIcon(
                "Phone Number",
                "Enter your phone number",
                _phoneController,
                "📞",
                keyboardType: TextInputType.phone,
              ),
              // Emergency Contact
              _buildTextFieldWithIcon(
                "Emergency Contact",
                "Enter emergency contact",
                _emergencyContactController,
                "🚨",
                keyboardType: TextInputType.phone,
              ),
              // Weight
              _buildTextFieldWithIcon(
                "Weight (kg)",
                "Enter your weight",
                _weightController,
                "⚖️",
                keyboardType: TextInputType.number,
              ),
              // Height
              _buildTextFieldWithIcon(
                "Height (cm)",
                "Enter your height",
                _heightController,
                "📏",
                keyboardType: TextInputType.number,
              ),
              // Allergies
              _buildTextFieldWithIcon(
                "Allergies",
                "Enter your allergies",
                _allergiesController,
                "⚠️",
                maxLines: 2,
              ),
              // Fitness Goals
              _buildTextFieldWithIcon(
                "Fitness Goals",
                "Enter your fitness goals",
                _fitnessGoalsController,
                "💪",
                maxLines: 3,
              ),
              // Medical History
              _buildTextFieldWithIcon(
                "Medical History (Optional)",
                "Enter your medical history",
                _medicalHistoryController,
                "🏥",
                maxLines: 3,
                isOptional: true,
              ),
              const SizedBox(height: 20),

              // Save Button
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton.icon(
                  onPressed: _saveForm,
                  icon: const Text("💾",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  label: const Text("Save",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
    String label,
    String hint,
    TextEditingController controller,
    String emoji, {
    TextInputType? keyboardType,
    int maxLines = 1,
    bool isOptional = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: (value) {
            if (!isOptional && (value == null || value.isEmpty)) {
              return "This field is required";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDropdownWithIcon(
    String label,
    String? value,
    List<String> items,
    String emoji,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select a $label";
            }
            return null;
          },
        ),
      ),
    );
  }
}
