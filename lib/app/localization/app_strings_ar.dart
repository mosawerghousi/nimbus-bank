import 'app_strings.dart';

/// Arabic strings — natural Modern Standard Arabic banking copy, not a
/// literal/machine translation of the English. Numbers/currency stay in
/// Western Arabic numerals and `$` amounts, matching common Gulf/Levant
/// neobank convention (see task scope). Brand name ("Nimbus"), personal
/// names, bank/merchant names and email addresses are intentionally left
/// untranslated — same as the English copy.
class AppStringsAr extends AppStrings {
  const AppStringsAr();

  // Common
  @override
  String get commonContinue => 'متابعة';
  @override
  String get commonDone => 'تم';
  @override
  String get commonClose => 'إغلاق';
  @override
  String get commonCancel => 'إلغاء';
  @override
  String get commonSave => 'حفظ';
  @override
  String get commonAmount => 'المبلغ';
  @override
  String get commonStatus => 'الحالة';
  @override
  String get commonFree => 'مجانًا';
  @override
  String get commonFee => 'الرسوم';
  @override
  String get commonPending => 'قيد الانتظار';
  @override
  String get commonRevoke => 'إلغاء الجلسة';
  @override
  String get commonToday => 'اليوم';
  @override
  String get commonYesterday => 'أمس';
  @override
  String get commonAll => 'الكل';
  @override
  String get commonOther => 'أخرى';

  // App / brand
  @override
  String get appTagline => 'الخدمات المصرفية، ببساطة';

  // Onboarding
  @override
  String get onboardingSkip => 'تخطّي';
  @override
  String get onboardingGetStarted => 'ابدأ الآن';
  @override
  String get onboardingSlide1Eyebrow => 'سجل مالي فوري';
  @override
  String get onboardingSlide1Title => 'تابع كل دولار\nلحظة بلحظة.';
  @override
  String get onboardingSlide1Body =>
      'كل عملية شراء واشتراك وراتب تظهر في سجلك فور حدوثها — دون '
      'انتظار كشف حساب ليلحق بالركب.';
  @override
  String get onboardingSlide2Eyebrow => 'تحويلات فورية';
  @override
  String get onboardingSlide2Title => 'أرسل الأموال\nفورًا ومجانًا.';
  @override
  String get onboardingSlide2Body =>
      'أعد المال لصديق أو انقل الأموال بين حساباتك خلال ثوانٍ — بلا '
      'رسوم وبلا انتظار أيام العمل.';
  @override
  String get onboardingSlide3Eyebrow => 'بطاقاتك';
  @override
  String get onboardingSlide3Title => 'بطاقات صُممت\nخصيصًا لك.';
  @override
  String get onboardingSlide3Body =>
      'جمّد بطاقتك فور فقدانها، وأنشئ بطاقة افتراضية للتسوق الإلكتروني، '
      'وتابع كل عملية شراء لحظة حدوثها.';

