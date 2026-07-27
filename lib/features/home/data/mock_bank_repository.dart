import 'package:flutter/material.dart';

import '../domain/entities/account.dart';
import '../domain/entities/bank_card.dart';
import '../domain/entities/contact.dart';
import '../domain/entities/spend_category.dart';
import '../domain/entities/transaction.dart';
import '../domain/entities/user_profile.dart';

/// In-memory mock data, curated to feel like a real neobank's ledger. All
/// imagery uses Unsplash hotlinks so the kit runs without bundled assets.
class MockBankRepository {
  const MockBankRepository();

  /// The fixed "today" every mock transaction date is offset from, so the
  /// ledger always reads as a believable trailing-30-days history no matter
  /// when the kit is actually opened. Exposed publicly so presentation code
  /// (day-group headers, "this month" filtering) anchors to the same date.
  static final DateTime anchor = DateTime(2026, 7, 27);
  static final DateTime _anchor = anchor;

  UserProfile user() => const UserProfile(
        name: 'Alex Morgan',
        email: 'alex.morgan@nimbusmail.com',
        phone: '+1 (415) 555-0138',
        avatarUrl:
            'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?auto=format&fit=crop&w=400&q=80',
        address: '148 Market Street, San Francisco, CA',
        dateOfBirth: 'March 14, 1994',
      );

  List<Account> accounts() => const [
        Account(
          id: 'acc1',
          name: 'Everyday',
          type: AccountType.checking,
          balance: 4230.18,
          currency: 'USD',
          accountNumber: '8832015566',
          colorKey: 'midnight',
        ),
        Account(
          id: 'acc2',
          name: 'Savings',
          type: AccountType.savings,
          balance: 18450.72,
          currency: 'USD',
          accountNumber: '7714402298',
          colorKey: 'mint',
        ),
        Account(
          id: 'acc3',
          name: 'Joint',
          type: AccountType.joint,
          balance: 2104.55,
          currency: 'USD',
          accountNumber: '5591008834',
          colorKey: 'violet',
        ),
      ];

  List<BankCard> cards() => const [
        BankCard(
          id: 'c1',
          holderName: 'Alex Morgan',
          last4: '4821',
          expiry: '09/28',
          network: CardNetwork.visa,
          type: CardType.debit,
          gradientKey: 'midnight',
          linkedAccountId: 'acc1',
        ),
        BankCard(
          id: 'c2',
          holderName: 'Alex Morgan',
          last4: '2290',
          expiry: '03/27',
          network: CardNetwork.mastercard,
          type: CardType.credit,
          gradientKey: 'violet',
          linkedAccountId: 'acc3',
        ),
        BankCard(
          id: 'c3',
          holderName: 'Alex Morgan',
          last4: '7734',
          expiry: '12/29',
          network: CardNetwork.visa,
          type: CardType.virtual,
          gradientKey: 'mint',
          linkedAccountId: 'acc2',
        ),
      ];

  List<SpendCategory> categories() => const [
        SpendCategory(
          id: 'groceries',
          label: 'Groceries',
          icon: Icons.local_grocery_store_rounded,
          colorKey: 'secondary',
        ),
        SpendCategory(
          id: 'transport',
          label: 'Transport',
          icon: Icons.directions_car_filled_rounded,
          colorKey: 'warning',
        ),
        SpendCategory(
          id: 'subscriptions',
          label: 'Subscriptions',
          icon: Icons.subscriptions_rounded,
          colorKey: 'primary',
        ),
        SpendCategory(
          id: 'dining',
          label: 'Dining',
          icon: Icons.restaurant_rounded,
          colorKey: 'error',
        ),
        SpendCategory(
          id: 'shopping',
          label: 'Shopping',
          icon: Icons.shopping_bag_rounded,
          colorKey: 'primarySoft',
        ),
        SpendCategory(
          id: 'entertainment',
          label: 'Entertainment',
          icon: Icons.movie_rounded,
          colorKey: 'primaryDeep',
        ),
        SpendCategory(
          id: 'income',
          label: 'Income',
          icon: Icons.savings_rounded,
          colorKey: 'textSecondary',
        ),
        SpendCategory(
          id: 'transfers',
          label: 'Transfers',
          icon: Icons.swap_horiz_rounded,
          colorKey: 'textMuted',
        ),
      ];

