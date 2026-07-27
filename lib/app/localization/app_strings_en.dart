import 'app_strings.dart';

/// English strings — the default locale, phrased as natural neobank copy.
class AppStringsEn extends AppStrings {
  const AppStringsEn();

  // Common
  @override
  String get commonContinue => 'Continue';
  @override
  String get commonDone => 'Done';
  @override
  String get commonClose => 'Close';
  @override
  String get commonCancel => 'Cancel';
  @override
  String get commonSave => 'Save';
  @override
  String get commonAmount => 'Amount';
  @override
  String get commonStatus => 'Status';
  @override
  String get commonFree => 'Free';
  @override
  String get commonFee => 'Fee';
  @override
  String get commonPending => 'Pending';
  @override
  String get commonRevoke => 'Revoke';
  @override
  String get commonToday => 'Today';
  @override
  String get commonYesterday => 'Yesterday';
  @override
  String get commonAll => 'All';
  @override
  String get commonOther => 'Other';

  // App / brand
  @override
  String get appTagline => 'BANKING, SIMPLIFIED';

  // Onboarding
  @override
  String get onboardingSkip => 'Skip';
  @override
  String get onboardingGetStarted => 'Get started';
  @override
  String get onboardingSlide1Eyebrow => 'REAL-TIME LEDGER';
  @override
  String get onboardingSlide1Title => 'Track every dollar\nin real time.';
  @override
  String get onboardingSlide1Body =>
      'Every purchase, subscription and payday lands in your feed the '
      'instant it happens — no waiting for a statement to catch up.';
  @override
  String get onboardingSlide2Eyebrow => 'INSTANT TRANSFERS';
  @override
  String get onboardingSlide2Title => 'Send money\ninstantly, free.';
  @override
  String get onboardingSlide2Body =>
      'Pay back a friend or move money between accounts in seconds — '
      'no fees, no waiting for business days.';
  @override
  String get onboardingSlide3Eyebrow => 'YOUR CARDS';
  @override
  String get onboardingSlide3Title => 'Cards built\naround you.';
  @override
  String get onboardingSlide3Body =>
      'Freeze a card the moment it goes missing, spin up a virtual card '
      'for online checkout, and see every swipe as it happens.';

  // Auth
  @override
  String get authWelcomeBack => 'WELCOME BACK';
  @override
  String get authSignInTitle => 'Sign in to your\nNimbus account.';
  @override
  String get authEmailLabel => 'Email';
  @override
  String get authEmailRequired => 'Email is required';
  @override
  String get authEmailInvalid => 'Enter a valid email';
  @override
  String get authPasswordLabel => 'Password';
  @override
  String get authPasswordRequired => 'Password is required';
  @override
  String authPasswordMinLength(int count) => 'At least $count characters';
  @override
  String get authRememberMe => 'Remember me';
  @override
  String get authForgotPassword => 'Forgot password?';
  @override
  String get authSignIn => 'Sign in';
  @override
  String get authOrContinueWith => 'or continue with';
  @override
  String authSocialContinuing(String provider) => 'Continuing with $provider…';
  @override
  String get authNewToNimbus => 'New to Nimbus? ';
  @override
  String get authCreateAccount => 'Create account';
  @override
  String authResetLinkSent(String email) =>
      'We’ve sent a reset link to $email. Check your inbox.';
  @override
  String get authResetLinkPrompt =>
      'Enter the email tied to your Nimbus account and we’ll send a reset link.';
  @override
  String get authSendResetLink => 'Send reset link';
  @override
  String get authAcceptTermsError => 'Please accept the terms to continue.';
  @override
  String get authJoinNimbus => 'JOIN NIMBUS';
  @override
  String get authCreateAccountTitle => 'Create your\nNimbus account.';
  @override
  String get authFullNameLabel => 'Full name';
  @override
  String get authFullNameRequired => 'Name is required';
  @override
  String get authAgreeToTermsPrefix => 'I agree to Nimbus’s ';
  @override
  String get authTermsOfService => 'Terms of Service';
  @override
  String get authAgreeToTermsAnd => ' and ';
  @override
  String get authPrivacyPolicy => 'Privacy Policy';
  @override
  String get authAgreeToTermsSuffix => '.';
  @override
  String get authOrSignUpWith => 'or sign up with';
  @override
  String get authAlreadyMember => 'Already a member? ';

