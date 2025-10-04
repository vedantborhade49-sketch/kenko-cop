import 'package:flutter/material.dart';

void main() {
  runApp(const HealthLoansApp());
}

class HealthLoansApp extends StatelessWidget {
  const HealthLoansApp({super.key});

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
      ),
      home: const HealthLoansDashboard(),
    );
  }
}

class HealthLoansDashboard extends StatefulWidget {
  const HealthLoansDashboard({super.key});

  @override
  _HealthLoansDashboardState createState() => _HealthLoansDashboardState();
}

class _HealthLoansDashboardState extends State<HealthLoansDashboard> {
  final _formKey = GlobalKey<FormState>();
  String? _panNumber;
  String? _employeeType;
  double? _monthlySalary;
  String? _loanFor;
  double? _maxLoanAmount;

  final List<String> _employeeTypes = ['Government', 'Private', 'Self-Employed'];
  final List<String> _loanForOptions = ['Self', 'Family Member'];

  void _calculateLoan() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _maxLoanAmount = _computeMaxLoan(_monthlySalary!, _employeeType!);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loan amount calculated! 💸')),
      );
    }
  }

  double _computeMaxLoan(double salary, String employeeType) {
    const int maxCap = 1000000; // ₹10,00,000 cap
    double multiplier;
    switch (employeeType) {
      case 'Government':
        multiplier = 10.0;
        break;
      case 'Private':
        multiplier = 8.0;
        break;
      case 'Self-Employed':
        multiplier = 6.0;
        break;
      default:
        multiplier = 6.0;
    }
    double calculatedLoan = salary * multiplier;
    return calculatedLoan > maxCap ? maxCap.toDouble() : calculatedLoan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Loans Dashboard 💰'),
        centerTitle: true,
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Your Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  label: 'PAN Number',
                  emoji: '🖋️',
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'e.g., ABCDE1234F',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter PAN number' : null,
                    onSaved: (value) => _panNumber = value,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  label: 'Employee Type',
                  emoji: '👔',
                  child: DropdownButtonFormField<String>(
                    value: _employeeType,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    hint: const Text('Select Employee Type'),
                    items: _employeeTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                    validator: (value) => value == null ? 'Select employee type' : null,
                    onChanged: (value) => setState(() => _employeeType = value),
                    onSaved: (value) => _employeeType = value,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  label: 'Monthly Salary (₹)',
                  emoji: '💵',
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'e.g., 50000',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? 'Enter salary' : null,
                    onSaved: (value) => _monthlySalary = double.tryParse(value!),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  label: 'Loan For',
                  emoji: '👨‍👩‍👧',
                  child: DropdownButtonFormField<String>(
                    value: _loanFor,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    hint: const Text('Select Loan Purpose'),
                    items: _loanForOptions.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
                    validator: (value) => value == null ? 'Select loan purpose' : null,
                    onChanged: (value) => setState(() => _loanFor = value),
                    onSaved: (value) => _loanFor = value,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _calculateLoan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Calculate Loan 💸', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                if (_maxLoanAmount != null) ...[
                  const SizedBox(height: 24),
                  _buildResultCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({required String label, required String emoji, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Loan Details 📊',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('PAN Number', _panNumber!, '🖋️'),
            _buildDetailRow('Employee Type', _employeeType!, '👔'),
            _buildDetailRow('Monthly Salary', '₹${_monthlySalary!.toStringAsFixed(0)}', '💵'),
            _buildDetailRow('Loan For', _loanFor!, '👨‍👩‍👧'),
            const Divider(height: 24),
            _buildDetailRow('Max Loan Amount', '₹${_maxLoanAmount!.toStringAsFixed(0)}', '💰', isHighlight: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, String emoji, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 14, fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.blue : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}