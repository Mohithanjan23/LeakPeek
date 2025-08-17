import 'package:flutter/material.dart';

class BreachResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> breaches;
  final String searchTerm;

  const BreachResultsScreen({
    Key? key,
    required this.breaches,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Color(0xFF6B46C1),
      ),
      body: breaches.isEmpty ? _buildNoBreachesFound() : _buildBreachList(),
    );
  }

  Widget _buildNoBreachesFound() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'No breaches found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Good news! Your email "$searchTerm" was not found in any known data breaches.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreachList() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${breaches.length} breach(es) found for "$searchTerm"',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: breaches.length,
              itemBuilder: (context, index) {
                final breach = breaches[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF6B46C1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.security,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      breach['name'] ?? 'Unknown Breach',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${breach['breachDate'] ?? 'Unknown'}'),
                        Text(
                            'Compromised data: ${breach['dataClasses']?.join(', ') ?? 'Unknown'}'),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