  // Cards
  @override
  String get cardsWallet => 'WALLET';
  @override
  String get cardsYourCards => 'Your cards';
  @override
  String cardsLinked(int count) => '$count cards linked to your accounts.';
  @override
  String get cardsAddNewCard => 'Add a new card';
  @override
  String get cardsCardType => 'CARD TYPE';
  @override
  String get cardTypeDebit => 'Debit';
  @override
  String get cardTypeCredit => 'Credit';
  @override
  String get cardTypeVirtual => 'Virtual';
  @override
  String get cardTypeDebitDescription => 'Spend straight from a linked account.';
  @override
  String get cardTypeCreditDescription => 'Build credit with a revolving line.';
  @override
  String get cardTypeVirtualDescription => 'A number for online purchases only.';
  @override
  String get cardsDesign => 'DESIGN';
  @override
  String get cardsCreateCard => 'Create card';
  @override
  String get cardsUnfreezeCard => 'Unfreeze card';
  @override
  String get cardsFreezeCard => 'Freeze card';
  @override
  String get cardsHideNumber => 'Hide number';
  @override
  String get cardsRevealNumber => 'Reveal number';
  @override
  String get cardsFrozenNotice =>
      'This card is frozen. New purchases, withdrawals and '
      'payments will be declined until you unfreeze it.';
  @override
  String get cardsManage => 'MANAGE';
  @override
  String get cardsSettings => 'Card settings';
  @override
  String get cardsChangePin => 'Change PIN';
  @override
  String get cardsSpendingLimit => 'Spending limit';
  @override
  String get cardsReportLostStolen => 'Report lost or stolen';
  @override
  String get pinChangeRequestSnack => 'PIN change request sent to your device.';
  @override
  String get cardsSpendingLimitSnack =>
      'Spending limit is currently set to \$5,000/mo.';
  @override
  String get cardsReportLostStolenSnack =>
      'Our support team has been notified and will contact you shortly.';
  @override
  String get cardCardholder => 'CARDHOLDER';
  @override
  String get cardExpires => 'EXPIRES';
  @override
  String get cardFrozenBadge => 'FROZEN';
  @override
  String get cardNetworkVisa => 'Visa';
  @override
  String get cardNetworkMastercard => 'Mastercard';

  // Account types
  @override
  String get accountTypeChecking => 'Checking';
  @override
  String get accountTypeSavings => 'Savings';
  @override
  String get accountTypeJoint => 'Joint';

  // Spend categories
  @override
  String get spendCategoryGroceries => 'Groceries';
  @override
  String get spendCategoryTransport => 'Transport';
  @override
  String get spendCategorySubscriptions => 'Subscriptions';
  @override
  String get spendCategoryDining => 'Dining';
  @override
  String get spendCategoryShopping => 'Shopping';
  @override
  String get spendCategoryEntertainment => 'Entertainment';
  @override
  String get spendCategoryIncome => 'Income';
  @override
  String get spendCategoryTransfers => 'Transfers';

  // Home
  @override
  String get homeGoodMorning => 'Good morning';
  @override
  String get homeGoodAfternoon => 'Good afternoon';
  @override
  String get homeGoodEvening => 'Good evening';
  @override
  String get homeAvailableBalance => 'Available balance';
  @override
  String get homeThisMonthEyebrow => 'THIS MONTH';
  @override
  String get homeSpendingOverview => 'Spending overview';
  @override
  String get homeDetails => 'Details';
  @override
  String get homeLatestActivityEyebrow => 'LATEST ACTIVITY';
  @override
  String get homeRecentTransactions => 'Recent transactions';
  @override
  String get homeSeeAll => 'See all';
  @override
  String get quickActionSend => 'Send';
  @override
  String get quickActionRequest => 'Request';
  @override
  String get quickActionTopUp => 'Top up';
  @override
  String get quickActionMore => 'More';
  @override
  String get moreActionsTitle => 'MORE ACTIONS';
  @override
  String get moreActionsStatements => 'Statements';
  @override
  String get moreActionsCurrencyExchange => 'Currency exchange';
  @override
  String get moreActionsReferFriend => 'Refer a friend';
  @override
  String get helpSupport => 'Help & support';

  // Spend chart
  @override
  String get spendChartNoSpending => 'No spending recorded yet this month.';
  @override
  String get spendChartTotalSpent => 'Total spent';

  // Transaction detail
  @override
  String get transactionCategory => 'Category';
  @override
  String get transactionDate => 'Date';
  @override
  String get transactionAccount => 'Account';
  @override
  String get transactionStatusCompleted => 'Completed';

