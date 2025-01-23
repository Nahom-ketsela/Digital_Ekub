import 'package:ekub/views/pages/lostpersondetail_page.dart';
import 'package:flutter/material.dart';

class LostPeoplePage extends StatelessWidget {
  static String route = 'lostpeople-page';

  final List<Map<String, dynamic>> lostPersons = [
    {
      'id': 1,
      'name': 'Alex Daniel',
      'age': 5,
      'lostDate': 'Sep 12, 2023',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'id': 2,
      'name': 'Elsa Daniel',
      'age': 3,
      'lostDate': 'Nov 12, 2023',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  Widget _buildLostPersonCard({
    required BuildContext context,
    required int id,
    required String name,
    required int age,
    required String lostDate,
    required String image,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              image,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: $name',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Age: $age years old',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Lost Date: $lostDate',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to the LostPersonDetailPage and pass the ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LostPersonDetailPage(id: id)),
                    );
                  },
                  child: Text(
                    'View more',
                    style: TextStyle(
                      color: Color(0xFF3A77B8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost People',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: lostPersons.length,
          itemBuilder: (context, index) {
            final person = lostPersons[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildLostPersonCard(
                context: context,
                id: person['id'],
                name: person['name'],
                age: person['age'],
                lostDate: person['lostDate'],
                image: person['image'],
              ),
            );
          },
        ),
      ),
    );
  }
}