  // Auth
  @override
  String get authWelcomeBack => 'أهلاً بعودتك';
  @override
  String get authSignInTitle => 'سجّل الدخول إلى\nحسابك في Nimbus.';
  @override
  String get authEmailLabel => 'البريد الإلكتروني';
  @override
  String get authEmailRequired => 'البريد الإلكتروني مطلوب';
  @override
  String get authEmailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';
  @override
  String get authPasswordLabel => 'كلمة المرور';
  @override
  String get authPasswordRequired => 'كلمة المرور مطلوبة';
  @override
  String authPasswordMinLength(int count) => '$count أحرف على الأقل';
  @override
  String get authRememberMe => 'تذكرني';
  @override
  String get authForgotPassword => 'نسيت كلمة المرور؟';
  @override
  String get authSignIn => 'تسجيل الدخول';
  @override
  String get authOrContinueWith => 'أو تابع باستخدام';
  @override
  String authSocialContinuing(String provider) => 'جارٍ المتابعة عبر $provider…';
  @override
  String get authNewToNimbus => 'جديد على Nimbus؟ ';
  @override
  String get authCreateAccount => 'إنشاء حساب';
  @override
  String authResetLinkSent(String email) =>
      'أرسلنا رابط إعادة التعيين إلى $email. تحقق من بريدك الوارد.';
  @override
  String get authResetLinkPrompt =>
      'أدخل البريد الإلكتروني المرتبط بحسابك في Nimbus وسنرسل لك رابط '
      'إعادة التعيين.';
  @override
  String get authSendResetLink => 'إرسال رابط إعادة التعيين';
  @override
  String get authAcceptTermsError => 'يرجى الموافقة على الشروط للمتابعة.';
  @override
  String get authJoinNimbus => 'انضم إلى Nimbus';
  @override
  String get authCreateAccountTitle => 'أنشئ حسابك\nفي Nimbus.';
  @override
  String get authFullNameLabel => 'الاسم الكامل';
  @override
  String get authFullNameRequired => 'الاسم مطلوب';
  @override
  String get authAgreeToTermsPrefix => 'أوافق على ';
  @override
  String get authTermsOfService => 'شروط الخدمة';
  @override
  String get authAgreeToTermsAnd => ' و';
  @override
  String get authPrivacyPolicy => 'سياسة الخصوصية';
  @override
  String get authAgreeToTermsSuffix => ' الخاصة بـ Nimbus.';
  @override
  String get authOrSignUpWith => 'أو أنشئ حسابًا عبر';
  @override
  String get authAlreadyMember => 'لديك حساب بالفعل؟ ';

  // Cards
  @override
  String get cardsWallet => 'المحفظة';
  @override
  String get cardsYourCards => 'بطاقاتك';
  @override
  String cardsLinked(int count) => _arabicCount(
        count,
        zero: 'لا توجد بطاقات مرتبطة بحساباتك.',
        one: 'بطاقة واحدة مرتبطة بحساباتك.',
        two: 'بطاقتان مرتبطتان بحساباتك.',
        few: '{n} بطاقات مرتبطة بحساباتك.',
        many: '{n} بطاقة مرتبطة بحساباتك.',
      );
  @override
  String get cardsAddNewCard => 'إضافة بطاقة جديدة';
  @override
  String get cardsCardType => 'نوع البطاقة';
  @override
  String get cardTypeDebit => 'خصم مباشر';
  @override
  String get cardTypeCredit => 'ائتمان';
  @override
  String get cardTypeVirtual => 'افتراضية';
  @override
  String get cardTypeDebitDescription => 'أنفق مباشرة من حساب مرتبط.';
  @override
  String get cardTypeCreditDescription => 'ابنِ سجلك الائتماني بحد متجدد.';
  @override
  String get cardTypeVirtualDescription => 'رقم بطاقة مخصص للمشتريات الإلكترونية فقط.';
  @override
  String get cardsDesign => 'التصميم';
  @override
  String get cardsCreateCard => 'إنشاء البطاقة';
  @override
  String get cardsUnfreezeCard => 'إلغاء تجميد البطاقة';
  @override
  String get cardsFreezeCard => 'تجميد البطاقة';
  @override
  String get cardsHideNumber => 'إخفاء الرقم';
  @override
  String get cardsRevealNumber => 'إظهار الرقم';
  @override
  String get cardsFrozenNotice =>
      'هذه البطاقة مجمّدة. سيتم رفض أي عمليات شراء أو سحب أو دفع '
      'جديدة حتى تُلغي تجميدها.';
  @override
  String get cardsManage => 'الإدارة';
  @override
  String get cardsSettings => 'إعدادات البطاقة';
  @override
  String get cardsChangePin => 'تغيير الرقم السري';
  @override
  String get cardsSpendingLimit => 'حد الإنفاق';
  @override
  String get cardsReportLostStolen => 'الإبلاغ عن فقدان أو سرقة';
  @override
  String get pinChangeRequestSnack => 'تم إرسال طلب تغيير الرقم السري إلى جهازك.';
  @override
  String get cardsSpendingLimitSnack => 'حد الإنفاق الحالي محدد بـ 5,000\$ شهريًا.';
  @override
  String get cardsReportLostStolenSnack =>
      'تم إبلاغ فريق الدعم وسيتواصل معك قريبًا.';
  @override
  String get cardCardholder => 'حامل البطاقة';
  @override
  String get cardExpires => 'تاريخ الانتهاء';
  @override
  String get cardFrozenBadge => 'مجمّدة';
  @override
  String get cardNetworkVisa => 'Visa';
  @override
  String get cardNetworkMastercard => 'Mastercard';

