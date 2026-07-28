import 'app_strings.dart';

/// Dari strings — natural, formal Afghan Dari banking copy (not Iranian
/// Farsi, and not a literal/machine translation of the English). Word
/// choices favor Afghan-preferred usage where Dari and Iranian Farsi
/// diverge — e.g. "معلومات" (not "اطلاعات") for information, "دالر" (not
/// "دلار") for dollar, "معاش" (not "حقوق") for salary/payroll, "ترانسپورت"
/// (not "حمل و نقل") for transport, and Afghan-style transliterated
/// Gregorian month names ("مارچ", "جولای" — not the Iranian Solar Hijri
/// month names or Iranian Gregorian spellings). Numbers/currency stay in
/// Western Arabic numerals and `$` amounts, with the `$` placed after the
/// digits (e.g. "20$") to match the Arabic file's convention, for
/// consistency across the app's three locales. Brand name ("Nimbus"),
/// personal names, bank/merchant names, tech feature names (Face ID,
/// Touch ID), card network names (Visa, Mastercard) and email addresses
/// are intentionally left untranslated — same as the English and Arabic
/// copy.
class AppStringsDari extends AppStrings {
  const AppStringsDari();

  // Common
  @override
  String get commonContinue => 'ادامه';
  @override
  String get commonDone => 'تمام';
  @override
  String get commonClose => 'بستن';
  @override
  String get commonCancel => 'لغو';
  @override
  String get commonSave => 'ذخیره';
  @override
  String get commonAmount => 'مبلغ';
  @override
  String get commonStatus => 'وضعیت';
  @override
  String get commonFree => 'رایگان';
  @override
  String get commonFee => 'کارمزد';
  @override
  String get commonPending => 'در انتظار';
  @override
  String get commonRevoke => 'لغو نشست';
  @override
  String get commonToday => 'امروز';
  @override
  String get commonYesterday => 'دیروز';
  @override
  String get commonAll => 'همه';
  @override
  String get commonOther => 'دیگر';

  // App / brand
  @override
  String get appTagline => 'بانکداری، به‌سادگی';

  // Onboarding
  @override
  String get onboardingSkip => 'رد کردن';
  @override
  String get onboardingGetStarted => 'شروع کنید';
  @override
  String get onboardingSlide1Eyebrow => 'دفتر مالی آنی';
  @override
  String get onboardingSlide1Title => 'هر دالر خود را\nدر لحظه دنبال کنید.';
  @override
  String get onboardingSlide1Body =>
      'هر خرید، اشتراک و معاش به محض وقوع در فهرست شما نمایان '
      'می‌شود — بدون نیاز به انتظار برای صدور سند حساب.';
  @override
  String get onboardingSlide2Eyebrow => 'حواله‌های آنی';
  @override
  String get onboardingSlide2Title => 'پول را به صورت آنی\nو رایگان بفرستید.';
  @override
  String get onboardingSlide2Body =>
      'پول یک دوست را در چند ثانیه پس بدهید یا میان حساب‌های خود '
      'انتقال دهید — بدون کارمزد و بدون انتظار برای روزهای کاری.';
  @override
  String get onboardingSlide3Eyebrow => 'کارت‌های شما';
  @override
  String get onboardingSlide3Title =>
      'کارت‌هایی که\nویژه شما طراحی شده‌اند.';
  @override
  String get onboardingSlide3Body =>
      'به محض گم شدن کارت خود، آن را مسدود کنید، یک کارت مجازی برای '
      'خریدهای آنلاین بسازید، و هر تراکنش را همان لحظه مشاهده کنید.';

