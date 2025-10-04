import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDemoScreen extends StatefulWidget {
  const SupabaseDemoScreen({super.key});

  @override
  State<SupabaseDemoScreen> createState() => _SupabaseDemoScreenState();
}

class _SupabaseDemoScreenState extends State<SupabaseDemoScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String statusMessage = "";

  Future<void> _signUp() async {
    final res = await supabase.auth.signUp(
      email: _email.text,
      password: _password.text,
    );

    setState(() {
      statusMessage = res.user != null
          ? "✅ Signup successful"
          : "❌ Signup failed: ${res.session?.accessToken ?? 'Unknown error'}";
    });
  }

  Future<void> _signIn() async {
    final res = await supabase.auth.signInWithPassword(
      email: _email.text,
      password: _password.text,
    );

    setState(() {
      statusMessage = res.user != null
          ? "✅ Login successful"
          : "❌ Login failed";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supabase Auth 🔐", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Login or Sign up using Supabase",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 20),
            Text(statusMessage),
          ],
        ),
      ),
    );
  }
}
