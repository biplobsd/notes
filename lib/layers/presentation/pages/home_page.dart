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
        title: authState.when(
          authenticated: (user) => Text('Notes - ${user.name}'),
          error: (message) => Text('Notes - $message'),
          initial: () => const Text('Notes - ...'),
          loading: () => const Text('Note - loading...'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: authState.when(
        initial: () {
          Future.microtask(() {
            context.go('/login');
          });
          const Center(child: Text('Please log in.'));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        authenticated: (user) {
          // Here you have access to the user object
          final userId = user.uid; // Retrieve user ID

          // Fetch notes using the userId
          Future.microtask(() {
            ref.read(notesProvider.notifier).fetchNotes(userId);
          });

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

              // Display no notes
              if (notesState.notes.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note, size: 64.0), // Displaying a note icon
                      SizedBox(height: 10),
                      Text(
                        'No Notes Yet!',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                );
              }

              // Display the list of notes
              return ListView.builder(
                itemCount: notesState.notes.length,
                itemBuilder: (context, index) {
                  final note = notesState.notes[index];
                  void editPressFun() =>
                      context.pushNamed('/note', queryParameters: {
                        'noteId': note['noteId'],
                        'title': note['title'],
                        'description': note['description'],
                      });
                  return ListTile(
                    title: Text(note['title'] ?? 'No Title'),
                    subtitle: Text(note['description'] ?? 'No Description'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit), // Edit button
                          onPressed: editPressFun,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete), // Delete button
                          onPressed: () {
                            // Call the delete note method
                            ref
                                .read(notesProvider.notifier)
                                .deleteNote(userId, note['noteId']);
                          },
                        ),
                      ],
                    ),
                    onTap: editPressFun,
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
          context.pushNamed('/note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