  // Auth
  @override
  String get authWelcomeBack => 'دوباره خوش آمدید';
  @override
  String get authSignInTitle => 'به حساب Nimbus خود\nوارد شوید.';
  @override
  String get authEmailLabel => 'ایمیل';
  @override
  String get authEmailRequired => 'ایمیل الزامی است';
  @override
  String get authEmailInvalid => 'یک ایمیل معتبر وارد کنید';
  @override
  String get authPasswordLabel => 'رمز عبور';
  @override
  String get authPasswordRequired => 'رمز عبور الزامی است';
  @override
  String authPasswordMinLength(int count) => 'حداقل $count حرف';
  @override
  String get authRememberMe => 'مرا به یاد بسپار';
  @override
  String get authForgotPassword => 'رمز عبور خود را فراموش کرده‌اید؟';
  @override
  String get authSignIn => 'ورود';
  @override
  String get authOrContinueWith => 'یا ادامه دهید با';
  @override
  String authSocialContinuing(String provider) => 'در حال ادامه با $provider…';
  @override
  String get authNewToNimbus => 'به Nimbus تازه وارد هستید؟ ';
  @override
  String get authCreateAccount => 'ایجاد حساب';
  @override
  String authResetLinkSent(String email) =>
      'لینک بازیابی را به $email ارسال کردیم. صندوق ایمیل خود را بررسی کنید.';
  @override
  String get authResetLinkPrompt =>
      'ایمیلی را که با حساب Nimbus شما مرتبط است وارد کنید تا لینک '
      'بازیابی را برای‌تان ارسال کنیم.';
  @override
  String get authSendResetLink => 'ارسال لینک بازیابی';
  @override
  String get authAcceptTermsError => 'لطفاً برای ادامه، شرایط را بپذیرید.';
  @override
  String get authJoinNimbus => 'به Nimbus بپیوندید';
  @override
  String get authCreateAccountTitle => 'حساب Nimbus خود را\nایجاد کنید.';
  @override
  String get authFullNameLabel => 'نام کامل';
  @override
  String get authFullNameRequired => 'نام الزامی است';
  @override
  String get authAgreeToTermsPrefix => 'با ';
  @override
  String get authTermsOfService => 'شرایط خدمات';
  @override
  String get authAgreeToTermsAnd => ' و ';
  @override
  String get authPrivacyPolicy => 'سیاست حفظ محرمیت';
  @override
  String get authAgreeToTermsSuffix => ' Nimbus موافقم.';
  @override
  String get authOrSignUpWith => 'یا ثبت‌نام کنید با';
  @override
  String get authAlreadyMember => 'قبلاً عضو هستید؟ ';

  // Cards
  @override
  String get cardsWallet => 'کیف پول';
  @override
  String get cardsYourCards => 'کارت‌های شما';
  @override
  String cardsLinked(int count) => _dariCount(
        count,
        zero: 'هیچ کارتی به حساب‌های شما وصل نیست.',
        other: '{n} کارت به حساب‌های شما وصل است.',
      );
  @override
  String get cardsAddNewCard => 'افزودن کارت جدید';
  @override
  String get cardsCardType => 'نوع کارت';
  @override
  String get cardTypeDebit => 'برداشت مستقیم';
  @override
  String get cardTypeCredit => 'اعتباری';
  @override
  String get cardTypeVirtual => 'مجازی';
  @override
  String get cardTypeDebitDescription =>
      'مستقیماً از یک حساب متصل مصرف کنید.';
  @override
  String get cardTypeCreditDescription =>
      'با یک خط اعتباری چرخشی، اعتبار خود را بسازید.';
  @override
  String get cardTypeVirtualDescription => 'شماره‌ای مخصوص خریدهای آنلاین.';
  @override
  String get cardsDesign => 'طرح';
  @override
  String get cardsCreateCard => 'ایجاد کارت';
  @override
  String get cardsUnfreezeCard => 'رفع مسدودیت کارت';
  @override
  String get cardsFreezeCard => 'مسدود کردن کارت';
  @override
  String get cardsHideNumber => 'پنهان کردن شماره';
  @override
  String get cardsRevealNumber => 'نمایش شماره';
  @override
  String get cardsFrozenNotice =>
      'این کارت مسدود است. خریدها، برداشت‌ها و پرداخت‌های جدید تا '
      'زمانی که مسدودیت آن را رفع نکنید، رد خواهند شد.';
  @override
  String get cardsManage => 'مدیریت';
  @override
  String get cardsSettings => 'تنظیمات کارت';
  @override
  String get cardsChangePin => 'تغییر پین';
  @override
  String get cardsSpendingLimit => 'حد مصرف';
  @override
  String get cardsReportLostStolen => 'گزارش گم‌شدن یا سرقت';
  @override
  String get pinChangeRequestSnack => 'درخواست تغییر پین به دستگاه شما ارسال شد.';
  @override
  String get cardsSpendingLimitSnack =>
      'حد مصرف در حال حاضر روی 5,000\$ در ماه تنظیم شده است.';
  @override
  String get cardsReportLostStolenSnack =>
      'تیم پشتیبانی ما آگاه شد و به‌زودی با شما تماس خواهد گرفت.';
  @override
  String get cardCardholder => 'دارنده کارت';
  @override
  String get cardExpires => 'تاریخ انقضا';
  @override
  String get cardFrozenBadge => 'مسدود';
  @override
  String get cardNetworkVisa => 'Visa';
  @override
  String get cardNetworkMastercard => 'Mastercard';