  // Transactions
  @override
  String get transactionsActivityEyebrow => 'ACTIVITY';
  @override
  String get transactionsTitle => 'Transactions';
  @override
  String get transactionsSearchHint => 'Search transactions…';
  @override
  String get transactionsThisMonth => 'This month';
  @override
  String get transactionsEmptyTitle => 'No transactions found';
  @override
  String get transactionsEmptyBody => 'Try a different search term or category.';

  // Transfer
  @override
  String get transferSendMoney => 'Send money';
  @override
  String get transferChooseRecipient => 'Choose who you’re sending to.';
  @override
  String get errorAmountTooLow => 'Enter an amount greater than \$0.';
  @override
  String transferFromAccount(String name, String masked) => 'from $name · $masked';
  @override
  String get transferSendFrom => 'SEND FROM';
  @override
  String get transferSendTo => 'SEND TO';
  @override
  String get transferNoteOptional => 'NOTE (OPTIONAL)';
  @override
  String get transferNoteHint => 'What’s it for?';

  @override
  String get transferReviewTitle => 'Review transfer';
  @override
  String get transferYoureSending => 'You’re sending';
  @override
  String transferToContact(String name) => 'to $name';
  @override
  String get transferFromLabel => 'From';
  @override
  String get transferToLabel => 'To';
  @override
  String get transferNoteLabel => 'Note';
  @override
  String get transferFeeLabel => 'Transfer fee';
  @override
  String get transferNoNoteAdded => 'No note added';
  @override
  String get transferTotalLabel => 'Total';
  @override
  String transferInstantNote(String firstName) =>
      'Instant — arrives in $firstName’s account immediately.';
  @override
  String get transferConfirmSend => 'Confirm & Send';

  @override
  String get transferMoneySent => 'Money sent.';
  @override
  String transferSentBody(String amount, String name) =>
      '$amount is on its way to $name. They’ll see it in their account right away.';

  // Request
  @override
  String get requestMoney => 'Request money';
  @override
  String get requestNotifyHint => 'you’ll be notified once it’s paid';
  @override
  String get requestChooseContact => 'Choose who you’re requesting from.';
  @override
  String get requestFromEyebrow => 'REQUEST FROM';
  @override
  String get requestButton => 'Request';

  @override
  String get requestSentTitle => 'Request sent.';
  @override
  String requestSentBody(String amount, String name) =>
      '$amount requested from $name. We’ll notify you when they pay.';

  // Top up
  @override
  String get topupAddMoney => 'Add money';
  @override
  String get topupChooseAccount => 'Choose which account to add money to.';
  @override
  String topupIntoAccount(String name, String masked) => 'into $name · $masked';
  @override
  String get topupFromEyebrow => 'FROM';
  @override
  String get topupToEyebrow => 'TO';
  @override
  String get topupAddFunds => 'Add funds';

  @override
  String get topupMoneyAdded => 'Money added.';
  @override
  String topupAddedBody(String amount, String source, String account) =>
      '$amount from $source is now available in your $account account.';
  @override
  String get topupAdded => 'Added';
  @override
  String get topupNewBalance => 'New balance';

  // Statements
  @override
  String get statementsEyebrow => 'ACCOUNT ACTIVITY';
  @override
  String get statementsTitle => 'Statements';
  @override
  String get statementsSubtitle => 'Monthly summaries of what you spent and earned.';
  @override
  String get statementsLast6Months => 'LAST 6 MONTHS';
  @override
  String statementsTransactionsCount(int count) => '$count transactions';
  @override
  String statementsSpentEarned(String spent, String income) =>
      'Spent $spent · Earned $income';
  @override
  String get statementsNoSpending => 'No spending recorded this month.';

  // Exchange
  @override
  String get exchangeEyebrow => 'CONVERT';
  @override
  String get exchangeTitle => 'Currency exchange';
  @override
  String get exchangeSubtitle => 'Live-style mock rates, updated as you type.';
  @override
  String get exchangeAllRates => 'ALL RATES · PER 1 USD';