  List<Contact> contacts() => const [
        Contact(
          id: 'ct1',
          name: 'Sam Patel',
          avatarUrl:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 4471',
        ),
        Contact(
          id: 'ct2',
          name: 'Jordan Lee',
          avatarUrl:
              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 2298',
        ),
        Contact(
          id: 'ct3',
          name: 'Priya Nair',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 9012',
        ),
        Contact(
          id: 'ct4',
          name: 'Marcus Webb',
          avatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 6650',
        ),
        Contact(
          id: 'ct5',
          name: 'Elena Cruz',
          avatarUrl:
              'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 3384',
        ),
        Contact(
          id: 'ct6',
          name: 'Noah Kim',
          avatarUrl:
              'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 7729',
        ),
        Contact(
          id: 'ct7',
          name: 'Zara Ahmed',
          avatarUrl:
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 1123',
        ),
        Contact(
          id: 'ct8',
          name: 'Liam O’Connor',
          avatarUrl:
              'https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=200&q=80',
          accountNumberMasked: '•••• 5567',
        ),
      ];

  List<Transaction> transactions() {
    DateTime daysAgo(int n) => _anchor.subtract(Duration(days: n));

    return [
      Transaction(
        id: 't1',
        merchant: 'Whole Foods Market',
        categoryId: 'groceries',
        amount: -84.32,
        date: daysAgo(0),
        accountId: 'acc1',
        icon: Icons.local_grocery_store_rounded,
      ),
      Transaction(
        id: 't2',
        merchant: 'Acme Corp Payroll',
        categoryId: 'income',
        amount: 5200.00,
        date: daysAgo(1),
        accountId: 'acc1',
        icon: Icons.attach_money_rounded,
      ),
      Transaction(
        id: 't3',
        merchant: 'Uber',
        categoryId: 'transport',
        amount: -18.40,
        date: daysAgo(1),
        accountId: 'acc1',
        icon: Icons.local_taxi_rounded,
      ),
      Transaction(
        id: 't4',
        merchant: 'Spotify',
        categoryId: 'subscriptions',
        amount: -10.99,
        date: daysAgo(2),
        accountId: 'acc1',
        icon: Icons.music_note_rounded,
      ),
      Transaction(
        id: 't5',
        merchant: 'Blue Bottle Coffee',
        categoryId: 'dining',
        amount: -6.75,
        date: daysAgo(2),
        accountId: 'acc1',
        icon: Icons.coffee_rounded,
      ),
      Transaction(
        id: 't6',
        merchant: 'Amazon',
        categoryId: 'shopping',
        amount: -142.18,
        date: daysAgo(3),
        accountId: 'acc1',
        icon: Icons.shopping_bag_rounded,
      ),
      Transaction(
        id: 't7',
        merchant: 'Netflix',
        categoryId: 'subscriptions',
        amount: -15.49,
        date: daysAgo(3),
        accountId: 'acc1',
        icon: Icons.movie_creation_outlined,
      ),
      Transaction(
        id: 't8',
        merchant: 'Chipotle',
        categoryId: 'dining',
        amount: -13.85,
        date: daysAgo(4),
        accountId: 'acc1',
        icon: Icons.restaurant_rounded,
      ),
      Transaction(
        id: 't9',
        merchant: 'Transfer to Jordan Lee',
        categoryId: 'transfers',
        amount: -60.00,
        date: daysAgo(4),
        accountId: 'acc1',
        icon: Icons.swap_horiz_rounded,
      ),
      Transaction(
        id: 't10',
        merchant: 'Shell Gas Station',
        categoryId: 'transport',
        amount: -47.60,
        date: daysAgo(5),
        accountId: 'acc1',
        icon: Icons.local_gas_station_rounded,
      ),
      Transaction(
        id: 't11',
        merchant: 'Trader Joe’s',
        categoryId: 'groceries',
        amount: -56.20,
        date: daysAgo(6),
        accountId: 'acc1',
        icon: Icons.local_grocery_store_rounded,
      ),
      Transaction(
        id: 't12',
        merchant: 'AMC Theatres',
        categoryId: 'entertainment',
        amount: -32.00,
        date: daysAgo(6),
        accountId: 'acc3',
        icon: Icons.local_movies_rounded,
      ),
      Transaction(
        id: 't13',
        merchant: 'Target',
        categoryId: 'shopping',
        amount: -98.47,
        date: daysAgo(7),
        accountId: 'acc1',
        icon: Icons.shopping_bag_rounded,
      ),
      Transaction(
        id: 't14',
        merchant: 'Adobe Creative Cloud',
        categoryId: 'subscriptions',
        amount: -54.99,
        date: daysAgo(8),
        accountId: 'acc1',
        icon: Icons.subscriptions_rounded,
      ),
      Transaction(
        id: 't15',
        merchant: 'Sweetgreen',
        categoryId: 'dining',
        amount: -15.30,
        date: daysAgo(8),
        accountId: 'acc1',
        icon: Icons.restaurant_rounded,
      ),
      Transaction(
        id: 't16',
        merchant: 'Lyft',
        categoryId: 'transport',
        amount: -22.15,
        date: daysAgo(9),
        accountId: 'acc1',
        icon: Icons.local_taxi_rounded,
      ),
      Transaction(
        id: 't17',
        merchant: 'Freelance Client Payment',
        categoryId: 'income',
        amount: 860.00,
        date: daysAgo(9),
        accountId: 'acc3',
        icon: Icons.attach_money_rounded,
      ),
      Transaction(
        id: 't18',
        merchant: 'Zara',
        categoryId: 'shopping',
        amount: -76.90,
        date: daysAgo(10),
        accountId: 'acc3',
        icon: Icons.shopping_bag_rounded,
      ),
      Transaction(
        id: 't19',
        merchant: 'Metro Transit',
        categoryId: 'transport',
        amount: -5.50,
        date: daysAgo(11),
        accountId: 'acc1',
        icon: Icons.directions_bus_filled_rounded,
      ),
      Transaction(
        id: 't20',
        merchant: 'Safeway',
        categoryId: 'groceries',
        amount: -63.75,
        date: daysAgo(12),
        accountId: 'acc1',
        icon: Icons.local_grocery_store_rounded,
      ),
      Transaction(
        id: 't21',
        merchant: 'Steam',
        categoryId: 'entertainment',
        amount: -29.99,
        date: daysAgo(13),
        accountId: 'acc1',
        icon: Icons.sports_esports_rounded,
      ),
      Transaction(
        id: 't22',
        merchant: 'Nike',
        categoryId: 'shopping',
        amount: -110.00,
        date: daysAgo(14),
        accountId: 'acc1',
        icon: Icons.shopping_bag_rounded,
      ),
      Transaction(
        id: 't23',
        merchant: 'iCloud+',
        categoryId: 'subscriptions',
        amount: -2.99,
        date: daysAgo(15),
        accountId: 'acc1',
        icon: Icons.cloud_outlined,
      ),
      Transaction(
        id: 't24',
        merchant: 'Transfer from Sam Patel',
        categoryId: 'transfers',
        amount: 40.00,
        date: daysAgo(16),
        accountId: 'acc1',
        icon: Icons.swap_horiz_rounded,
      ),
      Transaction(
        id: 't25',
        merchant: 'Local Bistro',
        categoryId: 'dining',
        amount: -68.40,
        date: daysAgo(17),
        accountId: 'acc3',
        icon: Icons.restaurant_rounded,
      ),
      Transaction(
        id: 't26',
        merchant: 'Ticketmaster',
        categoryId: 'entertainment',
        amount: -120.00,
        date: daysAgo(19),
        accountId: 'acc1',
        icon: Icons.confirmation_number_rounded,
      ),
      Transaction(
        id: 't27',
        merchant: 'Whole Foods Market',
        categoryId: 'groceries',
        amount: -47.10,
        date: daysAgo(21),
        accountId: 'acc1',
        icon: Icons.local_grocery_store_rounded,
      ),
      Transaction(
        id: 't28',
        merchant: 'Venmo Cash Out',
        categoryId: 'transfers',
        amount: -200.00,
        date: daysAgo(24),
        accountId: 'acc1',
        icon: Icons.swap_horiz_rounded,
      ),
      Transaction(
        id: 't29',
        merchant: 'Uber',
        categoryId: 'transport',
        amount: -24.60,
        date: daysAgo(27),
        accountId: 'acc1',
        icon: Icons.local_taxi_rounded,
      ),
      Transaction(
        id: 't30',
        merchant: 'Acme Corp Payroll',
        categoryId: 'income',
        amount: 5200.00,
        date: daysAgo(29),
        accountId: 'acc1',
        icon: Icons.attach_money_rounded,
      ),
    ];
  }
}
