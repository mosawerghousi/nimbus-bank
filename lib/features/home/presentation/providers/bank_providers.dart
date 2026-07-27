import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock_bank_repository.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/bank_card.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/spend_category.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/user_profile.dart';

final bankRepositoryProvider = Provider<MockBankRepository>((ref) {
  return const MockBankRepository();
});

final userProvider = Provider<UserProfile>((ref) {
  return ref.watch(bankRepositoryProvider).user();
});

final accountsProvider = Provider<List<Account>>((ref) {
  return ref.watch(bankRepositoryProvider).accounts();
});

final cardsProvider = Provider<List<BankCard>>((ref) {
  return ref.watch(bankRepositoryProvider).cards();
});

final transactionsProvider = Provider<List<Transaction>>((ref) {
  return ref.watch(bankRepositoryProvider).transactions();
});

final categoriesProvider = Provider<List<SpendCategory>>((ref) {
  return ref.watch(bankRepositoryProvider).categories();
});

final contactsProvider = Provider<List<Contact>>((ref) {
  return ref.watch(bankRepositoryProvider).contacts();
});

/// Sum of every account's balance — the headline number on the dashboard.
final totalBalanceProvider = Provider<double>((ref) {
  final accounts = ref.watch(accountsProvider);
  return accounts.fold<double>(0, (sum, a) => sum + a.balance);
});

/// Which account card is centred in the home dashboard's balance carousel.
class SelectedAccountIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final selectedAccountIndexProvider =
    NotifierProvider<SelectedAccountIndexNotifier, int>(
  SelectedAccountIndexNotifier.new,
);

/// Newest-first transactions, most recent 8 — the "Recent transactions"
/// section of the dashboard.
final recentTransactionsProvider = Provider<List<Transaction>>((ref) {
  final all = [...ref.watch(transactionsProvider)];
  all.sort((a, b) => b.date.compareTo(a.date));
  return all.take(8).toList();
});

/// Newest-first transactions across the full history — used by the
/// Transactions tab.
final sortedTransactionsProvider = Provider<List<Transaction>>((ref) {
  final all = [...ref.watch(transactionsProvider)];
  all.sort((a, b) => b.date.compareTo(a.date));
  return all;
});

/// Total spend (absolute value, income excluded) for the current month,
/// grouped by category id — powers the hand-rolled spend-breakdown chart.
final transactionsByCategoryProvider = Provider<Map<String, double>>((ref) {
  final transactions = ref.watch(transactionsProvider);
  final now = MockBankRepository.anchor;
  final totals = <String, double>{};
  for (final t in transactions) {
    if (t.isIncome) continue;
    if (t.date.year != now.year || t.date.month != now.month) continue;
    totals.update(
      t.categoryId,
      (value) => value + t.amount.abs(),
      ifAbsent: () => t.amount.abs(),
    );
  }
  return totals;
});

/// Card ids the user has frozen. Mirrors [FavoritesNotifier] in the hotel
/// kit — a small [Notifier] holding a mutable set, seeded empty since
/// [BankCard.isFrozen] is only ever a mock-data default.
class CardFreezeNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => const {};

  void toggle(String cardId) {
    if (state.contains(cardId)) {
      state = {...state}..remove(cardId);
    } else {
      state = {...state, cardId};
    }
  }
}

final cardFreezeProvider =
    NotifierProvider<CardFreezeNotifier, Set<String>>(CardFreezeNotifier.new);
