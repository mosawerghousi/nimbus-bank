import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// A single ledger entry. [amount] is signed: negative for spend, positive
/// for income/deposits.
class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.merchant,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.accountId,
    required this.icon,
    this.status = 'Completed',
  });

  final String id;
  final String merchant;
  final String categoryId;
  final double amount;
  final DateTime date;
  final String accountId;
  final IconData icon;
  final String status;

  bool get isIncome => amount > 0;

  @override
  List<Object?> get props => [id, merchant, amount, date];
}
