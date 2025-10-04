import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialization;
  final String experience;
  final String imageUrl;
  final String bio;
  final String degree;
  final double consultationFees;

  Doctor({
    required this.name,
    required this.specialization,
    required this.experience,
    required this.imageUrl,
    required this.bio,
    required this.degree,
    required this.consultationFees,
  });
}

class DoctorCategory {
  final String categoryName;
  final List<Doctor> doctors;

  DoctorCategory({
    required this.categoryName,
    required this.doctors,
  });
}

class OnlineDoctors {
  static List<DoctorCategory> getDoctorCategories() {
    return [
      DoctorCategory(
        categoryName: "Physiotherapist",
        doctors: [
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Physical Therapist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in sports injuries and rehabilitation.",
            degree: "DPT, MPT",
            consultationFees: 1200,
          ),
          Doctor(
            name: "Dr. John Doe",
            specialization: "Orthopedic Physiotherapist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in post-surgery recovery and mobility improvement.",
            degree: "MPT, PhD",
            consultationFees: 1500,
          ),
          Doctor(
            name: "Dr. Sarah Lee",
            specialization: "Pediatric Physiotherapist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in therapy for children with disabilities.",
            degree: "MPT, PhD",
            consultationFees: 1300,
          ),
          Doctor(
            name: "Dr. Michael Brown",
            specialization: "Geriatric Physiotherapist",
            experience: "12 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Focuses on elderly care and mobility issues.",
            degree: "MPT, PhD",
            consultationFees: 1400,
          ),
          Doctor(
            name: "Dr. Laura Green",
            specialization: "Neurological Physiotherapist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating neurological disorders.",
            degree: "MPT, PhD",
            consultationFees: 1600,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "General OPD",
        doctors: [
          Doctor(
            name: "Dr. Sarah Lee",
            specialization: "General Physician",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Provides comprehensive primary care for all ages.",
            degree: "MBBS, MD",
            consultationFees: 800,
          ),
          Doctor(
            name: "Dr. Michael Brown",
            specialization: "Family Medicine Specialist",
            experience: "12 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Focuses on preventive care and chronic disease management.",
            degree: "MBBS, MD",
            consultationFees: 1000,
          ),
          Doctor(
            name: "Dr. Alice Johnson",
            specialization: "Internal Medicine Specialist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in diagnosing and treating complex diseases.",
            degree: "MBBS, MD",
            consultationFees: 1200,
          ),
          Doctor(
            name: "Dr. Robert Smith",
            specialization: "Emergency Medicine Specialist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in urgent medical care.",
            degree: "MBBS, MD",
            consultationFees: 1100,
          ),
          Doctor(
            name: "Dr. Emma Wilson",
            specialization: "Primary Care Physician",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Provides holistic care for families.",
            degree: "MBBS, MD",
            consultationFees: 900,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Cardiologist",
        doctors: [
          Doctor(
            name: "Dr. Alice Johnson",
            specialization: "Cardiologist",
            experience: "15 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in heart health and cardiovascular diseases.",
            degree: "MBBS, MD, DM",
            consultationFees: 2000,
          ),
          Doctor(
            name: "Dr. Robert Smith",
            specialization: "Interventional Cardiologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in minimally invasive heart procedures.",
            degree: "MBBS, MD, DM",
            consultationFees: 2500,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Pediatric Cardiologist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating heart conditions in children.",
            degree: "MBBS, MD, DM",
            consultationFees: 2200,
          ),
          Doctor(
            name: "Dr. John Doe",
            specialization: "Electrophysiologist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in heart rhythm disorders.",
            degree: "MBBS, MD, DM",
            consultationFees: 2300,
          ),
          Doctor(
            name: "Dr. Sarah Lee",
            specialization: "Heart Failure Specialist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Focuses on advanced heart failure management.",
            degree: "MBBS, MD, DM",
            consultationFees: 2400,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Psychotherapist",
        doctors: [
          Doctor(
            name: "Dr. Laura Green",
            specialization: "Clinical Psychologist",
            experience: "11 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Helps patients manage stress, anxiety, and depression.",
            degree: "PhD, M.Phil",
            consultationFees: 1500,
          ),
          Doctor(
            name: "Dr. Mark Taylor",
            specialization: "Cognitive Behavioral Therapist",
            experience: "6 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in CBT for mental health disorders.",
            degree: "MA, PhD",
            consultationFees: 1200,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Child Psychologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in child and adolescent mental health.",
            degree: "PhD, M.Phil",
            consultationFees: 1300,
          ),
          Doctor(
            name: "Dr. John Doe",
            specialization: "Marriage and Family Therapist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Focuses on relationship and family issues.",
            degree: "MA, PhD",
            consultationFees: 1400,
          ),
          Doctor(
            name: "Dr. Sarah Lee",
            specialization: "Trauma Specialist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Helps patients recover from traumatic experiences.",
            degree: "PhD, M.Phil",
            consultationFees: 1600,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Dermatologist",
        doctors: [
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Cosmetic Dermatologist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in skin care and cosmetic treatments.",
            degree: "MBBS, MD",
            consultationFees: 1800,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Medical Dermatologist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in treating skin diseases and conditions.",
            degree: "MBBS, MD",
            consultationFees: 2000,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Pediatric Dermatologist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating skin conditions in children.",
            degree: "MBBS, MD",
            consultationFees: 1900,
          ),
          Doctor(
            name: "Dr. John Doe",
            specialization: "Laser Dermatologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in laser treatments for skin issues.",
            degree: "MBBS, MD",
            consultationFees: 2100,
          ),
          Doctor(
            name: "Dr. Sarah Lee",
            specialization: "Aesthetic Dermatologist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Focuses on anti-aging and aesthetic treatments.",
            degree: "MBBS, MD",
            consultationFees: 2200,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Pediatrician",
        doctors: [
          Doctor(
            name: "Dr. Sophia Brown",
            specialization: "Child Health Specialist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Provides care for infants, children, and adolescents.",
            degree: "MBBS, MD",
            consultationFees: 1200,
          ),
          Doctor(
            name: "Dr. Ethan Green",
            specialization: "Neonatologist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in newborn and premature baby care.",
            degree: "MBBS, MD",
            consultationFees: 1500,
          ),
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Pediatric Cardiologist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating heart conditions in children.",
            degree: "MBBS, MD",
            consultationFees: 1600,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Pediatric Neurologist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in neurological disorders in children.",
            degree: "MBBS, MD",
            consultationFees: 1700,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Pediatric Endocrinologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in hormonal disorders in children.",
            degree: "MBBS, MD",
            consultationFees: 1800,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Gynecologist",
        doctors: [
          Doctor(
            name: "Dr. Omkar Pardesi",
            specialization: "Obstetrician & Gynecologist",
            experience: "12 years",
            imageUrl: "assets/doctor1.jpg",
            bio: "Expert in women's health and pregnancy care.",
            degree: "MBBS, MD",
            consultationFees: 1800,
          ),
          Doctor(
            name: "Dr. Ramesh Patil",
            specialization: "Reproductive Endocrinologist",
            experience: "8 years",
            imageUrl: "assets/doctor9.jpg",
            bio: "Specializes in fertility and hormonal disorders.",
            degree: "MBBS, MD",
            consultationFees: 2000,
          ),
          Doctor(
            name: "Dr. Sakshi Malik",
            specialization: "Gynecologic Oncologist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating gynecologic cancers.",
            degree: "MBBS, MD",
            consultationFees: 2200,
          ),
          Doctor(
            name: "Dr. Dolphin Deshmukh",
            specialization: "Urogynecologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in pelvic floor disorders.",
            degree: "MBBS, MD",
            consultationFees: 2100,
          ),
          Doctor(
            name: "Dr. Jokh Khan",
            specialization: "Adolescent Gynecologist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Focuses on gynecologic care for teenagers.",
            degree: "MBBS, MD",
            consultationFees: 1900,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Neurologist",
        doctors: [
          Doctor(
            name: "Dr. Ava Martinez",
            specialization: "Neurologist",
            experience: "14 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating brain and nervous system disorders.",
            degree: "MBBS, MD, DM",
            consultationFees: 2500,
          ),
          Doctor(
            name: "Dr. Liam Clark",
            specialization: "Neurosurgeon",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in surgical treatment of neurological conditions.",
            degree: "MBBS, MS",
            consultationFees: 3000,
          ),
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Pediatric Neurologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating neurological disorders in children.",
            degree: "MBBS, MD",
            consultationFees: 2600,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Epileptologist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in epilepsy and seizure disorders.",
            degree: "MBBS, MD",
            consultationFees: 2700,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Stroke Specialist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in stroke prevention and treatment.",
            degree: "MBBS, MD",
            consultationFees: 2800,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "ENT Specialist",
        doctors: [
          Doctor(
            name: "Dr. Mia Rodriguez",
            specialization: "Otolaryngologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in ear, nose, and throat disorders.",
            degree: "MBBS, MS",
            consultationFees: 1500,
          ),
          Doctor(
            name: "Dr. Lucas Lewis",
            specialization: "Head and Neck Surgeon",
            experience: "11 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in surgical treatment of ENT conditions.",
            degree: "MBBS, MS",
            consultationFees: 2000,
          ),
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Pediatric ENT Specialist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in treating ENT disorders in children.",
            degree: "MBBS, MS",
            consultationFees: 1700,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Rhinologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in nasal and sinus disorders.",
            degree: "MBBS, MS",
            consultationFees: 1800,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Laryngologist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in voice and swallowing disorders.",
            degree: "MBBS, MS",
            consultationFees: 1900,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Dentist",
        doctors: [
          Doctor(
            name: "Dr. Sophia Brown",
            specialization: "Orthodontist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in braces and teeth alignment.",
            degree: "BDS, MDS",
            consultationFees: 1200,
          ),
          Doctor(
            name: "Dr. Ethan Green",
            specialization: "Endodontist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in root canal treatments.",
            degree: "BDS, MDS",
            consultationFees: 1500,
          ),
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Periodontist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in gum disease treatment.",
            degree: "BDS, MDS",
            consultationFees: 1300,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Pediatric Dentist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in dental care for children.",
            degree: "BDS, MDS",
            consultationFees: 1400,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Prosthodontist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in dental prosthetics and implants.",
            degree: "BDS, MDS",
            consultationFees: 1600,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Nutritionist",
        doctors: [
          Doctor(
            name: "Dr. Emma Wilson",
            specialization: "Clinical Nutritionist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Helps patients with diet plans and weight management.",
            degree: "MSc, PhD",
            consultationFees: 1000,
          ),
          Doctor(
            name: "Dr. Noah Harris",
            specialization: "Sports Nutritionist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in nutrition for athletes.",
            degree: "MSc, PhD",
            consultationFees: 1200,
          ),
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Pediatric Nutritionist",
            experience: "7 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in child nutrition and growth.",
            degree: "MSc, PhD",
            consultationFees: 1100,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Diabetes Nutritionist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in diet plans for diabetes management.",
            degree: "MSc, PhD",
            consultationFees: 1300,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Weight Management Specialist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Helps patients achieve and maintain a healthy weight.",
            degree: "MSc, PhD",
            consultationFees: 1400,
          ),
        ],
      ),
      DoctorCategory(
        categoryName: "Oncologist",
        doctors: [
          Doctor(
            name: "Dr. Ava Martinez",
            specialization: "Medical Oncologist",
            experience: "12 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in cancer treatment and chemotherapy.",
            degree: "MBBS, MD, DM",
            consultationFees: 2500,
          ),
          Doctor(
            name: "Dr. Liam Clark",
            specialization: "Radiation Oncologist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in radiation therapy for cancer.",
            degree: "MBBS, MD, DM",
            consultationFees: 3000,
          ),
          Doctor(
            name: "Dr. Olivia White",
            specialization: "Surgical Oncologist",
            experience: "9 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in surgical removal of tumors.",
            degree: "MBBS, MS",
            consultationFees: 2800,
          ),
          Doctor(
            name: "Dr. James Black",
            specialization: "Pediatric Oncologist",
            experience: "8 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Specializes in treating childhood cancers.",
            degree: "MBBS, MD",
            consultationFees: 2700,
          ),
          Doctor(
            name: "Dr. Emily Carter",
            specialization: "Hematologist-Oncologist",
            experience: "10 years",
            imageUrl: "https://via.placeholder.com/150",
            bio: "Expert in blood cancers and disorders.",
            degree: "MBBS, MD",
            consultationFees: 2900,
          ),
        ],
      ),
    ];
  }
}

class ConsultDoctorScreen extends StatelessWidget {
  const ConsultDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<DoctorCategory> doctorCategories = OnlineDoctors.getDoctorCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Consult an Online Doctor"),
        centerTitle: true,
        backgroundColor: Colors.red, // Red color for app bar
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: doctorCategories.length,
        itemBuilder: (context, index) {
          DoctorCategory category = doctorCategories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                category.categoryName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Red color for category names
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorListPage(category: category),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DoctorListPage extends StatefulWidget {
  final DoctorCategory category;

  const DoctorListPage({super.key, required this.category});

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  String _sortBy = "Fees"; // Default sorting by fees

  void _sortDoctors(String value) {
    setState(() {
      _sortBy = value;
    });
  }

  List<Doctor> _getSortedDoctors() {
    List<Doctor> doctors = List.from(widget.category.doctors);
    if (_sortBy == "Fees") {
      doctors.sort((a, b) => a.consultationFees.compareTo(b.consultationFees));
    } else if (_sortBy == "Experience") {
      doctors.sort((a, b) => b.experience.compareTo(a.experience));
    }
    return doctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.categoryName),
        centerTitle: true,
        backgroundColor: Colors.red, // Red color for app bar
      ),
      body: Column(
        children: [
          // Sort Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sort by:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _sortBy,
                  items: ["Fees", "Experience"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _sortDoctors(value!);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getSortedDoctors().length,
              itemBuilder: (context, index) {
                Doctor doctor = _getSortedDoctors()[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(doctor.imageUrl),
                    ),
                    title: Text(
                      doctor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.specialization),
                        const SizedBox(height: 4),
                        Text(
                          "Experience: ${doctor.experience}",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "Fees: ₹${doctor.consultationFees}",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetailsPage(doctor: doctor),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        backgroundColor: Colors.red, // Red color for app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(doctor.imageUrl),
                radius: 60,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Specialization: ${doctor.specialization}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Experience: ${doctor.experience}",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              "Degree: ${doctor.degree}",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              "Consultation Fees: ₹${doctor.consultationFees}",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Text(
              "About Dr. ${doctor.name}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              doctor.bio,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Consulting ${doctor.name}...")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red color for button
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "Book Consultation",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}