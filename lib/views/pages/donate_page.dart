import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget {
  static String route = 'donate-page';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Donate",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Individuals"),
              Tab(text: "Organizations"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IndividualsList(),
            OrganizationsList(),
          ],
        ),
      ),
    );
  }
}

class IndividualsList extends StatelessWidget {
  final List<String> individuals = [
    "John Doe",
    "Jane Smith",
    "Alice Johnson",
    "Bob Brown",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: individuals.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white, // Ensure the card color is white
            elevation: 5, // Set elevation for shadow effect
            shadowColor: Colors.black12, // Soft shadow color
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(individuals[index]),
              subtitle: Text('Help this individual'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEEEFF0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ).copyWith(
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                onPressed: () {
                  // Handle donation button press
                },
                child: Text('Donate'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrganizationsList extends StatelessWidget {
  final List<String> organizations = [
    "Red Cross",
    "UNICEF",
    "Doctors Without Borders",
    "World Food Program",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white, // Ensure the card color is white
            elevation: 5, // Set elevation for shadow effect
            shadowColor: Colors.black12, // Soft shadow color
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(organizations[index]),
              subtitle: Text('Help this organization'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEEEFF0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ).copyWith(
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                onPressed: () {
                  // Handle donation button press
                },
                child: Text('Donate'),
              ),
            ),
          );
        },
      ),
    );
  }
}