  // Account types
  @override
  String get accountTypeChecking => 'جاری';
  @override
  String get accountTypeSavings => 'پس‌انداز';
  @override
  String get accountTypeJoint => 'مشترک';

  // Spend categories
  @override
  String get spendCategoryGroceries => 'خواربار';
  @override
  String get spendCategoryTransport => 'ترانسپورت';
  @override
  String get spendCategorySubscriptions => 'اشتراک‌ها';
  @override
  String get spendCategoryDining => 'رستورانت';
  @override
  String get spendCategoryShopping => 'خرید';
  @override
  String get spendCategoryEntertainment => 'تفریح';
  @override
  String get spendCategoryIncome => 'عاید';
  @override
  String get spendCategoryTransfers => 'حواله‌ها';

  // Home
  @override
  String get homeGoodMorning => 'صبح بخیر';
  @override
  String get homeGoodAfternoon => 'روز خوش';
  @override
  String get homeGoodEvening => 'شام بخیر';
  @override
  String get homeAvailableBalance => 'موجودی قابل دسترس';
  @override
  String get homeThisMonthEyebrow => 'این ماه';
  @override
  String get homeSpendingOverview => 'نمای کلی مصارف';
  @override
  String get homeDetails => 'جزئیات';
  @override
  String get homeLatestActivityEyebrow => 'آخرین فعالیت';
  @override
  String get homeRecentTransactions => 'تراکنش‌های اخیر';
  @override
  String get homeSeeAll => 'مشاهده همه';
  @override
  String get quickActionSend => 'ارسال';
  @override
  String get quickActionRequest => 'درخواست';
  @override
  String get quickActionTopUp => 'شارژ';
  @override
  String get quickActionMore => 'بیشتر';
  @override
  String get moreActionsTitle => 'اقدامات بیشتر';
  @override
  String get moreActionsStatements => 'صورت‌حساب‌ها';
  @override
  String get moreActionsCurrencyExchange => 'تبدیل ارز';
  @override
  String get moreActionsReferFriend => 'معرفی یک دوست';
  @override
  String get helpSupport => 'کمک و پشتیبانی';

  // Spend chart
  @override
  String get spendChartNoSpending => 'تا کنون هیچ مصرفی در این ماه ثبت نشده است.';
  @override
  String get spendChartTotalSpent => 'مجموع مصرف';

  // Transaction detail
  @override
  String get transactionCategory => 'دسته‌بندی';
  @override
  String get transactionDate => 'تاریخ';
  @override
  String get transactionAccount => 'حساب';
  @override
  String get transactionStatusCompleted => 'تکمیل شده';

  // Transactions
  @override
  String get transactionsActivityEyebrow => 'فعالیت';
  @override
  String get transactionsTitle => 'تراکنش‌ها';
  @override
  String get transactionsSearchHint => 'جستجوی تراکنش‌ها…';
  @override
  String get transactionsThisMonth => 'این ماه';
  @override
  String get transactionsEmptyTitle => 'هیچ تراکنشی یافت نشد';
  @override
  String get transactionsEmptyBody =>
      'یک عبارت جستجو یا دسته‌بندی دیگر را امتحان کنید.';

  // Transfer
  @override
  String get transferSendMoney => 'ارسال پول';
  @override
  String get transferChooseRecipient => 'گیرنده مورد نظر خود را انتخاب کنید.';
  @override
  String get errorAmountTooLow => 'مبلغی بیشتر از 0\$ وارد کنید.';
  @override
  String transferFromAccount(String name, String masked) => 'از $name · $masked';
  @override
  String get transferSendFrom => 'ارسال از';
  @override
  String get transferSendTo => 'ارسال به';
  @override
  String get transferNoteOptional => 'یادداشت (اختیاری)';
  @override
  String get transferNoteHint => 'بابت چیست؟';

