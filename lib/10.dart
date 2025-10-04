import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
    home: const RemindersScreen(),
  ));
}

class Reminder {
  final String title;
  final String description;
  bool isCompleted;
  final int priority;

  Reminder({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.priority = 1,
  });
}

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  List<Reminder> reminders = [
    Reminder(
      title: "Missed Doctor Appointment",
      description: "You missed your appointment with Dr. Smith on October 10.",
      priority: 3,
    ),
    Reminder(
      title: "Take Medicine",
      description: "Take your prescribed medicine after breakfast.",
      priority: 2,
    ),
    Reminder(
      title: "Exercise",
      description: "30 minutes of cardio exercise.",
      priority: 1,
    ),
    Reminder(
      title: "Drink Water",
      description: "Drink at least 8 glasses of water today.",
      priority: 1,
    ),
    Reminder(
      title: "Meditation",
      description: "Spend 10 minutes meditating.",
      priority: 2,
    ),
    Reminder(
      title: "Yoga",
      description: "20 minutes of yoga for flexibility.",
      priority: 1,
    ),
    Reminder(
      title: "Meal Prep",
      description: "Prepare meals for the week.",
      priority: 2,
    ),
  ];

  bool sortByPriority = false;
  CalendarFormat _calendarFormat = CalendarFormat.week; // Default to week view
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    if (sortByPriority) {
      reminders.sort((a, b) => b.priority.compareTo(a.priority));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders 🔔"),
        leading: IconButton(
          icon: const Text("⬅️", style: TextStyle(fontSize: 24, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Text("📶", style: TextStyle(fontSize: 24, color: Colors.white)),
            onPressed: () {
              setState(() {
                sortByPriority = !sortByPriority;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(sortByPriority ? "Sorted by priority" : "Unsorted")),
              );
            },
            tooltip: 'Sort by Priority',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Smaller Calendar with Adjusted Height
            SizedBox(
              height: 200, // Increased from 150 to 200 to prevent overflow
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                      cellMargin: const EdgeInsets.all(2.0), // Reduced margin to fit content
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(fontSize: 14), // Smaller header text
                      leftChevronPadding: EdgeInsets.all(0),
                      rightChevronPadding: EdgeInsets.all(0),
                    ),
                    daysOfWeekHeight: 20, // Reduced height of days of week row
                  ),
                ),
              ),
            ),
            // Reminders List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  Reminder reminder = reminders[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                    ),
                    child: ListTile(
                      leading: Text(
                        _getEmojiForReminder(reminder.title),
                        style: TextStyle(fontSize: 24, color: _getPriorityColor(reminder.priority)),
                      ),
                      title: Text(
                        reminder.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                          decoration: reminder.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(reminder.description, style: const TextStyle(color: Colors.black54)),
                          const SizedBox(height: 4),
                          Text(
                            "Priority: ${reminder.priority}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Text(
                              reminder.isCompleted ? "✅" : "⬜",
                              style: const TextStyle(fontSize: 24),
                            ),
                            onPressed: () {
                              setState(() {
                                reminder.isCompleted = !reminder.isCompleted;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(reminder.isCompleted
                                      ? "${reminder.title} completed! 🎉"
                                      : "${reminder.title} marked incomplete"),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Text("🗑️", style: TextStyle(fontSize: 24, color: Colors.red)),
                            onPressed: () {
                              _confirmDelete(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderDialog,
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Text("➕", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  String _getEmojiForReminder(String title) {
    if (title.toLowerCase().contains("doctor") || title.toLowerCase().contains("appointment")) {
      return "🩺";
    } else if (title.toLowerCase().contains("medicine")) {
      return "💊";
    } else if (title.toLowerCase().contains("exercise") || title.toLowerCase().contains("yoga")) {
      return "🏃";
    } else if (title.toLowerCase().contains("water")) {
      return "💧";
    } else if (title.toLowerCase().contains("meditation")) {
      return "🧘";
    } else if (title.toLowerCase().contains("meal")) {
      return "🍽️";
    } else {
      return "🔔";
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 3:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 1:
      default:
        return Colors.blue;
    }
  }

  void _showAddReminderDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    int selectedPriority = 1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Add New Reminder 🔔", style: TextStyle(color: Colors.black87)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          hintText: "e.g., Take Medicine",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("📝", style: TextStyle(fontSize: 24)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "e.g., Take your prescribed medicine after breakfast.",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("ℹ️", style: TextStyle(fontSize: 24)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: DropdownButtonFormField<int>(
                        value: selectedPriority,
                        decoration: InputDecoration(
                          labelText: "Priority",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("⭐", style: TextStyle(fontSize: 24)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: const [
                          DropdownMenuItem(value: 1, child: Text("Low Priority")),
                          DropdownMenuItem(value: 2, child: Text("Medium Priority")),
                          DropdownMenuItem(value: 3, child: Text("High Priority")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedPriority = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                  setState(() {
                    reminders.add(
                      Reminder(
                        title: titleController.text,
                        description: descriptionController.text,
                        priority: selectedPriority,
                      ),
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Reminder '${titleController.text}' added! ✅")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields! ⚠️")),
                  );
                }
              },
              child: const Text("Add", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Delete Reminder 🗑️", style: TextStyle(color: Colors.black87)),
          content: const Text("Are you sure you want to delete this reminder?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  reminders.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reminder deleted! 🗑️")),
                );
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}