import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/designation_model.dart';

enum TravelTab {
  explore,
  events,
  activities,
}

// ============================================================
// EVENTS
// ============================================================

abstract class TravelEvent {}

class SelectTabEvent extends TravelEvent {
  final TravelTab tab;

  SelectTabEvent(this.tab);
}

class SearchCountryEvent extends TravelEvent {
  final String query;

  SearchCountryEvent(this.query);
}

class SearchActivityEvent extends TravelEvent {
  final String query;

  SearchActivityEvent(this.query);
}

// ============================================================
// STATE
// ============================================================

class TravelState {
  final TravelTab selectedTab;

  final String title;
  final String subtitle;
  final String locationText;
  final List<DestinationModel> destinations; // <-- Yahan destination objects hain
  final String bgImageUrl;
  final Color backgroundColor;

  final String searchHint;

  final List<Map<String, String>> eventCards;

  final List<Map<String, String>> activities;

  final String eventDate;
  final String featuredLocation;

  final String searchQuery;

  TravelState({
    required this.selectedTab,
    required this.title,
    required this.subtitle,
    required this.locationText,
    required this.bgImageUrl,
    required this.backgroundColor,
    required this.searchHint,
    required this.destinations,
    required this.eventCards,
    required this.activities,
    required this.eventDate,
    required this.featuredLocation,
    required this.searchQuery,
  });

  // ============================================================
  // INITIAL / EXPLORE DATA
  // ============================================================

  factory TravelState.initial() {
    return TravelState(
      selectedTab: TravelTab.explore,

      title: "where do you plan",
      subtitle: "to travel next",

      locationText: "Barreirinhas, Brasil",

      bgImageUrl:
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",

      backgroundColor: const Color(0xFFC4DFE6),

      searchHint: "Search Country",

      searchQuery: "",

      eventDate: "October 2026",

      featuredLocation: "F1 Championship, Barcelona",

      // ========================================================
      // DESTINATIONS DATA (Fixed: Ab yahan proper models hain jo UI mein show honge)
      // ========================================================

      destinations: [
        DestinationModel(
          country: "Thailand",
          image: "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a",
          flag: "🇹🇭", validDays: '',
        ),
        DestinationModel(
          country: "United Arab Emirates",
          image: "https://images.unsplash.com/photo-1512453979798-5ea266f8880c",
          flag: "🇦🇪", validDays: '',
        ),
        DestinationModel(
          country: "Indonesia",
          image: "https://images.unsplash.com/photo-1537996194471-e657df975ab4",
          flag: "🇮🇩", validDays: '',
        ),
        DestinationModel(
          country: "Singapore",
          image: "https://images.unsplash.com/photo-1525625293386-3f8f99389edd",
          flag: "🇸🇬", validDays: '',
        ),
        DestinationModel(
          country: "Maldives",
          image: "https://images.unsplash.com/photo-1514282401047-d79a71a590e8",
          flag: "🇲🇻", validDays: '',
        ),
        DestinationModel(
          country: "Dubai",
          image: "https://images.unsplash.com/photo-1512453979798-5ea266f8880c",
          flag: "🇦🇪", validDays: '',
        ),
      ],

      // ========================================================
      // EVENTS DATA
      // ========================================================

      eventCards: [
        {
          "countryFlag": "🇮🇩",
          "visaText": "Indonesia visa for",
          "eventTitle": "MOTOGP INDONESIA GP",
          "visaInfo": "Get Visa 12 days before",
          "image":
          "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7",
        },
        {
          "countryFlag": "🇮🇩",
          "visaText": "Indonesia visa for",
          "eventTitle": "MOTOGP INDONESIA 2026",
          "visaInfo": "Get Visa 12 days before",
          "image":
          "https://images.unsplash.com/photo-1534438327276-14e5300c3a48",
        },
      ],

      // ========================================================
      // ACTIVITIES DATA
      // ========================================================

      activities: [
        {
          "title": "Adventure",
          "subtitle": "Discover exciting adventures",
          "icon": "explore",
          "image":
          "https://images.unsplash.com/photo-1500534623283-312aade485b7",
        },
        {
          "title": "Nature",
          "subtitle": "Explore beautiful places",
          "icon": "nature",
          "image":
          "https://images.unsplash.com/photo-1501854140801-50d01698950b",
        },
        {
          "title": "Culture",
          "subtitle": "Experience local culture",
          "icon": "culture",
          "image":
          "https://images.unsplash.com/photo-1548013146-72479768bada",
        },
      ],
    );
  }

  // ============================================================
  // COPY WITH
  // ============================================================

  TravelState copyWith({
    TravelTab? selectedTab,
    String? title,
    String? subtitle,
    String? locationText,
    String? bgImageUrl,
    Color? backgroundColor,
    List<DestinationModel>? destinations,
    String? searchHint,
    List<Map<String, String>>? eventCards,
    List<Map<String, String>>? activities,
    String? eventDate,
    String? featuredLocation,
    String? searchQuery,
  }) {
    return TravelState(
      selectedTab: selectedTab ?? this.selectedTab,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      locationText: locationText ?? this.locationText,
      bgImageUrl: bgImageUrl ?? this.bgImageUrl,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      searchHint: searchHint ?? this.searchHint,
      destinations: destinations ?? this.destinations,
      eventCards: eventCards ?? this.eventCards,
      activities: activities ?? this.activities,
      eventDate: eventDate ?? this.eventDate,
      featuredLocation: featuredLocation ?? this.featuredLocation,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// ============================================================
// BLOC
// ============================================================

class TravelBloc extends Bloc<TravelEvent, TravelState> {
  TravelBloc() : super(TravelState.initial()) {
    // ==========================================================
    // TAB CHANGE
    // ==========================================================

    on<SelectTabEvent>((event, emit) {
      switch (event.tab) {
      // ======================================================
      // EXPLORE
      // ======================================================

        case TravelTab.explore:
          emit(
            TravelState.initial(),
          );
          break;

      // ======================================================
      // EVENTS
      // ======================================================

        case TravelTab.events:
          emit(
            TravelState.initial().copyWith(
              selectedTab: TravelTab.events,

              title: "global events",
              subtitle: "worth traveling for",

              locationText: "F1 Championship, Barcelona",

              bgImageUrl:
              "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7",

              backgroundColor: Colors.black,

              searchHint: "Search Events",

              eventDate: "October 2026",

              featuredLocation:
              "F1 Championship, Barcelona",
            ),
          );
          break;

      // ======================================================
      // ACTIVITIES
      // ======================================================

        case TravelTab.activities:
          emit(
            TravelState.initial().copyWith(
              selectedTab: TravelTab.activities,

              title: "things to do",
              subtitle: "on your journey",

              locationText: "Barreirinhas, Brasil",

              bgImageUrl:
              "https://images.unsplash.com/photo-1507608869274-d3177c8bb4c7",

              backgroundColor: const Color(0xFFD4E6F1),

              searchHint: "Search Activities",
            ),
          );
          break;
      }
    });

    // ==========================================================
    // COUNTRY SEARCH
    // ==========================================================

    on<SearchCountryEvent>((event, emit) {
      emit(
        state.copyWith(
          searchQuery: event.query,
        ),
      );
    });

    // ==========================================================
    // ACTIVITY SEARCH
    // ==========================================================

    on<SearchActivityEvent>((event, emit) {
      emit(
        state.copyWith(
          searchQuery: event.query,
        ),
      );
    });
  }
}