  @override
  String get transferReviewTitle => 'بررسی انتقال';
  @override
  String get transferYoureSending => 'شما در حال ارسال هستید';
  @override
  String transferToContact(String name) => 'به $name';
  @override
  String get transferFromLabel => 'از';
  @override
  String get transferToLabel => 'به';
  @override
  String get transferNoteLabel => 'یادداشت';
  @override
  String get transferFeeLabel => 'کارمزد انتقال';
  @override
  String get transferNoNoteAdded => 'یادداشتی افزوده نشده';
  @override
  String get transferTotalLabel => 'مجموع';
  @override
  String transferInstantNote(String firstName) =>
      'آنی — بلادرنگ به حساب $firstName می‌رسد.';
  @override
  String get transferConfirmSend => 'تأیید و ارسال';

  @override
  String get transferMoneySent => 'پول ارسال شد.';
  @override
  String transferSentBody(String amount, String name) =>
      '$amount در راه $name است. آن‌ها بلافاصله آن را در حساب خود خواهند دید.';

  // Request
  @override
  String get requestMoney => 'درخواست پول';
  @override
  String get requestNotifyHint => 'به محض پرداخت آن، به شما اطلاع داده می‌شود';
  @override
  String get requestChooseContact =>
      'شخصی را که از او درخواست می‌کنید، انتخاب کنید.';
  @override
  String get requestFromEyebrow => 'درخواست از';
  @override
  String get requestButton => 'درخواست';

  @override
  String get requestSentTitle => 'درخواست ارسال شد.';
  @override
  String requestSentBody(String amount, String name) =>
      '$amount از $name درخواست شد. زمانی که پرداخت کنند، به شما اطلاع می‌دهیم.';

  // Top up
  @override
  String get topupAddMoney => 'افزودن پول';
  @override
  String get topupChooseAccount =>
      'حسابی را که می‌خواهید پول به آن افزوده شود، انتخاب کنید.';
  @override
  String topupIntoAccount(String name, String masked) => 'به $name · $masked';
  @override
  String get topupFromEyebrow => 'از';
  @override
  String get topupToEyebrow => 'به';
  @override
  String get topupAddFunds => 'افزودن وجه';

  @override
  String get topupMoneyAdded => 'پول افزوده شد.';
  @override
  String topupAddedBody(String amount, String source, String account) =>
      '$amount از $source اکنون در حساب $account شما موجود است.';
  @override
  String get topupAdded => 'افزوده شد';
  @override
  String get topupNewBalance => 'موجودی جدید';

  // Statements
  @override
  String get statementsEyebrow => 'فعالیت حساب';
  @override
  String get statementsTitle => 'صورت‌حساب‌ها';
  @override
  String get statementsSubtitle =>
      'خلاصه‌های ماهانه از آنچه مصرف کرده‌اید و به‌دست آورده‌اید.';
  @override
  String get statementsLast6Months => '6 ماه اخیر';
  @override
  String statementsTransactionsCount(int count) => _dariCount(
        count,
        zero: 'هیچ تراکنشی نیست',
        other: '{n} تراکنش',
      );
  @override
  String statementsSpentEarned(String spent, String income) =>
      'مصرف: $spent · عاید: $income';
  @override
  String get statementsNoSpending => 'این ماه هیچ مصرفی ثبت نشده است.';

  // Exchange
  @override
  String get exchangeEyebrow => 'تبدیل';
  @override
  String get exchangeTitle => 'تبدیل ارز';
  @override
  String get exchangeSubtitle =>
      'نرخ‌های نمایشی به‌سبک آنی، که همزمان با تایپ شما به‌روز می‌شوند.';
  @override
  String get exchangeAllRates => 'همه نرخ‌ها · به ازای 1 دالر امریکایی';

