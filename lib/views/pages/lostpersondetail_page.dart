import 'package:flutter/material.dart';

class LostPersonDetailPage extends StatelessWidget {
  final int id;

  final Map<int, Map<String, dynamic>> personDetails = {
    1: {
      'name': 'Alex Daniel',
      'age': 5,
      'lostDate': 'Sep 12, 2023',
      'description':
          'Alex was last seen at the park on Sep 12, 2023. He was wearing a blue shirt and grey pants.'
    },
    2: {
      'name': 'Elsa Daniel',
      'age': 3,
      'lostDate': 'Nov 12, 2023',
      'description':
          'Elsa was last seen near the shopping mall on Nov 12, 2023. She was wearing a pink dress with white shoes.'
    },
  };

  LostPersonDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final person = personDetails[id];

    if (person == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Person not found'),
        ),
        body: Center(
          child: Text('No details available for this person.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          person['name'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Name: ${person['name']}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Age: ${person['age']} years old',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Lost Date: ${person['lostDate']}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              person['description'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