  // Account types
  @override
  String get accountTypeChecking => 'جاري';
  @override
  String get accountTypeSavings => 'توفير';
  @override
  String get accountTypeJoint => 'مشترك';

  // Spend categories
  @override
  String get spendCategoryGroceries => 'بقالة';
  @override
  String get spendCategoryTransport => 'مواصلات';
  @override
  String get spendCategorySubscriptions => 'اشتراكات';
  @override
  String get spendCategoryDining => 'مطاعم';
  @override
  String get spendCategoryShopping => 'تسوق';
  @override
  String get spendCategoryEntertainment => 'ترفيه';
  @override
  String get spendCategoryIncome => 'دخل';
  @override
  String get spendCategoryTransfers => 'تحويلات';

  // Home
  @override
  String get homeGoodMorning => 'صباح الخير';
  @override
  String get homeGoodAfternoon => 'طاب يومك';
  @override
  String get homeGoodEvening => 'مساء الخير';
  @override
  String get homeAvailableBalance => 'الرصيد المتاح';
  @override
  String get homeThisMonthEyebrow => 'هذا الشهر';
  @override
  String get homeSpendingOverview => 'نظرة على الإنفاق';
  @override
  String get homeDetails => 'التفاصيل';
  @override
  String get homeLatestActivityEyebrow => 'أحدث النشاطات';
  @override
  String get homeRecentTransactions => 'أحدث المعاملات';
  @override
  String get homeSeeAll => 'عرض الكل';
  @override
  String get quickActionSend => 'إرسال';
  @override
  String get quickActionRequest => 'طلب';
  @override
  String get quickActionTopUp => 'إضافة رصيد';
  @override
  String get quickActionMore => 'المزيد';
  @override
  String get moreActionsTitle => 'المزيد من الخيارات';
  @override
  String get moreActionsStatements => 'كشوف الحساب';
  @override
  String get moreActionsCurrencyExchange => 'تحويل العملات';
  @override
  String get moreActionsReferFriend => 'ادعُ صديقًا';
  @override
  String get helpSupport => 'المساعدة والدعم';

  // Spend chart
  @override
  String get spendChartNoSpending => 'لا توجد أي مصاريف مسجّلة هذا الشهر بعد.';
  @override
  String get spendChartTotalSpent => 'إجمالي الإنفاق';

  // Transaction detail
  @override
  String get transactionCategory => 'الفئة';
  @override
  String get transactionDate => 'التاريخ';
  @override
  String get transactionAccount => 'الحساب';
  @override
  String get transactionStatusCompleted => 'مكتملة';

  // Transactions
  @override
  String get transactionsActivityEyebrow => 'النشاط';
  @override
  String get transactionsTitle => 'المعاملات';
  @override
  String get transactionsSearchHint => 'ابحث في المعاملات…';
  @override
  String get transactionsThisMonth => 'هذا الشهر';
  @override
  String get transactionsEmptyTitle => 'لا توجد معاملات';
  @override
  String get transactionsEmptyBody => 'جرّب كلمة بحث أو فئة مختلفة.';

  // Transfer
  @override
  String get transferSendMoney => 'إرسال أموال';
  @override
  String get transferChooseRecipient => 'اختر الشخص الذي ترسل إليه.';
  @override
  String get errorAmountTooLow => 'أدخل مبلغًا أكبر من 0\$.';
  @override
  String transferFromAccount(String name, String masked) => 'من $name · $masked';
  @override
  String get transferSendFrom => 'الإرسال من';
  @override
  String get transferSendTo => 'الإرسال إلى';
  @override
  String get transferNoteOptional => 'ملاحظة (اختياري)';
  @override
  String get transferNoteHint => 'ما سبب التحويل؟';

