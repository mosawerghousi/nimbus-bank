import 'package:flutter_riverpod/flutter_riverpod.dart';

/// An outside bank the member has connected via "Link a new bank". Plain
/// (not [Equatable]) since it's presentation-only mock data — it doesn't
/// belong to the `home` feature's real domain the way [Account]/[BankCard]
/// do.
class ExternalAccount {
  const ExternalAccount(this.name, this.maskedNumber);

  final String name;
  final String maskedNumber;
}

/// The member's connected outside banks, seeded with the two the Linked
/// Accounts screen originally hardcoded. [add] appends a newly-connected
/// bank from the "Link a new bank" flow.
class ExternalAccountsNotifier extends Notifier<List<ExternalAccount>> {
  @override
  List<ExternalAccount> build() => const [
        ExternalAccount('Chase Total Checking', '•••• 5511'),
        ExternalAccount('Ally Online Savings', '•••• 8820'),
      ];

  void add(ExternalAccount account) => state = [...state, account];
}

final externalAccountsProvider =
    NotifierProvider<ExternalAccountsNotifier, List<ExternalAccount>>(
  ExternalAccountsNotifier.new,
);
