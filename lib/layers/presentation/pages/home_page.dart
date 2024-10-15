import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/layers/presentation/providers/auth_provider.dart';
import 'package:notes/layers/presentation/providers/notes_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider); // Watch the auth state

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Call logout method
            },
          ),
        ],
      ),
      body: authState.when(
        initial: () => const Center(child: Text('Please log in.')),
        loading: () => const Center(child: CircularProgressIndicator()),
        authenticated: (user) {
          // Here you have access to the user object
          final userId = user.uid; // Retrieve user ID

          // Fetch notes using the userId
          ref.read(notesProvider.notifier).fetchNotes(userId);

          return Consumer(
            builder: (context, ref, _) {
              final notesState = ref.watch(notesProvider);

              // Show loading indicator while fetching notes
              if (notesState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // Show error message if any
              if (notesState.errorMessage != null) {
                return Center(
                  child: Text(
                    notesState.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              // Display the list of notes
              return ListView.builder(
                itemCount: notesState.notes.length,
                itemBuilder: (context, index) {
                  final note = notesState.notes[index];
                  return ListTile(
                    title: Text(note['title'] ?? 'No Title'),
                    subtitle: Text(note['description'] ?? 'No Description'),
                    onTap: () {
                      // Optionally, navigate to a detailed view of the note
                    },
                  );
                },
              );
            },
          );
        },
        error: (message) => Center(child: Text('Error: $message')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go('/add-note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
