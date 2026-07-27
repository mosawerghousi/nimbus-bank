import 'package:equatable/equatable.dart';

enum CardNetwork { visa, mastercard }

extension CardNetworkLabel on CardNetwork {
  String get label => switch (this) {
        CardNetwork.visa => 'Visa',
        CardNetwork.mastercard => 'Mastercard',
      };
}

enum CardType { debit, credit, virtual }

extension CardTypeLabel on CardType {
  String get label => switch (this) {
        CardType.debit => 'Debit',
        CardType.credit => 'Credit',
        CardType.virtual => 'Virtual',
      };
}

/// A physical or virtual card. [gradientKey] selects which card-style
/// gradient (`midnight` / `violet` / `mint`) it renders with — see
/// [ColorTokens.cardMidnight]/[cardViolet]/[cardMint].
///
/// [isFrozen] is only the seed default — the authoritative frozen state at
/// runtime lives in `cardFreezeProvider`.
class BankCard extends Equatable {
  const BankCard({
    required this.id,
    required this.holderName,
    required this.last4,
    required this.expiry,
    required this.network,
    required this.type,
    required this.gradientKey,
    required this.linkedAccountId,
    this.isFrozen = false,
  });

  final String id;
  final String holderName;
  final String last4;
  final String expiry;
  final CardNetwork network;
  final CardType type;
  final String gradientKey;
  final String linkedAccountId;
  final bool isFrozen;

  String get label => 'Nimbus ${_gradientName(gradientKey)} ${type.label}';

  /// Returns a copy with [isFrozen] overridden — used to project the
  /// authoritative `cardFreezeProvider` state onto the seed mock data
  /// without mutating the source card.
  BankCard copyWithFrozen(bool frozen) {
    return BankCard(
      id: id,
      holderName: holderName,
      last4: last4,
      expiry: expiry,
      network: network,
      type: type,
      gradientKey: gradientKey,
      linkedAccountId: linkedAccountId,
      isFrozen: frozen,
    );
  }

  static String _gradientName(String key) => switch (key) {
        'midnight' => 'Midnight',
        'violet' => 'Violet',
        'mint' => 'Mint',
        _ => 'Card',
      };

  @override
  List<Object?> get props => [id, last4];
}