  // Refer
  @override
  String get referEyebrow => 'INVITE FRIENDS';
  @override
  String get referTitle => 'Refer a friend';
  @override
  String get referSubtitle => 'Give \$20, get \$20 — invite friends to Nimbus.';
  @override
  String get referGiveGet => 'Give \$20, get \$20';
  @override
  String get referGiveGetBody =>
      'When a friend joins Nimbus with your code and makes their '
      'first transfer, you both get \$20.';
  @override
  String get referYourCode => 'YOUR REFERRAL CODE';
  @override
  String get referCopyCode => 'Copy code';
  @override
  String get referCopiedSnack => 'Copied to clipboard';
  @override
  String get referHowItWorks => 'HOW IT WORKS';
  @override
  String get referStep1Title => 'Share your code';
  @override
  String get referStep1Body =>
      'Send your referral code to a friend, family member, or anyone.';
  @override
  String get referStep2Title => 'They sign up';
  @override
  String get referStep2Body =>
      'Your friend downloads Nimbus and enters your code when they join.';
  @override
  String get referStep3Title => 'You both get paid';
  @override
  String get referStep3Body =>
      'After their first transfer, \$20 lands in each of your accounts.';

  // Connect bank
  @override
  String get connectBankLinkAccount => 'LINK AN ACCOUNT';
  @override
  String get connectBankTitle => 'Link a new bank';
  @override
  String get connectBankSubtitle => 'Choose an outside bank to connect to Nimbus.';
  @override
  String connectBankConnecting(String bankName) => 'Connecting to $bankName…';
  @override
  String get connectBankTakesMoment => 'This usually takes just a moment.';
  @override
  String connectBankConnected(String bankName) => 'Connected to $bankName.';
  @override
  String get connectBankSeeUnderExternal =>
      'You’ll now see this account under external banks.';

  // Help
  @override
  String get helpEyebrow => 'WE’RE HERE TO HELP';
  @override
  String get helpSubtitle => 'Answers to common questions, or reach a real person.';
  @override
  String get helpFrequentlyAsked => 'FREQUENTLY ASKED';
  @override
  String get helpFaq1Q => 'How long do transfers take?';
  @override
  String get helpFaq1A =>
      'Transfers between Nimbus accounts and to other Nimbus members are '
      'instant. Transfers to outside banks usually arrive within one '
      'business day.';
  @override
  String get helpFaq2Q => 'How do I freeze a lost card?';
  @override
  String get helpFaq2A =>
      'Open Cards, tap the card, then tap Freeze card. Purchases and '
      'withdrawals are blocked immediately — unfreeze it any time if you '
      'find it again.';
  @override
  String get helpFaq3Q => 'Is my money insured?';
  @override
  String get helpFaq3A =>
      'Yes — balances held with our partner bank are FDIC-insured up to the '
      'standard coverage limit, the same as a traditional bank account.';
  @override
  String get helpFaq4Q => 'How do I dispute a transaction?';
  @override
  String get helpFaq4A =>
      'Open the transaction from your history and tap Report an issue, or '
      'contact support below. We’ll investigate and follow up within 2 '
      'business days.';
  @override
  String get helpContactSupport => 'CONTACT SUPPORT';
  @override
  String get helpChatWithUs => 'Chat with us';
  @override
  String get helpChatSublabel => 'Typically replies in a few minutes';
  @override
  String get helpCallSupport => 'Call support';
  @override
  String get helpCallSublabel => '1-800-555-0199 · 24/7';
  @override
  String get helpEmailUs => 'Email us';
  @override
  String get helpConnectingSnack => 'Connecting you to a support specialist…';
  @override
  String get helpCallingSnack => 'Calling 1-800-555-0199…';
  @override
  String get helpEmailSnack => 'Opening your email client…';

  // Linked accounts
  @override
  String get linkedAccountsEyebrow => 'MONEY, ALL IN ONE PLACE';
  @override
  String get linkedAccountsTitle => 'Linked accounts';
  @override
  String get linkedAccountsSubtitle =>
      'Your Nimbus accounts, plus any outside banks you connect.';
  @override
  String get linkNewBank => 'Link a new bank';
  @override
  String get linkedAccountsNimbusAccounts => 'NIMBUS ACCOUNTS';
  @override
  String get linkedAccountsExternalBanks => 'EXTERNAL BANKS';
  @override
  String get linkedAccountsConnectedBadge => 'CONNECTED';

