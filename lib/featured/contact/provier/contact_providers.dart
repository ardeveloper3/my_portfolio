// lib/featured/contact/provier/contact_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ContactFormStatus { idle, loading, success, error }

class ContactFormState {
  final String name;
  final String email;
  final String message;
  final ContactFormStatus status;
  final String? errorMessage;

  const ContactFormState({
    this.name = '',
    this.email = '',
    this.message = '',
    this.status = ContactFormStatus.idle,
    this.errorMessage,
  });

  ContactFormState copyWith({
    String? name,
    String? email,
    String? message,
    ContactFormStatus? status,
    String? errorMessage,
  }) {
    return ContactFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ContactFormNotifier extends Notifier<ContactFormState> {
  @override
  ContactFormState build() => const ContactFormState();

  void updateName(String v) => state = state.copyWith(name: v);
  void updateEmail(String v) => state = state.copyWith(email: v);
  void updateMessage(String v) => state = state.copyWith(message: v);

  bool get isValid =>
      state.name.isNotEmpty &&
      state.email.contains('@') &&
      state.message.length >= 10;

  Future<void> submit() async {
    if (!isValid) return;
    state = state.copyWith(status: ContactFormStatus.loading);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(status: ContactFormStatus.success);
  }

  void reset() => state = const ContactFormState();
}

final contactFormProvider = NotifierProvider<ContactFormNotifier, ContactFormState>(
  () => ContactFormNotifier(),
);
