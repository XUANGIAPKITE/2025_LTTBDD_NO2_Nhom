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
      appBar: AppBar(title: const Text("Favorites")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorite phrases yet"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final phrase = favorites[index];
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(phrase),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        provider.toggleFavorite(phrase), // Xóa khỏi danh sách
                  ),
                );
              },
            ),
    );
  }
}
