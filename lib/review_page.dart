import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'phrase_provider.dart';

class ToReviewPage extends StatelessWidget {
  const ToReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhraseProvider>(context);
    final flagged = provider.flagged.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("To Review")),
      body: flagged.isEmpty
          ? const Center(child: Text("No phrases flagged for review"))
          : ListView.builder(
              itemCount: flagged.length,
              itemBuilder: (context, index) {
                final phrase = flagged[index];
                return ListTile(
                  leading: const Icon(Icons.flag, color: Colors.orange),
                  title: Text(phrase),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => provider.toggleFlagged(phrase),
                  ),
                );
              },
            ),
    );
  }
}
