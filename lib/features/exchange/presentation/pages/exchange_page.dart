import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';

/// Static mock exchange rates, quoted relative to 1 USD. Good enough for a
/// portfolio-kit demo — no live-rate API involved.
const Map<String, double> _ratesPerUsd = {
  'USD': 1.0,
  'EUR': 0.92,
  'GBP': 0.79,
  'JPY': 156.3,
  'CAD': 1.36,
  'AUD': 1.52,
};

const Map<String, String> _currencySymbols = {
  'USD': '\$',
  'EUR': '€',
  'GBP': '£',
  'JPY': '¥',
  'CAD': 'C\$',
  'AUD': 'A\$',
};

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  late final _amountController = TextEditingController(text: '100');
  String _from = 'USD';
  String _to = 'EUR';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountController.text) ?? 0;

  double get _converted {
    final usd = _amount / _ratesPerUsd[_from]!;
    return usd * _ratesPerUsd[_to]!;
  }

  String _format(double value, String currency) {
    final symbol = _currencySymbols[currency] ?? '';
    final decimals = currency == 'JPY' ? 0 : 2;
    return '$symbol${value.toStringAsFixed(decimals)}';
  }

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      eyebrow: 'CONVERT',
      title: 'Currency exchange',
      subtitle: 'Live-style mock rates, updated as you type.',
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: context.colors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      onChanged: (_) => setState(() {}),
                      cursorColor: context.colors.primary,
                      style: AppTextStyles.displaySmall.copyWith(
                        color: context.colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                        hintStyle: AppTextStyles.displaySmall.copyWith(
                          color: context.colors.textMuted,
                        ),
                      ),
                    ),
                  ),
                  _CurrencyPicker(
                    value: _from,
                    onChanged: (v) => setState(() => _from = v),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Divider(),
              ),
              Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceElevated,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.swap_vert_rounded,
                      size: 20,
                      color: context.colors.primary,
                    ),
                    onPressed: () => setState(() {
                      final tmp = _from;
                      _from = _to;
                      _to = tmp;
                    }),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Divider(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _format(_converted, _to),
                      style: AppTextStyles.displaySmall.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  _CurrencyPicker(
                    value: _to,
                    onChanged: (v) => setState(() => _to = v),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Icon(Icons.info_outline_rounded, size: 16, color: context.colors.textMuted),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                '1 $_from = ${_format(_ratesPerUsd[_to]! / _ratesPerUsd[_from]!, _to)}',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('ALL RATES · PER 1 USD', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        ..._ratesPerUsd.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: context.colors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: AppTextStyles.titleSmall),
                  Text(
                    _format(entry.value, entry.key),
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencyPicker extends StatelessWidget {
  const _CurrencyPicker({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          dropdownColor: context.colors.surfaceElevated,
          icon: Icon(Icons.expand_more_rounded, size: 18, color: context.colors.textSecondary),
          style: AppTextStyles.titleSmall.copyWith(color: context.colors.textPrimary),
          items: _ratesPerUsd.keys
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}
