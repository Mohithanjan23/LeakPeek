import 'package:flutter/material.dart';

// You should replace this with your actual data model.
class BreachData {
  final String title;
  final String description;
  BreachData({required this.title, required this.description});
}

class ResultsScreen extends StatelessWidget {
  final List<BreachData> breaches;

  const ResultsScreen({super.key, required this.breaches});

  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          breaches.isEmpty ? 'NO RESULTS' : 'RESULTS',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: breaches.isEmpty ? _buildEmptyState() : _buildResultsList(),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, color: primaryColor, size: 100),
          SizedBox(height: 20),
          Text(
            'No breaches\nNo pastes',
            textAlign: TextAlign.center,
            style: TextStyle(color: lightTextColor, fontSize: 20, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: breaches.length,
      itemBuilder: (context, index) {
        final breach = breaches[index];
        return _ResultListItem(breach: breach);
      },
    );
  }
}

class _ResultListItem extends StatelessWidget {
  final BreachData breach;

  const _ResultListItem({required this.breach});

  static const Color itemColor = Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: itemColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        leading: const Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 40,
        ),
        title: Text(
          breach.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          breach.description,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: () {
          // TODO: Navigate to the "Suggestions" screen
        },
      ),
    );
  }
}
