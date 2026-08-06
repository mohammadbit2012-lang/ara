import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/l10n/app_localizations.dart';

// ================= توکن‌های طراحی — کانسپت «آرام» =================
class AppColors {
  AppColors._();
  static const Color ivory = Color(0xFFF5EFE6);
  static const Color sand = Color(0xFFE4D5C3);
  static const Color camel = Color(0xFFB08968);
  static const Color gold = Color(0xFFC6A15B);
  static const Color goldDeep = Color(0xFF9C7A3C);
  static const Color goldLight = Color(0xFFE7CD9A);
  static const Color ink = Color(0xFF26221C);
  static const Color ctaBlack = Color(0xFF1E1512);
  static const Color cardLight = Color(0xFFFFFDF9);
  static const Color subtleLight = Color(0xFF8A7B6C);
  static const Color espresso = Color(0xFF1E1512);
  static const Color charcoal = Color(0xFF2A211D);
  static const Color cardDark = Color(0xFF352A23);
  static const Color champagne = Color(0xFFD4B483);
  static const Color cream = Color(0xFFF3E9DC);
  static const Color subtleDark = Color(0xFFB7A794);
}

class AppRadius {
  AppRadius._();
  static const double card = 24;
  static const double pill = 999;
}

class AppSpace {
  AppSpace._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

// ================= تم روشن / تیره =================
class AppTheme {
  AppTheme._();
  static ThemeData light(Locale locale) => _build(locale, true);
  static ThemeData dark(Locale locale) => _build(locale, false);

  static ThemeData _build(Locale locale, bool isLight) {
    final isFa = locale.languageCode == 'fa';
    final base = ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: isLight ? AppColors.ivory : AppColors.espresso,
      colorScheme: isLight
          ? const ColorScheme.light(
              primary: AppColors.ctaBlack, onPrimary: AppColors.ivory,
              secondary: AppColors.camel, onSecondary: AppColors.ivory,
              surface: AppColors.cardLight, onSurface: AppColors.ink,
              outline: AppColors.sand)
          : const ColorScheme.dark(
              primary: AppColors.champagne, onPrimary: AppColors.espresso,
              secondary: AppColors.champagne, onSecondary: AppColors.espresso,
              surface: AppColors.cardDark, onSurface: AppColors.cream,
              outline: AppColors.charcoal),
    );

    TextTheme textTheme = isFa
        ? GoogleFonts.vazirmatnTextTheme(base.textTheme)
        : GoogleFonts.manropeTextTheme(base.textTheme);
    textTheme = textTheme.apply(
      bodyColor: isLight ? AppColors.ink : AppColors.cream,
      displayColor: isLight ? AppColors.ink : AppColors.cream,
    );

    return base.copyWith(textTheme: textTheme);
  }
}

// ================= مدل سراسری (زبان + تم) =================
class AppModel extends ChangeNotifier {
  AppModel._();
  static final AppModel instance = AppModel._();

  Locale _locale = const Locale('fa');
  ThemeMode _themeMode = ThemeMode.light;
  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  void setLocale(Locale l) {
    if (_locale == l) return;
    _locale = l;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// ================= دکمهٔ برند =================
enum AppButtonVariant { primary, secondary, outline }

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label, this.onPressed,
    this.variant = AppButtonVariant.primary, this.icon});
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color bg = Colors.transparent;
    Color fg = AppColors.ink;
    BorderSide? side;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = isDark ? AppColors.champagne : AppColors.ctaBlack;
        fg = isDark ? AppColors.espresso : AppColors.ivory;
        break;
      case AppButtonVariant.secondary:
        bg = AppColors.camel;
        fg = AppColors.ivory;
        break;
      case AppButtonVariant.outline:
        fg = isDark ? AppColors.cream : AppColors.ink;
        side = BorderSide(color: isDark ? AppColors.charcoal : AppColors.sand, width: 1.5);
        break;
    }

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg, foregroundColor: fg, elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            side: side ?? BorderSide.none,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (icon != null) ...[icon!, const SizedBox(width: AppSpace.sm)],
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ]),
      ),
    );
  }
}

// ================= مونوگرام + وردمارک =================
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.monoSize = 96});
  final double monoSize;

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [AppColors.goldLight, AppColors.gold, AppColors.goldDeep],
        ).createShader(rect),
        child: Text('آ', style: TextStyle(fontSize: monoSize,
            fontWeight: FontWeight.w800, color: Colors.white, height: 1.15)),
      ),
      const SizedBox(height: AppSpace.sm),
      isFa
          ? Text('آرا', style: TextStyle(fontSize: monoSize * 0.3,
              fontWeight: FontWeight.w800, letterSpacing: -0.5,
              color: isDark ? AppColors.cream : AppColors.ink))
          : Text('ARA', style: GoogleFonts.fraunces(fontSize: monoSize * 0.3,
              letterSpacing: 8, fontWeight: FontWeight.w600,
              color: isDark ? AppColors.champagne : AppColors.gold)),
    ]);
  }
}

