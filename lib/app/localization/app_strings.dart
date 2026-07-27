import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/home/domain/entities/account.dart';
import '../../features/home/domain/entities/bank_card.dart';
import 'app_strings_ar.dart';
import 'app_strings_en.dart';

/// Hand-rolled localization surface for Nimbus — same shape `flutter
/// gen-l10n` would generate, just written by hand so no codegen step is
/// required. One getter/method per user-facing string in the app; call
/// sites read `context.strings.someLabel` (see the `strings` extension in
/// `core/extensions/context_extensions.dart`).
///
/// Interpolated strings are methods (e.g. [cardsLinked]); everything else is
/// a plain getter. Enum "label" vocabulary (account/card types, spend
/// categories) is exposed as simple getters plus a handful of concrete
/// combinator methods below that switch over the enum and pick the right
/// getter — so [AppStringsEn]/[AppStringsAr] only ever implement getters.
abstract class AppStrings {
  const AppStrings();

  static AppStrings of(BuildContext context) =>
      Localizations.of<AppStrings>(context, AppStrings)!;

  static const LocalizationsDelegate<AppStrings> delegate =
      _AppStringsDelegate();

  // ---------------------------------------------------------------------
  // Common / shared vocabulary
  // ---------------------------------------------------------------------
  String get commonContinue;
  String get commonDone;
  String get commonClose;
  String get commonCancel;
  String get commonSave;
  String get commonAmount;
  String get commonStatus;
  String get commonFree;
  String get commonFee;
  String get commonPending;
  String get commonRevoke;
  String get commonToday;
  String get commonYesterday;
  String get commonAll;
  String get commonOther;

  // ---------------------------------------------------------------------
  // App / brand
  // ---------------------------------------------------------------------
  String get appTagline;

  // ---------------------------------------------------------------------
  // Onboarding
  // ---------------------------------------------------------------------
  String get onboardingSkip;
  String get onboardingGetStarted;
  String get onboardingSlide1Eyebrow;
  String get onboardingSlide1Title;
  String get onboardingSlide1Body;
  String get onboardingSlide2Eyebrow;
  String get onboardingSlide2Title;
  String get onboardingSlide2Body;
  String get onboardingSlide3Eyebrow;
  String get onboardingSlide3Title;
  String get onboardingSlide3Body;

  // ---------------------------------------------------------------------
  // Auth — login & register
  // ---------------------------------------------------------------------
  String get authWelcomeBack;
  String get authSignInTitle;
  String get authEmailLabel;
  String get authEmailRequired;
  String get authEmailInvalid;
  String get authPasswordLabel;
  String get authPasswordRequired;
  String authPasswordMinLength(int count);
  String get authRememberMe;
  String get authForgotPassword;
  String get authSignIn;
  String get authOrContinueWith;
  String authSocialContinuing(String provider);
  String get authNewToNimbus;
  String get authCreateAccount;
  String authResetLinkSent(String email);
  String get authResetLinkPrompt;
  String get authSendResetLink;
  String get authAcceptTermsError;
  String get authJoinNimbus;
  String get authCreateAccountTitle;
  String get authFullNameLabel;
  String get authFullNameRequired;
  String get authAgreeToTermsPrefix;
  String get authTermsOfService;
  String get authAgreeToTermsAnd;
  String get authPrivacyPolicy;
  String get authAgreeToTermsSuffix;
  String get authOrSignUpWith;
  String get authAlreadyMember;

