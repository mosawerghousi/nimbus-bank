import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mutable draft for the request-money flow, shared across `/request` ->
/// `/request/success`. Mirrors [TransferDraft]/[TransferDraftNotifier] —
/// requesting money is simpler than sending it (no source account or
/// review step), so the draft only tracks who it's from, how much, and why.
class RequestDraft {
  const RequestDraft({
    this.contactId,
    this.amount = 0,
    this.note = '',
  });

  final String? contactId;
  final double amount;
  final String note;

  RequestDraft copyWith({
    String? contactId,
    double? amount,
    String? note,
  }) {
    return RequestDraft(
      contactId: contactId ?? this.contactId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }
}

class RequestDraftNotifier extends Notifier<RequestDraft> {
  @override
  RequestDraft build() => const RequestDraft();

  void setContact(String contactId) {
    state = state.copyWith(contactId: contactId);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setNote(String note) {
    state = state.copyWith(note: note);
  }

  /// Clears the draft back to its defaults — called whenever the
  /// request-money flow is (re-)entered so a completed request never
  /// bleeds into the next.
  void reset() {
    state = const RequestDraft();
  }
}

final requestDraftProvider =
    NotifierProvider<RequestDraftNotifier, RequestDraft>(
  RequestDraftNotifier.new,
);