  // Notifications
  @override
  String get notificationsEyebrow => 'INBOX';
  @override
  String get notificationsTitle => 'Notifications';
  @override
  String get notificationsAllCaughtUp => 'You’re all caught up.';
  @override
  String notificationsUnreadCount(int count) =>
      '$count unread message${count == 1 ? '' : 's'}.';
  @override
  String get notificationsMarkAllRead => 'Mark all read';
  @override
  String get notificationsEarlier => 'Earlier';
  @override
  String get notificationsEmptyTitle => 'Nothing in the inbox';
  @override
  String get notificationsEmptyBody =>
      'We’ll let you know when something needs your attention.';
  @override
  String get notifPayrollTitle => 'Payroll deposit received';
  @override
  String get notifPayrollBody =>
      '\$5,200.00 from Acme Corp Payroll landed in Everyday.';
  @override
  String get notifSignInTitle => 'New sign-in detected';
  @override
  String get notifSignInBody =>
      'Your account was accessed from a new device in San Francisco.';
  @override
  String get notifSavingsRateTitle => 'Savings rate increased to 4.2%';
  @override
  String get notifSavingsRateBody => 'Your Savings account now earns more, automatically.';
  @override
  String get notifCardDeclinedTitle => 'Card payment declined';
  @override
  String get notifCardDeclinedBody =>
      'Nimbus Violet Credit ••2290 was declined at Amazon — limit reached.';
  @override
  String get notifStatementReadyTitle => 'Statement ready';
  @override
  String get notifStatementReadyBody =>
      'Your July statement for Everyday is ready to view.';
  @override
  String get notifReferTitle => 'Refer a friend, get \$25';
  @override
  String get notifReferBody =>
      'Invite a friend to Nimbus — you both get \$25 when they sign up.';
  @override
  String get notifTimeAgo2h => '2h ago';
  @override
  String get notifTimeAgo5h => '5h ago';
  @override
  String get notifTimeAgo7h => '7h ago';
  @override
  String get notifTimeAgo3d => '3 days ago';
  @override
  String get notifTimeAgo1w => '1 week ago';

  // Personal info
  @override
  String get personalInfoEyebrow => 'ACCOUNT';
  @override
  String get personalInfoTitle => 'Personal info';
  @override
  String get personalInfoSubtitle =>
      'Keep your details up to date for statements and support.';
  @override
  String get fieldPhone => 'Phone';
  @override
  String get fieldAddress => 'Address';
  @override
  String get fieldDateOfBirth => 'Date of birth';
  @override
  String editFieldTitle(String fieldLabel) => 'Edit ${fieldLabel.toLowerCase()}';

  // Security
  @override
  String get securityEyebrow => 'PROTECT YOUR ACCOUNT';
  @override
  String get securityTitle => 'Security & PIN';
  @override
  String get securitySubtitle => 'Manage how you sign in and keep your money safe.';
  @override
  String get securityAppPin => 'App PIN';
  @override
  String get securityLastChanged => 'Last changed 4 months ago';
  @override
  String get securityFaceId => 'Face ID & Touch ID';
  @override
  String get securityFaceIdSub => 'Unlock Nimbus without your PIN';
  @override
  String get securityTwoFactor => 'Two-factor authentication';
  @override
  String get securityTwoFactorSub => 'Require a code for new devices';
  @override
  String get securitySignInAlerts => 'Sign-in alerts';
  @override
  String get securitySignInAlertsSub => 'Get notified of new device sign-ins';
  @override
  String get securityActiveSessions => 'ACTIVE SESSIONS';
  @override
  String get securityThisDeviceActive => 'This device · Active now';
  @override
  String securityLastActive(String time) => 'Last active $time';
  @override
  String get securityTwoDaysAgo => '2 days ago';
  @override
  String securitySessionRevoked(String device) =>
      'Session on $device has been signed out.';

  // Profile
  @override
  String get profileVerifiedMember => 'VERIFIED MEMBER';
  @override
  String get profileAccountsStat => 'Accounts';
  @override
  String get profileSinceStat => 'Since';
  @override
  String get profileMemberSince =>
      'Member since March 2024. Thanks for banking with Nimbus.';
  @override
  String get profileAppearance => 'Appearance';
  @override
  String get profileTheme => 'Theme';
  @override
  String get profileLanguageEyebrow => 'PREFERENCES';
  @override
  String get profileLanguage => 'Language';
  @override
  String get profileAccountEyebrow => 'Account';
  @override
  String get profileSettingsHeadline => 'Settings';
  @override
  String get menuLogOut => 'Log out';
  @override
  String get logOutConfirmTitle => 'Log out?';
  @override
  String get logOutConfirmBody => 'You can sign back in at any time.';

  // Nav
  @override
  String get navHome => 'Home';
  @override
  String get navCards => 'Cards';
  @override
  String get navActivity => 'Activity';
  @override
  String get navProfile => 'Profile';

  // Language selector
  @override
  String get languageEnglish => 'English';
  @override
  String get languageArabic => 'العربية';

  // Theme mode selector
  @override
  String get themeLight => 'Light';
  @override
  String get themeSystem => 'System';
  @override
  String get themeDark => 'Dark';
}