  @override
  String get transferReviewTitle => 'مراجعة التحويل';
  @override
  String get transferYoureSending => 'أنت ترسل';
  @override
  String transferToContact(String name) => 'إلى $name';
  @override
  String get transferFromLabel => 'من';
  @override
  String get transferToLabel => 'إلى';
  @override
  String get transferNoteLabel => 'ملاحظة';
  @override
  String get transferFeeLabel => 'رسوم التحويل';
  @override
  String get transferNoNoteAdded => 'لا توجد ملاحظة';
  @override
  String get transferTotalLabel => 'الإجمالي';
  @override
  String transferInstantNote(String firstName) =>
      'فوري — يصل إلى حساب $firstName على الفور.';
  @override
  String get transferConfirmSend => 'تأكيد الإرسال';

  @override
  String get transferMoneySent => 'تم إرسال الأموال.';
  @override
  String transferSentBody(String amount, String name) =>
      '$amount في طريقه إلى $name. سيظهر في حسابه على الفور.';

  // Request
  @override
  String get requestMoney => 'طلب أموال';
  @override
  String get requestNotifyHint => 'سنُعلمك فور الدفع';
  @override
  String get requestChooseContact => 'اختر الشخص الذي تطلب منه.';
  @override
  String get requestFromEyebrow => 'الطلب من';
  @override
  String get requestButton => 'طلب';

  @override
  String get requestSentTitle => 'تم إرسال الطلب.';
  @override
  String requestSentBody(String amount, String name) =>
      'تم طلب $amount من $name. سنُعلمك عند الدفع.';

  // Top up
  @override
  String get topupAddMoney => 'إضافة أموال';
  @override
  String get topupChooseAccount => 'اختر الحساب الذي تريد إضافة الأموال إليه.';
  @override
  String topupIntoAccount(String name, String masked) => 'إلى $name · $masked';
  @override
  String get topupFromEyebrow => 'من';
  @override
  String get topupToEyebrow => 'إلى';
  @override
  String get topupAddFunds => 'إضافة الرصيد';

  @override
  String get topupMoneyAdded => 'تمت إضافة الأموال.';
  @override
  String topupAddedBody(String amount, String source, String account) =>
      'أصبح مبلغ $amount من $source متاحًا الآن في حساب $account.';
  @override
  String get topupAdded => 'المُضاف';
  @override
  String get topupNewBalance => 'الرصيد الجديد';

  // Statements
  @override
  String get statementsEyebrow => 'نشاط الحساب';
  @override
  String get statementsTitle => 'كشوف الحساب';
  @override
  String get statementsSubtitle => 'ملخصات شهرية لما أنفقته وكسبته.';
  @override
  String get statementsLast6Months => 'آخر 6 أشهر';
  @override
  String statementsTransactionsCount(int count) => _arabicCount(
        count,
        zero: 'لا توجد معاملات',
        one: 'معاملة واحدة',
        two: 'معاملتان',
        few: '{n} معاملات',
        many: '{n} معاملة',
      );
  @override
  String statementsSpentEarned(String spent, String income) =>
      'أُنفق $spent · اكتُسب $income';
  @override
  String get statementsNoSpending => 'لا توجد أي مصاريف مسجّلة هذا الشهر.';

  // Exchange
  @override
  String get exchangeEyebrow => 'تحويل';
  @override
  String get exchangeTitle => 'تحويل العملات';
  @override
  String get exchangeSubtitle => 'أسعار صرف تجريبية تُحدَّث أثناء الكتابة.';
  @override
  String get exchangeAllRates => 'جميع الأسعار · لكل 1 دولار أمريكي';