  // Refer
  @override
  String get referEyebrow => 'دوستان را دعوت کنید';
  @override
  String get referTitle => 'معرفی یک دوست';
  @override
  String get referSubtitle =>
      '20\$ بدهید، 20\$ بگیرید — دوستان خود را به Nimbus دعوت کنید.';
  @override
  String get referGiveGet => '20\$ بدهید، 20\$ بگیرید';
  @override
  String get referGiveGetBody =>
      'وقتی یک دوست با کد شما به Nimbus می‌پیوندد و اولین انتقال خود را '
      'انجام می‌دهد، هر دوی شما 20\$ دریافت می‌کنید.';
  @override
  String get referYourCode => 'کد معرفی شما';
  @override
  String get referCopyCode => 'کپی کردن کد';
  @override
  String get referCopiedSnack => 'به کلیپ‌بورد کپی شد';
  @override
  String get referHowItWorks => 'چگونگی کارکرد';
  @override
  String get referStep1Title => 'کد خود را به اشتراک بگذارید';
  @override
  String get referStep1Body =>
      'کد معرفی خود را برای یک دوست، عضو خانواده یا هر کس دیگری بفرستید.';
  @override
  String get referStep2Title => 'آن‌ها ثبت‌نام می‌کنند';
  @override
  String get referStep2Body =>
      'دوست شما Nimbus را دانلود می‌کند و هنگام پیوستن، کد شما را وارد می‌کند.';
  @override
  String get referStep3Title => 'هر دوی شما پول دریافت می‌کنید';
  @override
  String get referStep3Body =>
      'پس از اولین انتقال آن‌ها، 20\$ به حساب هر یک از شما واریز می‌شود.';

  // Connect bank
  @override
  String get connectBankLinkAccount => 'وصل کردن یک حساب';
  @override
  String get connectBankTitle => 'وصل کردن یک بانک جدید';
  @override
  String get connectBankSubtitle =>
      'یک بانک بیرونی را برای وصل شدن به Nimbus انتخاب کنید.';
  @override
  String connectBankConnecting(String bankName) => 'در حال وصل شدن به $bankName…';
  @override
  String get connectBankTakesMoment => 'این کار معمولاً فقط یک لحظه طول می‌کشد.';
  @override
  String connectBankConnected(String bankName) => 'به $bankName وصل شد.';
  @override
  String get connectBankSeeUnderExternal =>
      'اکنون این حساب را زیر بخش بانک‌های بیرونی خواهید دید.';

  // Help
  @override
  String get helpEyebrow => 'ما اینجا هستیم تا کمک کنیم';
  @override
  String get helpSubtitle => 'پاسخ به پرسش‌های متداول، یا تماس با یک نماینده واقعی.';
  @override
  String get helpFrequentlyAsked => 'پرسش‌های متداول';
  @override
  String get helpFaq1Q => 'انتقال پول چقدر وقت می‌گیرد؟';
  @override
  String get helpFaq1A =>
      'انتقال‌ها میان حساب‌های Nimbus و به سایر اعضای Nimbus آنی است. '
      'انتقال‌ها به بانک‌های بیرونی معمولاً ظرف یک روز کاری می‌رسد.';
  @override
  String get helpFaq2Q => 'چگونه یک کارت گم‌شده را مسدود کنم؟';
  @override
  String get helpFaq2A =>
      'بخش کارت‌ها را باز کنید، روی کارت لمس کنید، سپس روی «مسدود کردن '
      'کارت» لمس کنید. خریدها و برداشت‌ها بلافاصله مسدود می‌شوند — هر '
      'زمان که کارت را دوباره پیدا کردید، می‌توانید مسدودیت آن را رفع کنید.';
  @override
  String get helpFaq3Q => 'آیا پول من بیمه است؟';
  @override
  String get helpFaq3A =>
      'بله — موجودی‌های نگهداری‌شده نزد بانک همکار ما تا حد پوشش استاندارد '
      'توسط FDIC بیمه شده‌اند، درست مانند یک حساب بانکی سنتی.';
  @override
  String get helpFaq4Q => 'چگونه به یک تراکنش اعتراض کنم؟';
  @override
  String get helpFaq4A =>
      'تراکنش را از تاریخچه خود باز کنید و روی «گزارش مشکل» لمس کنید، یا '
      'با پشتیبانی در پایین تماس بگیرید. ما ظرف 2 روز کاری بررسی کرده و '
      'به شما پیگیری خواهیم داد.';
  @override
  String get helpContactSupport => 'تماس با پشتیبانی';
  @override
  String get helpChatWithUs => 'با ما چت کنید';
  @override
  String get helpChatSublabel => 'معمولاً ظرف چند دقیقه پاسخ می‌دهد';
  @override
  String get helpCallSupport => 'زنگ زدن به پشتیبانی';
  @override
  String get helpCallSublabel => '1-800-555-0199 · شبانه‌روزی';
  @override
  String get helpEmailUs => 'برای ما ایمیل بفرستید';
  @override
  String get helpConnectingSnack => 'شما را به یک متخصص پشتیبانی وصل می‌کنیم…';
  @override
  String get helpCallingSnack => 'در حال زنگ زدن به 1-800-555-0199…';
  @override
  String get helpEmailSnack => 'در حال باز کردن برنامه ایمیل شما…';

