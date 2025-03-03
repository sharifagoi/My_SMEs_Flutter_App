import 'package:flutter/material.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'A verification code has been sent to your email. Please enter the OTP below.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // OTP Input Field
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            // Verify OTP Button
            ElevatedButton(
              onPressed: () {
                String otp = otpController.text.trim();
                if (otp.isNotEmpty) {
                  // Navigate to Set Password page after OTP verification
                  Navigator.pushNamed(context, '/set-password');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter the OTP')),
                  );
                }
              },
              child: const Text('Verify OTP'),
            ),

            const SizedBox(height: 10),

            // Resend OTP
            TextButton(
              onPressed: () {
                // Logic to resend OTP to email
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP has been resent to your email')),
                );
              },
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