  // Refer
  @override
  String get referEyebrow => 'ادعُ أصدقاءك';
  @override
  String get referTitle => 'ادعُ صديقًا';
  @override
  String get referSubtitle => 'امنح 20\$، واحصل على 20\$ — ادعُ أصدقاءك إلى Nimbus.';
  @override
  String get referGiveGet => 'امنح 20\$، واحصل على 20\$';
  @override
  String get referGiveGetBody =>
      'عندما ينضم صديقك إلى Nimbus باستخدام رمزك ويجري أول تحويل له، '
      'يحصل كلاكما على 20\$.';
  @override
  String get referYourCode => 'رمز الإحالة الخاص بك';
  @override
  String get referCopyCode => 'نسخ الرمز';
  @override
  String get referCopiedSnack => 'تم النسخ إلى الحافظة';
  @override
  String get referHowItWorks => 'كيف تعمل الخدمة';
  @override
  String get referStep1Title => 'شارك رمزك';
  @override
  String get referStep1Body =>
      'أرسل رمز الإحالة الخاص بك إلى صديق أو أحد أفراد العائلة أو أي شخص.';
  @override
  String get referStep2Title => 'يقومون بالتسجيل';
  @override
  String get referStep2Body =>
      'يقوم صديقك بتحميل Nimbus وإدخال رمزك عند الانضمام.';
  @override
  String get referStep3Title => 'يحصل كلاكما على المكافأة';
  @override
  String get referStep3Body =>
      'بعد أول تحويل لهما، يصل مبلغ 20\$ إلى حساب كل منكما.';

  // Connect bank
  @override
  String get connectBankLinkAccount => 'ربط حساب';
  @override
  String get connectBankTitle => 'ربط بنك جديد';
  @override
  String get connectBankSubtitle => 'اختر بنكًا خارجيًا لربطه بـ Nimbus.';
  @override
  String connectBankConnecting(String bankName) => 'جارٍ الاتصال بـ $bankName…';
  @override
  String get connectBankTakesMoment => 'عادة ما يستغرق ذلك لحظات فقط.';
  @override
  String connectBankConnected(String bankName) => 'تم الاتصال بـ $bankName.';
  @override
  String get connectBankSeeUnderExternal =>
      'ستجد هذا الحساب الآن ضمن البنوك الخارجية.';

  // Help
  @override
  String get helpEyebrow => 'نحن هنا لمساعدتك';
  @override
  String get helpSubtitle => 'إجابات عن الأسئلة الشائعة، أو تواصل مع أحد ممثلي الدعم.';
  @override
  String get helpFrequentlyAsked => 'الأسئلة الشائعة';
  @override
  String get helpFaq1Q => 'كم من الوقت تستغرق التحويلات؟';
  @override
  String get helpFaq1A =>
      'التحويلات بين حسابات Nimbus وإلى أعضاء Nimbus الآخرين فورية. أما '
      'التحويلات إلى بنوك خارجية فتصل عادةً خلال يوم عمل واحد.';
  @override
  String get helpFaq2Q => 'كيف أجمّد بطاقة مفقودة؟';
  @override
  String get helpFaq2A =>
      'افتح البطاقات، اضغط على البطاقة، ثم اضغط على تجميد البطاقة. سيتم '
      'حظر عمليات الشراء والسحب فورًا — ويمكنك إلغاء التجميد في أي وقت '
      'إذا وجدتها مجددًا.';
  @override
  String get helpFaq3Q => 'هل أموالي مؤمَّنة؟';
  @override
  String get helpFaq3A =>
      'نعم — الأرصدة المحفوظة لدى البنك الشريك مؤمَّنة من قبل FDIC ضمن '
      'حد التغطية المعتاد، تمامًا كأي حساب مصرفي تقليدي.';
  @override
  String get helpFaq4Q => 'كيف أعترض على معاملة؟';
  @override
  String get helpFaq4A =>
      'افتح المعاملة من سجل حسابك واضغط على الإبلاغ عن مشكلة، أو تواصل '
      'مع الدعم أدناه. سنقوم بالتحقق والمتابعة خلال يومي عمل.';
  @override
  String get helpContactSupport => 'التواصل مع الدعم';
  @override
  String get helpChatWithUs => 'تحدث معنا';
  @override
  String get helpChatSublabel => 'عادة ما يتم الرد خلال دقائق';
  @override
  String get helpCallSupport => 'اتصل بالدعم';
  @override
  String get helpCallSublabel => '1-800-555-0199 · على مدار الساعة';
  @override
  String get helpEmailUs => 'راسلنا عبر البريد الإلكتروني';
  @override
  String get helpConnectingSnack => 'جارٍ توصيلك بأحد مختصي الدعم…';
  @override
  String get helpCallingSnack => 'جارٍ الاتصال بالرقم 1-800-555-0199…';
  @override
  String get helpEmailSnack => 'جارٍ فتح تطبيق البريد الإلكتروني…';