  // Linked accounts
  @override
  String get linkedAccountsEyebrow => 'همه پول شما، در یک‌جا';
  @override
  String get linkedAccountsTitle => 'حساب‌های وصل‌شده';
  @override
  String get linkedAccountsSubtitle =>
      'حساب‌های Nimbus شما، به‌همراه هر بانک بیرونی‌ای که وصل می‌کنید.';
  @override
  String get linkNewBank => 'وصل کردن یک بانک جدید';
  @override
  String get linkedAccountsNimbusAccounts => 'حساب‌های Nimbus';
  @override
  String get linkedAccountsExternalBanks => 'بانک‌های بیرونی';
  @override
  String get linkedAccountsConnectedBadge => 'وصل شده';

  // Notifications
  @override
  String get notificationsEyebrow => 'صندوق دریافتی';
  @override
  String get notificationsTitle => 'اعلان‌ها';
  @override
  String get notificationsAllCaughtUp => 'همه چیز به‌روز است.';
  @override
  String notificationsUnreadCount(int count) => _dariCount(
        count,
        zero: 'هیچ پیام ناخوانده‌ای ندارید.',
        other: '{n} پیام ناخوانده.',
      );
  @override
  String get notificationsMarkAllRead => 'علامت زدن همه به‌عنوان خوانده‌شده';
  @override
  String get notificationsEarlier => 'پیش‌تر';
  @override
  String get notificationsEmptyTitle => 'صندوق دریافتی خالی است';
  @override
  String get notificationsEmptyBody =>
      'هرگاه چیزی نیاز به توجه شما داشته باشد، به شما اطلاع می‌دهیم.';
  @override
  String get notifPayrollTitle => 'واریز معاش دریافت شد';
  @override
  String get notifPayrollBody =>
      '5,200.00\$ از معاش Acme Corp در حساب Everyday واریز شد.';
  @override
  String get notifSignInTitle => 'ورود جدید شناسایی شد';
  @override
  String get notifSignInBody =>
      'به حساب شما از یک دستگاه جدید در سان‌فرانسیسکو دسترسی پیدا شد.';
  @override
  String get notifSavingsRateTitle => 'نرخ سود پس‌انداز به 4.2% افزایش یافت';
  @override
  String get notifSavingsRateBody =>
      'حساب Savings شما اکنون به‌صورت خودکار سود بیشتری کسب می‌کند.';
  @override
  String get notifCardDeclinedTitle => 'پرداخت با کارت رد شد';
  @override
  String get notifCardDeclinedBody =>
      'کارت Nimbus Violet Credit ••2290 در Amazon رد شد — به حد مجاز رسیده است.';
  @override
  String get notifStatementReadyTitle => 'صورت‌حساب آماده است';
  @override
  String get notifStatementReadyBody =>
      'صورت‌حساب ماه جولای شما برای Everyday آماده مشاهده است.';
  @override
  String get notifReferTitle => 'یک دوست معرفی کنید، 25\$ بگیرید';
  @override
  String get notifReferBody =>
      'یک دوست را به Nimbus دعوت کنید — هر دوی شما هنگام ثبت‌نام آن‌ها '
      '25\$ دریافت می‌کنید.';
  @override
  String get notifTimeAgo2h => '2 ساعت پیش';
  @override
  String get notifTimeAgo5h => '5 ساعت پیش';
  @override
  String get notifTimeAgo7h => '7 ساعت پیش';
  @override
  String get notifTimeAgo3d => '3 روز پیش';
  @override
  String get notifTimeAgo1w => '1 هفته پیش';

