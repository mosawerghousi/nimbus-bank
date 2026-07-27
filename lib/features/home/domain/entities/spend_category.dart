import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// [colorKey] is a key into [ColorTokens] (e.g. `'primary'`, `'secondary'`,
/// `'warning'`) rather than a raw [Color] — every rendered color still has
/// to be resolved from the active theme, even for mock domain data.
class SpendCategory extends Equatable {
  const SpendCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.colorKey,
  });

  final String id;
  final String label;
  final IconData icon;
  final String colorKey;

  @override
  List<Object?> get props => [id, label];
}
