import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatelessWidget {
  static String route = 'privacysettings-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Profile Visibility
            ListTile(
              leading: Icon(Icons.visibility),
              title: Text('Profile Visibility'),
              subtitle: Text(
                'Choose who can view your profile and contribution details in the Ekub group.',
              ),
              trailing: DropdownButton<String>(
                value: 'Everyone',
                items: <String>['Everyone', 'Group Members Only', 'Private']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  // Add logic to update profile visibility
                },
              ),
            ),
            Divider(),

            // Data Sharing Preferences
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Data Sharing Preferences'),
              subtitle: Text(
                'Manage how your data is shared with other group members and the platform.',
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Add navigation to detailed data sharing settings
              },
            ),
            Divider(),

            // Two-Factor Authentication
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Two-Factor Authentication'),
              subtitle: Text(
                'Enable two-factor authentication to add an extra layer of security.',
              ),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Add logic to toggle two-factor authentication
                },
              ),
            ),
            Divider(),

            SizedBox(height: 16),

            Text(
              'Adjust these privacy settings to control how your information is displayed and ensure the security of your account.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Text(
              'Need Assistance?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have questions about these settings, visit the Help and About section or contact our support team.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