// ================= سوییچ زبان/تم =================
class TopControls extends StatelessWidget {
  const TopControls({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AppModel.instance;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isFa = model.locale.languageCode == 'fa';
    final selectedBg = isDark ? AppColors.champagne : AppColors.ctaBlack;
    final selectedFg = isDark ? AppColors.espresso : AppColors.ivory;
    final idleBorder = isDark ? AppColors.charcoal : AppColors.sand;
    final idleFg = isDark ? AppColors.cream : AppColors.ink;

    Widget chip(String label, bool selected, VoidCallback onTap) => GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: selected ? selectedBg : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: selected ? selectedBg : idleBorder),
            ),
            child: Text(label, style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w700, color: selected ? selectedFg : idleFg)),
          ),
        );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(children: [
        chip('فا', isFa, () => model.setLocale(const Locale('fa'))),
        const SizedBox(width: 6),
        chip('EN', !isFa, () => model.setLocale(const Locale('en'))),
        const Spacer(),
        IconButton(
          onPressed: model.toggleTheme,
          icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: isDark ? AppColors.champagne : AppColors.ink),
        ),
      ]),
    );
  }
}

// ================= اسپلش =================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: Column(children: [
            const TopControls(),
            const Spacer(),
            const BrandMark(monoSize: 120),
            const SizedBox(height: AppSpace.lg),
            Text(l10n.appTagline,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: isDark ? AppColors.subtleDark : AppColors.subtleLight)),
            const Spacer(),
            const SizedBox(width: 22, height: 22,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gold)),
            const SizedBox(height: AppSpace.xxl),
          ]),
        ),
      ),
    );
  }
}

// ================= آن‌بوردینگ =================
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pages = [
      (Icons.auto_awesome_outlined, l10n.onboarding1Title, l10n.onboarding1Body),
      (Icons.checkroom_outlined, l10n.onboarding2Title, l10n.onboarding2Body),
      (Icons.wb_sunny_outlined, l10n.onboarding3Title, l10n.onboarding3Body),
    ];
    final isLast = _page == pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: Column(children: [
            const TopControls(),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (v) => setState(() => _page = v),
                children: [for (final p in pages) _Page(icon: p.$1, title: p.$2, body: p.$3)],
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(
              pages.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _page ? 22 : 7, height: 7,
                decoration: BoxDecoration(
                  color: i == _page ? AppColors.camel
                      : (isDark ? AppColors.charcoal : AppColors.sand),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            )),
            const SizedBox(height: AppSpace.xl),
            AppButton(
              label: isLast ? l10n.getStarted : l10n.next,
              variant: isLast ? AppButtonVariant.secondary : AppButtonVariant.primary,
              onPressed: () {
                if (isLast) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                } else {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.icon, required this.title, required this.body});
  final IconData icon; final String title; final String body;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Column(children: [
      const SizedBox(height: AppSpace.xl),
      Text(title, textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: AppSpace.sm),
      Text(body, textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.subtleDark : AppColors.subtleLight)),
      const SizedBox(height: AppSpace.xxl),
      Expanded(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: isDark
                  ? [AppColors.charcoal, AppColors.espresso]
                  : [AppColors.sand.withOpacity(.55), AppColors.ivory]),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: isDark ? AppColors.charcoal : AppColors.sand),
          ),
          child: Center(child: Icon(icon, size: 110,
              color: isDark ? AppColors.champagne : AppColors.camel)),
        ),
      ),
    ]);
  }
}

// ================= ورود =================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: Column(children: [
            const TopControls(),
            const Spacer(),
            const BrandMark(monoSize: 84),
            const SizedBox(height: AppSpace.xxl),
            Text(l10n.welcomeTitle,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpace.sm),
            Text(l10n.welcomeBody,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.subtleDark : AppColors.subtleLight)),
            const SizedBox(height: AppSpace.xxl),
            AppButton(label: l10n.loginMobile, onPressed: () {}),
            const SizedBox(height: AppSpace.md),
            AppButton(label: l10n.loginGoogle, variant: AppButtonVariant.outline,
                icon: const Text('G', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                onPressed: () {}),
            const SizedBox(height: AppSpace.md),
            AppButton(label: l10n.loginApple, variant: AppButtonVariant.outline,
                icon: const Icon(Icons.apple, size: 20), onPressed: () {}),
            const SizedBox(height: AppSpace.md),
            TextButton(onPressed: () {}, child: Text(l10n.signUp)),
            const Spacer(),
          ]),
        ),
      ),
    );
  }
}

// ================= ریشهٔ اپ =================
void main() => runApp(const AraApp());

class AraApp extends StatelessWidget {
  const AraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppModel.instance,
      builder: (context, _) {
        final model = AppModel.instance;
        return MaterialApp(
          title: 'آرا | ARA',
          debugShowCheckedModeBanner: false,
          locale: model.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.light(model.locale),
          darkTheme: AppTheme.dark(model.locale),
          themeMode: model.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