  // ---------------------------------------------------------------------
  // Cards
  // ---------------------------------------------------------------------
  String get cardsWallet;
  String get cardsYourCards;
  String cardsLinked(int count);
  String get cardsAddNewCard;
  String get cardsCardType;
  String get cardTypeDebit;
  String get cardTypeCredit;
  String get cardTypeVirtual;
  String get cardTypeDebitDescription;
  String get cardTypeCreditDescription;
  String get cardTypeVirtualDescription;
  String get cardsDesign;
  String get cardsCreateCard;
  String get cardsUnfreezeCard;
  String get cardsFreezeCard;
  String get cardsHideNumber;
  String get cardsRevealNumber;
  String get cardsFrozenNotice;
  String get cardsManage;
  String get cardsSettings;
  String get cardsChangePin;
  String get cardsSpendingLimit;
  String get cardsReportLostStolen;
  String get pinChangeRequestSnack;
  String get cardsSpendingLimitSnack;
  String get cardsReportLostStolenSnack;
  String get cardCardholder;
  String get cardExpires;
  String get cardFrozenBadge;
  String get cardNetworkVisa;
  String get cardNetworkMastercard;

  // ---------------------------------------------------------------------
  // Account types
  // ---------------------------------------------------------------------
  String get accountTypeChecking;
  String get accountTypeSavings;
  String get accountTypeJoint;

  // ---------------------------------------------------------------------
  // Spend categories
  // ---------------------------------------------------------------------
  String get spendCategoryGroceries;
  String get spendCategoryTransport;
  String get spendCategorySubscriptions;
  String get spendCategoryDining;
  String get spendCategoryShopping;
  String get spendCategoryEntertainment;
  String get spendCategoryIncome;
  String get spendCategoryTransfers;

  // ---------------------------------------------------------------------
  // Home dashboard
  // ---------------------------------------------------------------------
  String get homeGoodMorning;
  String get homeGoodAfternoon;
  String get homeGoodEvening;
  String get homeAvailableBalance;
  String get homeThisMonthEyebrow;
  String get homeSpendingOverview;
  String get homeDetails;
  String get homeLatestActivityEyebrow;
  String get homeRecentTransactions;
  String get homeSeeAll;
  String get quickActionSend;
  String get quickActionRequest;
  String get quickActionTopUp;
  String get quickActionMore;
  String get moreActionsTitle;
  String get moreActionsStatements;
  String get moreActionsCurrencyExchange;
  String get moreActionsReferFriend;
  String get helpSupport;

  // ---------------------------------------------------------------------
  // Spend chart
  // ---------------------------------------------------------------------
  String get spendChartNoSpending;
  String get spendChartTotalSpent;

  // ---------------------------------------------------------------------
  // Transaction detail
  // ---------------------------------------------------------------------
  String get transactionCategory;
  String get transactionDate;
  String get transactionAccount;
  String get transactionStatusCompleted;

  // ---------------------------------------------------------------------
  // Transactions (Activity tab)
  // ---------------------------------------------------------------------
  String get transactionsActivityEyebrow;
  String get transactionsTitle;
  String get transactionsSearchHint;
  String get transactionsThisMonth;
  String get transactionsEmptyTitle;
  String get transactionsEmptyBody;

  // ---------------------------------------------------------------------
  // Transfer (send money)
  // ---------------------------------------------------------------------
  String get transferSendMoney;
  String get transferChooseRecipient;
  String get errorAmountTooLow;
  String transferFromAccount(String name, String masked);
  String get transferSendFrom;
  String get transferSendTo;
  String get transferNoteOptional;
  String get transferNoteHint;

  String get transferReviewTitle;
  String get transferYoureSending;
  String transferToContact(String name);
  String get transferFromLabel;
  String get transferToLabel;
  String get transferNoteLabel;
  String get transferFeeLabel;
  String get transferNoNoteAdded;
  String get transferTotalLabel;
  String transferInstantNote(String firstName);
  String get transferConfirmSend;

  String get transferMoneySent;
  String transferSentBody(String amount, String name);

  // ---------------------------------------------------------------------
  // Request money
  // ---------------------------------------------------------------------
  String get requestMoney;
  String get requestNotifyHint;
  String get requestChooseContact;
  String get requestFromEyebrow;
  String get requestButton;

  String get requestSentTitle;
  String requestSentBody(String amount, String name);

