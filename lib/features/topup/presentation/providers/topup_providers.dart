import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mutable draft for the top-up (add money) flow, shared across `/topup`
/// -> `/topup/success`. Mirrors [TransferDraft]/[TransferDraftNotifier].
class TopUpDraft {
  const TopUpDraft({
    this.sourceLabel = 'Chase Total Checking',
    this.toAccountId,
    this.amount = 0,
  });

  /// Display label for the mock external funding source picked in the
  /// "FROM" chip row — there's no real entity behind it since the money is
  /// coming from outside Nimbus.
  final String sourceLabel;
  final String? toAccountId;
  final double amount;

  TopUpDraft copyWith({
    String? sourceLabel,
    String? toAccountId,
    double? amount,
  }) {
    return TopUpDraft(
      sourceLabel: sourceLabel ?? this.sourceLabel,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
    );
  }
}

class TopUpDraftNotifier extends Notifier<TopUpDraft> {
  @override
  TopUpDraft build() => const TopUpDraft();

  void setSource(String sourceLabel) {
    state = state.copyWith(sourceLabel: sourceLabel);
  }

  void setToAccount(String accountId) {
    state = state.copyWith(toAccountId: accountId);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  /// Clears the draft back to its defaults — called whenever the top-up
  /// flow is (re-)entered so a completed top-up never bleeds into the next.
  void reset() {
    state = const TopUpDraft();
  }
}

final topUpDraftProvider = NotifierProvider<TopUpDraftNotifier, TopUpDraft>(
  TopUpDraftNotifier.new,
);
