import 'package:atyls/screens/activities_detail_screen.dart';
import 'package:atyls/screens/card_detail_screen.dart';
import 'package:atyls/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/designation_bloc.dart';
import '../models/designation_model.dart';
import '../widgets/visa_detailscard.dart';
class TravelHomeScreen extends StatelessWidget {
  const TravelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TravelBloc(),
      child: const _TravelHomeView(),
    );
  }
}

class _TravelHomeView extends StatefulWidget {
  const _TravelHomeView();

  @override
  State<_TravelHomeView> createState() => _TravelHomeViewState();
}

class _TravelHomeViewState extends State<_TravelHomeView> {
  // Bottom navigation index track karne ke liye (0 for Home, 1 for Profile)
  int selectedBottomNav = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TravelBloc, TravelState>(
      builder: (context, state) {
        final bool isEvents =
            state.selectedTab == TravelTab.events;

        final bool isExplore =
            state.selectedTab == TravelTab.explore;

        final bool isActivities =
            state.selectedTab == TravelTab.activities;

        return Scaffold(
          backgroundColor: state.backgroundColor,
          extendBody: true,

          body: Stack(
            children: [
              // =====================================================
              // BACKGROUND
              // =====================================================

              if (!isEvents)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height:
                  MediaQuery
                      .of(context)
                      .size
                      .height * 0.46,
                  child: Image.network(
                    state.bgImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: state.backgroundColor,
                      );
                    },
                  ),
                ),

              if (!isEvents)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height:
                  MediaQuery
                      .of(context)
                      .size
                      .height * 0.46,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.25),
                          Colors.transparent,
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                ),

              // =====================================================
              // EVENTS BACKGROUND
              // =====================================================