  // ---------------------------------------------------------------------
  // Top up
  // ---------------------------------------------------------------------
  String get topupAddMoney;
  String get topupChooseAccount;
  String topupIntoAccount(String name, String masked);
  String get topupFromEyebrow;
  String get topupToEyebrow;
  String get topupAddFunds;

  String get topupMoneyAdded;
  String topupAddedBody(String amount, String source, String account);
  String get topupAdded;
  String get topupNewBalance;

  // ---------------------------------------------------------------------
  // Statements
  // ---------------------------------------------------------------------
  String get statementsEyebrow;
  String get statementsTitle;
  String get statementsSubtitle;
  String get statementsLast6Months;
  String statementsTransactionsCount(int count);
  String statementsSpentEarned(String spent, String income);
  String get statementsNoSpending;

  // ---------------------------------------------------------------------
  // Currency exchange
  // ---------------------------------------------------------------------
  String get exchangeEyebrow;
  String get exchangeTitle;
  String get exchangeSubtitle;
  String get exchangeAllRates;

  // ---------------------------------------------------------------------
  // Refer a friend
  // ---------------------------------------------------------------------
  String get referEyebrow;
  String get referTitle;
  String get referSubtitle;
  String get referGiveGet;
  String get referGiveGetBody;
  String get referYourCode;
  String get referCopyCode;
  String get referCopiedSnack;
  String get referHowItWorks;
  String get referStep1Title;
  String get referStep1Body;
  String get referStep2Title;
  String get referStep2Body;
  String get referStep3Title;
  String get referStep3Body;

  // ---------------------------------------------------------------------
  // Connect an outside bank
  // ---------------------------------------------------------------------
  String get connectBankLinkAccount;
  String get connectBankTitle;
  String get connectBankSubtitle;
  String connectBankConnecting(String bankName);
  String get connectBankTakesMoment;
  String connectBankConnected(String bankName);
  String get connectBankSeeUnderExternal;

  // ---------------------------------------------------------------------
  // Help & support
  // ---------------------------------------------------------------------
  String get helpEyebrow;
  String get helpSubtitle;
  String get helpFrequentlyAsked;
  String get helpFaq1Q;
  String get helpFaq1A;
  String get helpFaq2Q;
  String get helpFaq2A;
  String get helpFaq3Q;
  String get helpFaq3A;
  String get helpFaq4Q;
  String get helpFaq4A;
  String get helpContactSupport;
  String get helpChatWithUs;
  String get helpChatSublabel;
  String get helpCallSupport;
  String get helpCallSublabel;
  String get helpEmailUs;
  String get helpConnectingSnack;
  String get helpCallingSnack;
  String get helpEmailSnack;

  // ---------------------------------------------------------------------
  // Linked accounts
  // ---------------------------------------------------------------------
  String get linkedAccountsEyebrow;
  String get linkedAccountsTitle;
  String get linkedAccountsSubtitle;
  String get linkNewBank;
  String get linkedAccountsNimbusAccounts;
  String get linkedAccountsExternalBanks;
  String get linkedAccountsConnectedBadge;

  // ---------------------------------------------------------------------
  // Notifications
  // ---------------------------------------------------------------------
  String get notificationsEyebrow;
  String get notificationsTitle;
  String get notificationsAllCaughtUp;
  String notificationsUnreadCount(int count);
  String get notificationsMarkAllRead;
  String get notificationsEarlier;
  String get notificationsEmptyTitle;
  String get notificationsEmptyBody;
  String get notifPayrollTitle;
  String get notifPayrollBody;
  String get notifSignInTitle;
  String get notifSignInBody;
  String get notifSavingsRateTitle;
  String get notifSavingsRateBody;
  String get notifCardDeclinedTitle;
  String get notifCardDeclinedBody;
  String get notifStatementReadyTitle;
  String get notifStatementReadyBody;
  String get notifReferTitle;
  String get notifReferBody;
  String get notifTimeAgo2h;
  String get notifTimeAgo5h;
  String get notifTimeAgo7h;
  String get notifTimeAgo3d;
  String get notifTimeAgo1w;

