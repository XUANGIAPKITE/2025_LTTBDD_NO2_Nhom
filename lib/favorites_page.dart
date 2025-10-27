import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'phrase_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhraseProvider>(context);
    final favorites = provider.favorites.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.teal,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorite phrases yet",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final phrase = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(phrase),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        provider.toggleFavorite(phrase);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Removed from favorites'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
