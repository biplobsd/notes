import 'package:equatable/equatable.dart';

class NotesState extends Equatable {
  final bool isLoading;
  final List<Map<String, dynamic>> notes;
  final String? errorMessage;

  const NotesState({
    this.isLoading = false,
    this.notes = const [],
    this.errorMessage,
  });

  NotesState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? notes,
    String? errorMessage,
  }) {
    return NotesState(
      isLoading: isLoading ?? this.isLoading,
      notes: notes ?? this.notes,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, notes, errorMessage];
}
