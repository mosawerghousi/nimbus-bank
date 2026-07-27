import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mutable draft for the send-money flow, shared across `/transfer` ->
/// `/transfer/review` -> `/transfer/success`. Mirrors the `BookingDraft`
/// pattern used by the hotel kit's booking flow.
class TransferDraft {
  const TransferDraft({
    required this.fromAccountId,
    this.contactId,
    this.amount = 0,
    this.note = '',
  });

  final String fromAccountId;
  final String? contactId;
  final double amount;
  final String note;

  TransferDraft copyWith({
    String? fromAccountId,
    String? contactId,
    double? amount,
    String? note,
  }) {
    return TransferDraft(
      fromAccountId: fromAccountId ?? this.fromAccountId,
      contactId: contactId ?? this.contactId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }
}

class TransferDraftNotifier extends Notifier<TransferDraft> {
  @override
  TransferDraft build() => const TransferDraft(fromAccountId: 'acc1');

  void setFromAccount(String accountId) {
    state = state.copyWith(fromAccountId: accountId);
  }

  void setContact(String contactId) {
    state = state.copyWith(contactId: contactId);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setNote(String note) {
    state = state.copyWith(note: note);
  }

  /// Clears the draft back to its defaults — called whenever the send-money
  /// flow is (re-)entered so a completed transfer never bleeds into the next.
  void reset() {
    state = const TransferDraft(fromAccountId: 'acc1');
  }
}

final transferDraftProvider =
    NotifierProvider<TransferDraftNotifier, TransferDraft>(
  TransferDraftNotifier.new,
);