  // Personal info
  @override
  String get personalInfoEyebrow => 'حساب';
  @override
  String get personalInfoTitle => 'معلومات شخصی';
  @override
  String get personalInfoSubtitle =>
      'معلومات خود را برای صورت‌حساب‌ها و پشتیبانی به‌روز نگه دارید.';
  @override
  String get fieldPhone => 'تلفن';
  @override
  String get fieldAddress => 'آدرس';
  @override
  String get fieldDateOfBirth => 'تاریخ تولد';
  @override
  String editFieldTitle(String fieldLabel) => 'ویرایش $fieldLabel';

  // Security
  @override
  String get securityEyebrow => 'از حساب خود محافظت کنید';
  @override
  String get securityTitle => 'امنیت و پین';
  @override
  String get securitySubtitle =>
      'نحوه ورود خود را مدیریت کنید و پول خود را ایمن نگه دارید.';
  @override
  String get securityAppPin => 'پین برنامه';
  @override
  String get securityLastChanged => 'آخرین تغییر 4 ماه پیش';
  @override
  String get securityFaceId => 'Face ID و Touch ID';
  @override
  String get securityFaceIdSub => 'Nimbus را بدون پین خود باز کنید';
  @override
  String get securityTwoFactor => 'تایید دو مرحله‌ای';
  @override
  String get securityTwoFactorSub => 'برای دستگاه‌های جدید کد تایید بخواهید';
  @override
  String get securitySignInAlerts => 'هشدارهای ورود';
  @override
  String get securitySignInAlertsSub => 'از ورودهای دستگاه‌های جدید آگاه شوید';
  @override
  String get securityActiveSessions => 'نشست‌های فعال';
  @override
  String get securityThisDeviceActive => 'این دستگاه · اکنون فعال';
  @override
  String securityLastActive(String time) => 'آخرین فعالیت $time';
  @override
  String get securityTwoDaysAgo => '2 روز پیش';
  @override
  String securitySessionRevoked(String device) =>
      'نشست روی $device خارج شده است.';

  // Profile
  @override
  String get profileVerifiedMember => 'عضو تایید شده';
  @override
  String get profileAccountsStat => 'حساب‌ها';
  @override
  String get profileSinceStat => 'از';
  @override
  String get profileMemberSince =>
      'عضو از مارچ 2024. از این‌که بانکداری خود را با Nimbus انجام '
      'می‌دهید، تشکر می‌کنیم.';
  @override
  String get profileAppearance => 'ظاهر';
  @override
  String get profileTheme => 'تم';
  @override
  String get profileLanguageEyebrow => 'ترجیحات';
  @override
  String get profileLanguage => 'زبان';
  @override
  String get profileAccountEyebrow => 'حساب';
  @override
  String get profileSettingsHeadline => 'تنظیمات';
  @override
  String get menuLogOut => 'خروج از حساب';
  @override
  String get logOutConfirmTitle => 'خروج از حساب؟';
  @override
  String get logOutConfirmBody => 'شما می‌توانید در هر زمان دوباره وارد شوید.';

  // Nav
  @override
  String get navHome => 'خانه';
  @override
  String get navCards => 'کارت‌ها';
  @override
  String get navActivity => 'فعالیت';
  @override
  String get navProfile => 'پروفایل';

  // Language selector
  @override
  String get languageEnglish => 'English';
  @override
  String get languageArabic => 'العربية';
  @override
  String get languageDari => 'دری';

  // Theme mode selector
  @override
  String get themeLight => 'روشن';
  @override
  String get themeSystem => 'سیستم';
  @override
  String get themeDark => 'تاریک';
}

/// Simple Dari count helper for count-based UI copy. Unlike Arabic, Dari
/// nouns don't inflect for number after a count (no zero/one/two/few/many
/// noun-form agreement) — "3 کارت" and "10 کارت" both keep the noun
/// singular, so only a zero/non-zero split is needed. `{n}` in [other] is
/// replaced with the count.
String _dariCount(
  int n, {
  required String zero,
  required String other,
}) {
  if (n == 0) return zero;
  return other.replaceAll('{n}', '$n');
}