  // Linked accounts
  @override
  String get linkedAccountsEyebrow => 'كل أموالك في مكان واحد';
  @override
  String get linkedAccountsTitle => 'الحسابات المرتبطة';
  @override
  String get linkedAccountsSubtitle =>
      'حسابات Nimbus الخاصة بك، بالإضافة إلى أي بنوك خارجية تربطها.';
  @override
  String get linkNewBank => 'ربط بنك جديد';
  @override
  String get linkedAccountsNimbusAccounts => 'حسابات Nimbus';
  @override
  String get linkedAccountsExternalBanks => 'البنوك الخارجية';
  @override
  String get linkedAccountsConnectedBadge => 'متصل';

  // Notifications
  @override
  String get notificationsEyebrow => 'الوارد';
  @override
  String get notificationsTitle => 'الإشعارات';
  @override
  String get notificationsAllCaughtUp => 'لقد اطّلعت على كل شيء.';
  @override
  String notificationsUnreadCount(int count) => _arabicCount(
        count,
        zero: 'لا توجد رسائل غير مقروءة.',
        one: 'رسالة واحدة غير مقروءة.',
        two: 'رسالتان غير مقروءتان.',
        few: '{n} رسائل غير مقروءة.',
        many: '{n} رسالة غير مقروءة.',
      );
  @override
  String get notificationsMarkAllRead => 'تعليم الكل كمقروء';
  @override
  String get notificationsEarlier => 'سابقًا';
  @override
  String get notificationsEmptyTitle => 'لا توجد إشعارات';
  @override
  String get notificationsEmptyBody => 'سنُعلمك عندما يستدعي شيء انتباهك.';
  @override
  String get notifPayrollTitle => 'تم استلام إيداع الراتب';
  @override
  String get notifPayrollBody =>
      'تم إيداع 5,200.00\$ من Acme Corp Payroll في حساب Everyday.';
  @override
  String get notifSignInTitle => 'تم رصد تسجيل دخول جديد';
  @override
  String get notifSignInBody =>
      'تم الدخول إلى حسابك من جهاز جديد في سان فرانسيسكو.';
  @override
  String get notifSavingsRateTitle => 'ارتفعت نسبة فائدة التوفير إلى 4.2%';
  @override
  String get notifSavingsRateBody =>
      'أصبح حساب Savings الخاص بك يحقق عائدًا أكبر تلقائيًا.';
  @override
  String get notifCardDeclinedTitle => 'تم رفض عملية الدفع بالبطاقة';
  @override
  String get notifCardDeclinedBody =>
      'تم رفض بطاقة Nimbus Violet Credit ••2290 لدى Amazon — تم بلوغ الحد الائتماني.';
  @override
  String get notifStatementReadyTitle => 'كشف الحساب جاهز';
  @override
  String get notifStatementReadyBody =>
      'كشف حساب يوليو لحساب Everyday أصبح جاهزًا للعرض.';
  @override
  String get notifReferTitle => 'ادعُ صديقًا واحصل على 25\$';
  @override
  String get notifReferBody =>
      'ادعُ صديقًا إلى Nimbus — يحصل كلاكما على 25\$ عند تسجيله.';
  @override
  String get notifTimeAgo2h => 'قبل ساعتين';
  @override
  String get notifTimeAgo5h => 'قبل 5 ساعات';
  @override
  String get notifTimeAgo7h => 'قبل 7 ساعات';
  @override
  String get notifTimeAgo3d => 'قبل 3 أيام';
  @override
  String get notifTimeAgo1w => 'قبل أسبوع';

