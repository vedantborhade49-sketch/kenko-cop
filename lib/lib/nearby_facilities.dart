import 'package:flutter/material.dart';

class NearbyFacilities extends StatelessWidget {
  const NearbyFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Medical Facilities")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("List of nearby doctors, pharmacies, and ambulances"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