              if (isEvents)
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                  ),
                ),

              // =====================================================
              // MAIN CONTENT / PROFILE SCREEN SWITCH
              // =====================================================

              selectedBottomNav == 1
                  ? const ProfileScreen() // Jab profile par tap ho
                  : SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // =================================================
                    // TOP TABS
                    // =================================================

                    _buildTopTabs(
                      context,
                      state,
                      isEvents,
                    ),

                    const SizedBox(height: 24),

                    // =================================================
                    // CONTENT
                    // =================================================

                    Expanded(
                      child: SingleChildScrollView(
                        physics:
                        const BouncingScrollPhysics(),
                        padding:
                        const EdgeInsets.only(
                          bottom: 120,
                        ),
                        child: Column(
                          children: [
                            // =========================================
                            // EXPLORE
                            // =========================================

                            if (isExplore)
                              _buildExploreContent(
                                context,
                                state,
                              ),

                            // =========================================
                            // EVENTS
                            // =========================================

                            if (isEvents)
                              _buildEventsContent(
                                context,
                                state,
                              ),

                            // =========================================
                            // ACTIVITIES
                            // =========================================

                            if (isActivities)
                              _buildActivitiesContent(
                                context,
                                state,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================================
              // BOTTOM NAV (Updated with Home & Profile Avatar)
              // =====================================================

              Positioned(
                left: 20,
                right: 20,
                bottom: 18,
                child: _buildBottomNav(),
              ),
            ],
          ),
        );
      },
    );
  }

  // ===============================================================
  // TOP TABS
  // ===============================================================

  Widget _buildTopTabs(BuildContext context,
      TravelState state,
      bool isDark,) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tabItem(
          context: context,
          tab: TravelTab.explore,
          label: "Explore",
          icon: Icons.card_travel,
          isSelected:
          state.selectedTab == TravelTab.explore,
          isDark: isDark,
        ),

        const SizedBox(width: 18),

        _tabItem(
          context: context,
          tab: TravelTab.events,
          label: "Events",
          icon: Icons.confirmation_number_outlined,
          isSelected:
          state.selectedTab == TravelTab.events,
          isDark: isDark,
        ),

        const SizedBox(width: 18),

        _tabItem(
          context: context,
          tab: TravelTab.activities,
          label: "Activities",
          icon: Icons.attractions,
          isSelected:
          state.selectedTab == TravelTab.activities,
          isDark: isDark,
        ),
      ],
    );
  }

  // ===============================================================
  // TAB ITEM
  // ===============================================================

  Widget _tabItem({
    required BuildContext context,
    required TravelTab tab,
    required String label,
    required IconData icon,
    required bool isSelected,
    required bool isDark,
  }) {
    final Color activeColor =
    isDark ? Colors.white : Colors.black;

    final Color inactiveColor =
    isDark ? Colors.white54 : Colors.black54;

    return GestureDetector(
      onTap: () {
        context
            .read<TravelBloc>()
            .add(SelectTabEvent(tab));
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration:
            const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? activeColor
                  : inactiveColor.withOpacity(0.16),
            ),
            child: Icon(
              icon,
              size: 21,
              color: isSelected
                  ? (isDark
                  ? Colors.black
                  : Colors.white)
                  : activeColor,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? activeColor
                  : inactiveColor,
              fontSize: 12,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),

          if (isSelected)
            Container(
              margin:
              const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: activeColor,
            ),
        ],
      ),
    );
  }

  // ===============================================================
  // EXPLORE
  // ===============================================================

  // ===============================================================
  // EXPLORE
  // ===============================================================

  Widget _buildExploreContent(BuildContext context,
      TravelState state,) {
    return Column(
      children: [
        const Text(
          "where do you plan\nto travel next",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "serif",
            fontSize: 28,
            height: 1.15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 20),

        // SEARCH
        Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildSearchBar(
                  context,
                  "Search Country",
                  TravelTab.explore,
                ),
              ),

              const SizedBox(width: 10),

              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // LOCATION
        _buildLocation(
          state.locationText,
        ),

        const SizedBox(height: 16),

        // WHITE CARD AREA
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: state.destinations.isEmpty
              ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                "No destinations found",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (state.destinations.length / 2).ceil(),
            // 2 items per row
            itemBuilder: (context, rowIndex) {
              final int firstIndex = rowIndex * 2;
              final int secondIndex = firstIndex + 1;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    // First Card in Row
                    Expanded(
                      child: SizedBox(
                        height: 310,
                        child: _buildDestinationCard(
                          destination: state.destinations[firstIndex],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DestinationDetailScreen(
                                      destination: state
                                          .destinations[firstIndex],
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: secondIndex < state.destinations.length
                          ? SizedBox(
                        height: 310,
                        child: _buildDestinationCard(
                          destination: state.destinations[secondIndex],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DestinationDetailScreen(
                                      destination: state
                                          .destinations[secondIndex],
                                    ),
                              ),
                            );
                          },
                        ),
                      )
                          : const SizedBox(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // SEARCH BAR

  Widget _buildSearchBar(BuildContext context,
      String hint,
      TravelTab tab,) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.06),
            blurRadius: 10,
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          if (tab == TravelTab.explore) {
            context
                .read<TravelBloc>()
                .add(
              SearchCountryEvent(value),
            );
          } else {
            context
                .read<TravelBloc>()
                .add(
              SearchActivityEvent(value),
            );
          }
        },
        decoration:
        InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF68717A),
          ),
          hintText: hint,
          hintStyle:
          const TextStyle(
            color: Color(0xFF68717A),
            fontSize: 14,
          ),
          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 13,
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // LOCATION
  // ===============================================================

  Widget _buildLocation(String location,) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color:
        Colors.black.withOpacity(0.35),
        borderRadius:
        BorderRadius.circular(22),
        border: Border.all(
          color:
          Colors.white.withOpacity(0.55),
        ),
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 15,
          ),

          const SizedBox(width: 5),

          Text(
            location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight:
              FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // DESTINATION CARD
  // ===============================================================
  Widget _buildDestinationCard({
    required DestinationModel destination,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // IMAGE WITH ERROR BUILDER
                    Image.network(
                      destination.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                              Icons.image_not_supported, color: Colors.grey),
                        );
                      },
                    ),

                    // GRADIENT OVERLAY
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),

                    // CARD TEXT & DETAILS
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            destination.flag,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            destination.country.toUpperCase(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'VALID',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '90 DAYS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Guaranteed By',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '25 Sep 2026, 04:38 PM',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // EVENTS
  // ===============================================================

  Widget _buildEventsContent(BuildContext context,
      TravelState state,) {
    return Column(
      children: [
        const Padding(
          padding:
          EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            "global events\nworth traveling for",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "serif",
              fontSize: 28,
              height: 1.15,
              fontWeight:
              FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 22),

        // FILTER CHIPS
        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection:
            Axis.horizontal,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            children: [
              _buildFilterChip(
                "All Events",
                selected: true,
              ),

              const SizedBox(width: 8),

              _buildFilterChip(
                "Music",
                icon:
                Icons.music_note,
                iconColor:
                Colors.greenAccent,
              ),

              const SizedBox(width: 8),

              _buildFilterChip(
                "Sports",
                icon:
                Icons.sports_motorsports,
                iconColor:
                Colors.pinkAccent,
              ),

              const SizedBox(width: 8),

              _buildFilterChip(
                "Art & Culture",
                icon:
                Icons.palette,
                iconColor:
                Colors.purpleAccent,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // FEATURED IMAGE
        Container(
          margin:
          const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          height: 190,
          decoration:
          BoxDecoration(
            borderRadius:
            BorderRadius.circular(24),
            image:
            DecorationImage(
              image: NetworkImage(
                state.bgImageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration:
                  BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                      24,
                    ),
                    gradient:
                    LinearGradient(
                      begin:
                      Alignment.topCenter,
                      end:
                      Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black
                            .withOpacity(
                          0.75,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: Center(
                  child:
                  _buildLocation(
                    state
                        .featuredLocation,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // WHITE EVENT AREA
        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            30,
          ),
          decoration:
          const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              // DATE
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    state.eventDate,
                    style:
                    const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 7),

                  Container(
                    height: 4,
                    width: 4,
                    decoration:
                    const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 7),

                  const Text(
                    "14",
                    style:
                    TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // EVENT CARDS
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                    _buildEventCard(
                      state
                          .eventCards[0],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child:
                    _buildEventCard(
                      state
                          .eventCards[1],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // EVENT FILTER
  // ===============================================================

  Widget _buildFilterChip(String title, {
    IconData? icon,
    Color? iconColor,
    bool selected = false,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white
            : Colors.grey.shade900,
        borderRadius:
        BorderRadius.circular(25),
        border: Border.all(
          color: selected
              ? Colors.white
              : Colors.grey.shade800,
        ),
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color:
              iconColor ?? Colors.white,
              size: 15,
            ),
            const SizedBox(width: 5),
          ],

          Text(
            title,
            style: TextStyle(
              color: selected
                  ? Colors.black
                  : Colors.white,
              fontSize: 12,
              fontWeight:
              FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // EVENT CARD
  // ===============================================================

  Widget _buildEventCard(Map<String, String> card,) {
    return Container(
      height: 270,
      decoration:
      BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),
        image:
        DecorationImage(
          image:
          NetworkImage(
            card["image"]!,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding:
        const EdgeInsets.all(12),
        decoration:
        BoxDecoration(
          borderRadius:
          BorderRadius.circular(20),
          gradient:
          LinearGradient(
            begin:
            Alignment.topCenter,
            end:
            Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black
                  .withOpacity(0.85),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Align(
              alignment:
              Alignment.topRight,
              child: Container(
                padding:
                const EdgeInsets.all(5),
                decoration:
                const BoxDecoration(
                  color: Colors.white,
                  shape:
                  BoxShape.circle,
                ),
                child: Text(
                  card["countryFlag"] ??
                      "🇮🇩",
                  style:
                  const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  card["visaText"] ??
                      "",
                  style:
                  const TextStyle(
                    color:
                    Colors.white70,
                    fontSize: 9,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  card["eventTitle"] ??
                      "",
                  maxLines: 3,
                  overflow:
                  TextOverflow.ellipsis,
                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight:
                    FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration:
                  BoxDecoration(
                    color: Colors.black
                        .withOpacity(
                      0.45,
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(
                      10,
                    ),
                  ),
                  child: Text(
                    card["visaInfo"] ??
                        "",
                    style:
                    const TextStyle(
                      color:
                      Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // ACTIVITIES
  // ===============================================================

  Widget _buildActivitiesContent(BuildContext context,
      TravelState state,) {
    return Column(
      children: [
        const Text(
          "things to do\non your journey",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "serif",
            fontSize: 28,
            height: 1.15,
            fontWeight:
            FontWeight.w700,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: _buildSearchBar(
            context,
            "Search Activities",
            TravelTab.activities,
          ),
        ),

        const SizedBox(height: 18),

        _buildLocation(
          state.locationText,
        ),

        const SizedBox(height: 18),

        // WHITE ACTIVITIES AREA
        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            30,
          ),
          decoration:
          const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              ...state.activities.map(
                    (activity) {
                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 16,
                    ),
                    child:
                    _buildActivityCard(
                      activity,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityDetailsScreen(), // Yahan apni target screen ka naam likhein
                          ),
                        );
                      },

                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // ACTIVITY CARD
  // ===============================================================

  Widget _buildActivityCard(Map<String, String> activity, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(
            image: NetworkImage(
              activity["image"]!,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getActivityIcon(
                    activity["icon"],
                  ),
                  color: Colors.black,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity["title"] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      activity["subtitle"] ?? "",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ===============================================================
  // ACTIVITY ICON
  // ===============================================================

  IconData _getActivityIcon(
      String? icon,
      ) {
    switch (icon) {
      case "nature":
        return Icons
            .landscape_outlined;

      case "culture":
        return Icons
            .museum_outlined;

      case "explore":
      default:
        return Icons
            .explore_outlined;
    }
  }

  // ===============================================================
  // BOTTOM NAV

  Widget _buildBottomNav() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // HOME BUTTON (Index 0)
          GestureDetector(
            onTap: () {
              setState(() {
                selectedBottomNav = 0;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: selectedBottomNav == 0 ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: selectedBottomNav == 0 ? Colors.white : Colors.black,
                    size: 18,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    "Home",
                    style: TextStyle(
                      color: selectedBottomNav == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // PROFILE AVATAR (Index 1)
          GestureDetector(
            onTap: () {
              setState(() {
                selectedBottomNav = 1;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedBottomNav == 1 ? const Color(0xFF5A56E8) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 17,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/100",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}