  // ---------------------------------------------------------------------
  // Personal info
  // ---------------------------------------------------------------------
  String get personalInfoEyebrow;
  String get personalInfoTitle;
  String get personalInfoSubtitle;
  String get fieldPhone;
  String get fieldAddress;
  String get fieldDateOfBirth;
  String editFieldTitle(String fieldLabel);

  // ---------------------------------------------------------------------
  // Security & PIN
  // ---------------------------------------------------------------------
  String get securityEyebrow;
  String get securityTitle;
  String get securitySubtitle;
  String get securityAppPin;
  String get securityLastChanged;
  String get securityFaceId;
  String get securityFaceIdSub;
  String get securityTwoFactor;
  String get securityTwoFactorSub;
  String get securitySignInAlerts;
  String get securitySignInAlertsSub;
  String get securityActiveSessions;
  String get securityThisDeviceActive;
  String securityLastActive(String time);
  String get securityTwoDaysAgo;
  String securitySessionRevoked(String device);

  // ---------------------------------------------------------------------
  // Profile
  // ---------------------------------------------------------------------
  String get profileVerifiedMember;
  String get profileAccountsStat;
  String get profileSinceStat;
  String get profileMemberSince;
  String get profileAppearance;
  String get profileTheme;
  String get profileLanguageEyebrow;
  String get profileLanguage;
  String get profileAccountEyebrow;
  String get profileSettingsHeadline;
  String get menuLogOut;
  String get logOutConfirmTitle;
  String get logOutConfirmBody;

  // ---------------------------------------------------------------------
  // Bottom nav
  // ---------------------------------------------------------------------
  String get navHome;
  String get navCards;
  String get navActivity;
  String get navProfile;

  // ---------------------------------------------------------------------
  // Language selector
  // ---------------------------------------------------------------------
  String get languageEnglish;
  String get languageArabic;

  // ---------------------------------------------------------------------
  // Theme mode selector
  // ---------------------------------------------------------------------
  String get themeLight;
  String get themeSystem;
  String get themeDark;

  // ---------------------------------------------------------------------
  // Enum-label combinators — the concrete switch logic lives once here;
  // [AppStringsEn]/[AppStringsAr] only ever implement the plain getters
  // above that these switch over.
  // ---------------------------------------------------------------------
  String accountTypeLabel(AccountType type) => switch (type) {
        AccountType.checking => accountTypeChecking,
        AccountType.savings => accountTypeSavings,
        AccountType.joint => accountTypeJoint,
      };

  String cardTypeLabel(CardType type) => switch (type) {
        CardType.debit => cardTypeDebit,
        CardType.credit => cardTypeCredit,
        CardType.virtual => cardTypeVirtual,
      };

  String cardNetworkLabel(CardNetwork network) => switch (network) {
        CardNetwork.visa => cardNetworkVisa,
        CardNetwork.mastercard => cardNetworkMastercard,
      };

  String spendCategoryLabel(String categoryId) => switch (categoryId) {
        'groceries' => spendCategoryGroceries,
        'transport' => spendCategoryTransport,
        'subscriptions' => spendCategorySubscriptions,
        'dining' => spendCategoryDining,
        'shopping' => spendCategoryShopping,
        'entertainment' => spendCategoryEntertainment,
        'income' => spendCategoryIncome,
        'transfers' => spendCategoryTransfers,
        _ => commonOther,
      };
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'en' || locale.languageCode == 'ar';

  @override
  Future<AppStrings> load(Locale locale) {
    return SynchronousFuture<AppStrings>(
      locale.languageCode == 'ar' ? const AppStringsAr() : const AppStringsEn(),
    );
  }

  @override
  bool shouldReload(_AppStringsDelegate old) => false;
}
