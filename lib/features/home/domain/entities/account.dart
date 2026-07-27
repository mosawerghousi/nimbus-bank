import 'package:equatable/equatable.dart';

enum AccountType { checking, savings, joint }

extension AccountTypeLabel on AccountType {
  String get label => switch (this) {
        AccountType.checking => 'Checking',
        AccountType.savings => 'Savings',
        AccountType.joint => 'Joint',
      };
}

/// A held-away bank account. [colorKey] selects which card-style gradient
/// (`midnight` / `violet` / `mint`) the balance carousel renders it with —
/// see [ColorTokens.cardMidnight]/[cardViolet]/[cardMint].
class Account extends Equatable {
  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
    required this.accountNumber,
    required this.colorKey,
  });

  final String id;
  final String name;
  final AccountType type;
  final double balance;
  final String currency;
  final String accountNumber;
  final String colorKey;

  String get maskedNumber => '•••• ${accountNumber.substring(accountNumber.length - 4)}';

  @override
  List<Object?> get props => [id, name, balance];
}
