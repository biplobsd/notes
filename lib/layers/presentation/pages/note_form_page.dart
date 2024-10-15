import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/layers/presentation/providers/auth_provider.dart';
import 'package:notes/layers/presentation/providers/notes_notifier.dart';

class NoteFormPage extends ConsumerStatefulWidget {
  final String? noteId;
  final String? initialTitle;
  final String? initialDescription;

  const NoteFormPage({
    super.key,
    this.noteId,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  _NoteFormPageState createState() => _NoteFormPageState();
}

class _NoteFormPageState extends ConsumerState<NoteFormPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with either initial values for editing or empty values for adding
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveOrUpdateNote() async {
    final userId = ref.read(authProvider).maybeWhen(
          authenticated: (user) => user.uid,
          orElse: () => null,
        );

    if (userId == null) {
      // Handle the case where the user ID is not available
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // If noteId is provided, we're updating an existing note; otherwise, we're adding a new note
    if (widget.noteId != null) {
      await ref.read(notesProvider.notifier).updateNote(
            userId,
            widget.noteId!,
            _titleController.text,
            _descriptionController.text,
          );
    } else {
      await ref.read(notesProvider.notifier).addNote(
            userId,
            _titleController.text,
            _descriptionController.text,
          );
    }

    setState(() {
      _isLoading = false;
    });

    // Navigate back to the home page
    GoRouter.of(context).go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveOrUpdateNote,
              child: Text(widget.noteId == null ? 'Save Note' : 'Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
