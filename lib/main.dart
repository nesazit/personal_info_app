import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    // Color surfaceColor = Color(0x0dffffff);
    // Color primaryColor = Colors.pink.shade400;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      themeMode: ThemeMode.system,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = "IranYekan";
  Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = const Color(0x0dffffff),
        backgroundColor = const Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = const Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = const Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: false,
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: brightness,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor))),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: primaryTextColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: languageCode == "en" ? enPrimaryTextTheme : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyLarge: TextStyle(
          fontSize: 15,
          color: primaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: secondaryTextColor,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ));

  TextTheme get faPrimaryTextTheme => TextTheme(
        bodyLarge: TextStyle(
          fontSize: 15,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          height: 2,
          color: secondaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
      );
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;

  const MyHomePage(
      {super.key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;

  void _updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.profileTitle),
          actions: [
            const Icon(CupertinoIcons.text_bubble),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: widget.toggleThemeMode,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                child: Icon(CupertinoIcons.ellipsis_vertical),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/profile_image.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(localization.job),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                                size: 18,
                              ),
                              Text(
                                localization.location,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.heart,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  localization.summary,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 10,
                indent: 80,
                endIndent: 80,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.selectedLanguage),
                    CupertinoSlidingSegmentedControl<_Language>(
                        groupValue: _language,
                        thumbColor: Theme.of(context).colorScheme.primary,
                        children: {
                          _Language.en: Text(localization.enLanguage),
                          _Language.fa: Text(localization.faLanguage)
                        },
                        onValueChanged: (value) {
                          if (value != null) {
                            _updateSelectedLanguage(value);
                          }
                        }),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localization.skills,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      size: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Skill(
                      onTap: () {
                        _updateSelectedSkill(_SkillType.photoshop);
                      },
                      type: _SkillType.photoshop,
                      title: localization.photoshop,
                      imagePath: 'assets/images/app_icon_01.png',
                      shadowColor: Colors.blue,
                      isActive: _skill == _SkillType.photoshop,
                    ),
                    Skill(
                      onTap: () {
                        _updateSelectedSkill(_SkillType.xd);
                      },
                      type: _SkillType.xd,
                      title: localization.xd,
                      imagePath: 'assets/images/app_icon_05.png',
                      shadowColor: Colors.pink,
                      isActive: _skill == _SkillType.xd,
                    ),
                    Skill(
                      onTap: () {
                        _updateSelectedSkill(_SkillType.illustrator);
                      },
                      type: _SkillType.illustrator,
                      title: localization.illustrator,
                      imagePath: 'assets/images/app_icon_04.png',
                      shadowColor: Colors.orange,
                      isActive: _skill == _SkillType.illustrator,
                    ),
                    Skill(
                      onTap: () {
                        _updateSelectedSkill(_SkillType.afterEffect);
                      },
                      type: _SkillType.afterEffect,
                      title: localization.aftereffect,
                      imagePath: 'assets/images/app_icon_03.png',
                      shadowColor: Colors.blue.shade800,
                      isActive: _skill == _SkillType.afterEffect,
                    ),
                    Skill(
                      onTap: () {
                        _updateSelectedSkill(_SkillType.lightroom);
                      },
                      type: _SkillType.lightroom,
                      title: localization.lightroom,
                      imagePath: 'assets/images/app_icon_02.png',
                      shadowColor: Colors.blue,
                      isActive: _skill == _SkillType.lightroom,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.personalInformation,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.email,
                        prefixIcon: Icon(CupertinoIcons.at),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          localization.saveBtn,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const Skill({
    super.key,
    required this.onTap,
    required this.type,
    required this.title,
    required this.imagePath,
    required this.shadowColor,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBorderRadius = BorderRadius.circular(16);

    return InkWell(
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: defaultBorderRadius,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor.withOpacity(0.8),
                            blurRadius: 20),
                      ],
                    )
                  : null,
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

enum _SkillType { photoshop, xd, illustrator, afterEffect, lightroom }

enum _Language { en, fa }
