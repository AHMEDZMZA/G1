import 'package:flutter/material.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

class ExpertSuccessScreen extends StatelessWidget {
  const ExpertSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.brown.shade100,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Data Submitted Successfully',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your information has been sent successfully.\nWe will review your data shortly.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Profile();
                        },
                      ),
                    );
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
