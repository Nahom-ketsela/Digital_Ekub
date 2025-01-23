import 'package:flutter/material.dart';

class GeneralSettingsPage extends StatelessWidget {
  static String route = 'generalsettings-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Default Ekub Group
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Default Ekub Group'),
              subtitle:
                  Text('Select your default Ekub group for quick access.'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Add navigation logic for group selection
              },
            ),
            Divider(),

            // Auto-Payments
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Auto-Payments'),
              subtitle: Text('Enable automatic contributions to your Ekub.'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Add logic to toggle auto-payments
                },
              ),
            ),
            Divider(),

            // Payment Reminders
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Payment Reminders'),
              subtitle: Text('Set reminders for contribution deadlines.'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Add logic to toggle payment reminders
                },
              ),
            ),
            Divider(),

            SizedBox(height: 16),

            Text(
              'Manage these settings to ensure seamless operation of your Digital Ekub experience. Adjusting these preferences will help you stay organized and meet your financial goals on time.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Text(
              'Need More Help?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have questions about these settings or encounter issues, please visit the Help and About section or contact support.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
