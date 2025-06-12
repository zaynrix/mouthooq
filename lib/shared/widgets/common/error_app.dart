import 'package:flutter/material.dart';

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Failed to initialize app',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Please restart the application'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // In a real app, you might restart or retry initialization
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}