  // Personal info
  @override
  String get personalInfoEyebrow => 'الحساب';
  @override
  String get personalInfoTitle => 'المعلومات الشخصية';
  @override
  String get personalInfoSubtitle =>
      'حافظ على تحديث بياناتك لأغراض كشوف الحساب والدعم.';
  @override
  String get fieldPhone => 'رقم الهاتف';
  @override
  String get fieldAddress => 'العنوان';
  @override
  String get fieldDateOfBirth => 'تاريخ الميلاد';
  @override
  String editFieldTitle(String fieldLabel) => 'تعديل $fieldLabel';

  // Security
  @override
  String get securityEyebrow => 'احمِ حسابك';
  @override
  String get securityTitle => 'الأمان والرقم السري';
  @override
  String get securitySubtitle => 'تحكم في طريقة تسجيل الدخول وحافظ على أمان أموالك.';
  @override
  String get securityAppPin => 'الرقم السري للتطبيق';
  @override
  String get securityLastChanged => 'آخر تغيير قبل 4 أشهر';
  @override
  String get securityFaceId => 'بصمة الوجه والإصبع';
  @override
  String get securityFaceIdSub => 'افتح Nimbus دون الحاجة إلى الرقم السري';
  @override
  String get securityTwoFactor => 'التحقق بخطوتين';
  @override
  String get securityTwoFactorSub => 'طلب رمز تحقق عند استخدام جهاز جديد';
  @override
  String get securitySignInAlerts => 'تنبيهات تسجيل الدخول';
  @override
  String get securitySignInAlertsSub => 'احصل على إشعار عند تسجيل الدخول من جهاز جديد';
  @override
  String get securityActiveSessions => 'الجلسات النشطة';
  @override
  String get securityThisDeviceActive => 'هذا الجهاز · نشط الآن';
  @override
  String securityLastActive(String time) => 'آخر نشاط $time';
  @override
  String get securityTwoDaysAgo => 'قبل يومين';
  @override
  String securitySessionRevoked(String device) =>
      'تم تسجيل الخروج من الجلسة على $device.';

  // Profile
  @override
  String get profileVerifiedMember => 'عضو موثّق';
  @override
  String get profileAccountsStat => 'الحسابات';
  @override
  String get profileSinceStat => 'منذ';
  @override
  String get profileMemberSince => 'عضو منذ مارس 2024. شكرًا لتعاملك المصرفي مع Nimbus.';
  @override
  String get profileAppearance => 'المظهر';
  @override
  String get profileTheme => 'السمة';
  @override
  String get profileLanguageEyebrow => 'التفضيلات';
  @override
  String get profileLanguage => 'اللغة';
  @override
  String get profileAccountEyebrow => 'الحساب';
  @override
  String get profileSettingsHeadline => 'الإعدادات';
  @override
  String get menuLogOut => 'تسجيل الخروج';
  @override
  String get logOutConfirmTitle => 'تسجيل الخروج؟';
  @override
  String get logOutConfirmBody => 'يمكنك تسجيل الدخول مجددًا في أي وقت.';

  // Nav
  @override
  String get navHome => 'الرئيسية';
  @override
  String get navCards => 'البطاقات';
  @override
  String get navActivity => 'النشاط';
  @override
  String get navProfile => 'الملف الشخصي';

  // Language selector
  @override
  String get languageEnglish => 'English';
  @override
  String get languageArabic => 'العربية';

  // Theme mode selector
  @override
  String get themeLight => 'فاتح';
  @override
  String get themeSystem => 'تلقائي';
  @override
  String get themeDark => 'داكن';
}

/// Simple Arabic numeral-agreement helper for count-based UI copy — Arabic
/// distinguishes zero/one/two/few(3-10)/many(11+) forms. `{n}` in [few]/
/// [many] is replaced with the count.
String _arabicCount(
  int n, {
  required String zero,
  required String one,
  required String two,
  required String few,
  required String many,
}) {
  if (n == 0) return zero;
  if (n == 1) return one;
  if (n == 2) return two;
  if (n >= 3 && n <= 10) return few.replaceAll('{n}', '$n');
  return many.replaceAll('{n}', '$n');
}
