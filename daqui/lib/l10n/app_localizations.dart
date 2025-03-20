import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @add_favs.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi preferiti'**
  String get add_favs;

  /// No description provided for @already_fav.
  ///
  /// In it, this message translates to:
  /// **' è gia nella tua lista dei preferiti!'**
  String get already_fav;

  /// No description provided for @already_departed.
  ///
  /// In it, this message translates to:
  /// **'Già partito'**
  String get already_departed;

  /// No description provided for @areadifermata.
  ///
  /// In it, this message translates to:
  /// **'Fermata'**
  String get areadifermata;

  /// No description provided for @arrival.
  ///
  /// In it, this message translates to:
  /// **'Destinazione'**
  String get arrival;

  /// No description provided for @civico.
  ///
  /// In it, this message translates to:
  /// **'Indirizzo'**
  String get civico;

  /// No description provided for @coffe.
  ///
  /// In it, this message translates to:
  /// **'Offrimi un caffè'**
  String get coffe;

  /// No description provided for @comune.
  ///
  /// In it, this message translates to:
  /// **'Comune'**
  String get comune;

  /// No description provided for @contact.
  ///
  /// In it, this message translates to:
  /// **'contatti'**
  String get contact;

  /// No description provided for @data_banner_drawer.
  ///
  /// In it, this message translates to:
  /// **'Dati sempre aggiornati direttamente da:'**
  String get data_banner_drawer;

  /// No description provided for @days.
  ///
  /// In it, this message translates to:
  /// **'g'**
  String get days;

  /// No description provided for @departs_at.
  ///
  /// In it, this message translates to:
  /// **'Parte tra'**
  String get departs_at;

  /// No description provided for @departure.
  ///
  /// In it, this message translates to:
  /// **'Partenza'**
  String get departure;

  /// No description provided for @directions_maps.
  ///
  /// In it, this message translates to:
  /// **'Indicazioni su maps'**
  String get directions_maps;

  /// No description provided for @duration.
  ///
  /// In it, this message translates to:
  /// **'Durata: '**
  String get duration;

  /// No description provided for @favs.
  ///
  /// In it, this message translates to:
  /// **'Preferiti'**
  String get favs;

  /// No description provided for @homescreen_greeting.
  ///
  /// In it, this message translates to:
  /// **'Ciao!'**
  String get homescreen_greeting;

  /// No description provided for @hours.
  ///
  /// In it, this message translates to:
  /// **'ore'**
  String get hours;

  /// No description provided for @indirizzo.
  ///
  /// In it, this message translates to:
  /// **'Indirizzo'**
  String get indirizzo;

  /// No description provided for @language.
  ///
  /// In it, this message translates to:
  /// **'Lingua'**
  String get language;

  /// No description provided for @load_more.
  ///
  /// In it, this message translates to:
  /// **'Carica altri soluzioni'**
  String get load_more;

  /// No description provided for @location.
  ///
  /// In it, this message translates to:
  /// **'Posizione'**
  String get location;

  /// No description provided for @no_vehicles_given.
  ///
  /// In it, this message translates to:
  /// **'Nessun mezzo selezionato! Per favore seleziona almeno un mezzo nell\'menu!'**
  String get no_vehicles_given;

  /// No description provided for @no_favs.
  ///
  /// In it, this message translates to:
  /// **'Non hai preferiti'**
  String get no_favs;

  /// No description provided for @no_results.
  ///
  /// In it, this message translates to:
  /// **'Non ci sono risultati per la tua ricerca'**
  String get no_results;

  /// No description provided for @no_stations_found.
  ///
  /// In it, this message translates to:
  /// **'Nessuna fermata trovata...'**
  String get no_stations_found;

  /// No description provided for @no_stations_given.
  ///
  /// In it, this message translates to:
  /// **'Indicare partenza e destinazione!'**
  String get no_stations_given;

  /// No description provided for @poi.
  ///
  /// In it, this message translates to:
  /// **'POI'**
  String get poi;

  /// No description provided for @posizione.
  ///
  /// In it, this message translates to:
  /// **'La tua posizione'**
  String get posizione;

  /// No description provided for @remove_favs.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi preferiti'**
  String get remove_favs;

  /// No description provided for @search_button.
  ///
  /// In it, this message translates to:
  /// **'Cerca'**
  String get search_button;

  /// No description provided for @search_stations.
  ///
  /// In it, this message translates to:
  /// **'Cerca stazioni...'**
  String get search_stations;

  /// No description provided for @select_vehicles.
  ///
  /// In it, this message translates to:
  /// **'Seleziona mezzi:'**
  String get select_vehicles;

  /// No description provided for @train.
  ///
  /// In it, this message translates to:
  /// **'Treno'**
  String get train;

  /// No description provided for @metro.
  ///
  /// In it, this message translates to:
  /// **'Metro'**
  String get metro;

  /// No description provided for @cable_car.
  ///
  /// In it, this message translates to:
  /// **'Funivia'**
  String get cable_car;

  /// No description provided for @bus.
  ///
  /// In it, this message translates to:
  /// **'Bus'**
  String get bus;

  /// No description provided for @tram.
  ///
  /// In it, this message translates to:
  /// **'Tram'**
  String get tram;

  /// No description provided for @ship.
  ///
  /// In it, this message translates to:
  /// **'Traghetto'**
  String get ship;

  /// No description provided for @server_unavailable.
  ///
  /// In it, this message translates to:
  /// **'Server non raggiungibile'**
  String get server_unavailable;

  /// No description provided for @server_unavailable_details.
  ///
  /// In it, this message translates to:
  /// **'Non riesco ad accedere al server! Verifica la tua conessione.'**
  String get server_unavailable_details;

  /// No description provided for @solutions.
  ///
  /// In it, this message translates to:
  /// **'Soluzioni'**
  String get solutions;

  /// No description provided for @station_cannot_be_same.
  ///
  /// In it, this message translates to:
  /// **'Stazione di partenza non può essere uguale alla stazione di destinazione!'**
  String get station_cannot_be_same;

  /// No description provided for @stop.
  ///
  /// In it, this message translates to:
  /// **' fermata'**
  String get stop;

  /// No description provided for @stop_type_not_found.
  ///
  /// In it, this message translates to:
  /// **'Tipo di fermata sconosciuto'**
  String get stop_type_not_found;

  /// No description provided for @stops.
  ///
  /// In it, this message translates to:
  /// **' fermate'**
  String get stops;

  /// No description provided for @transfers.
  ///
  /// In it, this message translates to:
  /// **'Cambi: '**
  String get transfers;

  /// No description provided for @travel_route.
  ///
  /// In it, this message translates to:
  /// **'Viaggio'**
  String get travel_route;

  /// No description provided for @try_add_favs.
  ///
  /// In it, this message translates to:
  /// **'Prova ad aggiungerne un paia'**
  String get try_add_favs;

  /// No description provided for @try_again.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get try_again;

  /// No description provided for @we_are_sorry.
  ///
  /// In it, this message translates to:
  /// **'Ci dispiace!'**
  String get we_are_sorry;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
