import 'package:flutter/material.dart';

class HelpAndAboutPage extends StatelessWidget {
  static String route = 'helpabout-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help and About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // About General Settings
            Text(
              'General Settings Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'In the General Settings section, you can manage key configurations for your Digital Ekub app. Here are the features available in General Settings:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '1. Default Ekub Group',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Set your default Ekub group to ensure all transactions and updates align with the group of your choice.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '2. Auto-Payments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Enable or disable auto-payments for your Ekub contributions. This ensures timely contributions without manual effort.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '3. Payment Reminders',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Set up reminders to avoid missing your contribution deadlines. Customize notification timing based on your preferences.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Additional Help
            Text(
              'Need Assistance?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you need further help or encounter issues with the app, please contact us through the following methods:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email: support@digitalekub.com',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone: +251-123-456-789',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Footer
            Text(
              'Thank you for using Digital Ekub!',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
