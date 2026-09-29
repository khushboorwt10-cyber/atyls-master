import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/activitie_bloc.dart';


class ActivityDetailsScreen extends StatelessWidget {
  const ActivityDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityDetailsBloc()..add(FetchActivityDetailsEvent("1")),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ActivityDetailsBloc, ActivityDetailsState>(
          builder: (context, state) {
            if (state is ActivityLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ActivityErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is ActivityLoadedState) {
              final data = state.data;
              return Stack(
                children: [
                  // Scrollable Area
                  CustomScrollView(
                    slivers: [
                      // Fullscreen Hero Image Header
                      SliverAppBar(
                        expandedHeight: MediaQuery.of(context).size.height * 0.58,
                        pinned: true,
                        backgroundColor: Colors.black,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                data.images[0],
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                      Colors.black87,
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 20,
                                right: 20,
                                child: Column(
                                  children: [
                                    Text(
                                      data.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Serif',
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        _headerMetric("Rating", "★ ${data.rating}"),
                                        _headerMetric("Reviewed by", "👥 ${data.reviewsCount}"),
                                        _headerMetric("From", "₹${data.price}"),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    // Pagination dots
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _dot(true),
                                        _dot(false),
                                        _dot(false),
                                        _dot(false),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Curved Content Container
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              // Timing Pill Button
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(color: const Color(0xFFA5D6A7)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today, color: Colors.green),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.operatingHours,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              "click to check operating hours",
                                              style: TextStyle(color: Colors.grey, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios, size: 16),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),
                              const Center(
                                child: Text(
                                  "MEETING POINT",
                                  style: TextStyle(
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),

                              // Map View Block
                              _buildMapCard(data),

                              const SizedBox(height: 30),

                              // Sticky Section Tabs (Highlights, Included, etc.)
                              _buildSectionTabs(context, state.selectedTabIndex),

                              const SizedBox(height: 20),

                              // Highlights Section View
                              _buildHighlightsSection(data),

                              const SizedBox(height: 30),

                              // What's Included Section
                              _buildIncludedSection(data),

                              const SizedBox(height: 30),

                              // Similar Experiences List Section
                              _buildSimilarExperiences(data),

                              const SizedBox(height: 100), // Spacing for bottom bar
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  // Bottom Action Overlay Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottomBookBar(data.price),
                  )
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _headerMetric(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  Widget _dot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 18 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white38,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  // Map Card UI
  Widget _buildMapCard(ActivityDetailsModel data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
        image: const DecorationImage(
          image: NetworkImage("https://maps.googleapis.com/maps/api/staticmap?center=25.2048,55.2708&zoom=12&size=600x300&sensor=false"), // Dynamic Map image
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.circle, color: Colors.white, size: 8),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    data.locationTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Serif'),
                  ),
                  Text(
                    data.locationSubtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.map_outlined, size: 16),
                        SizedBox(width: 6),
                        Text("Get Directions", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Section Tabs
  Widget _buildSectionTabs(BuildContext context, int activeIndex) {
    final tabs = ["Quick actions", "Highlights", "Included", "Reviews", "General info"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = activeIndex == index;
          return GestureDetector(
            onTap: () {
              BlocProvider.of<ActivityDetailsBloc>(context).add(ChangeTabEvent(index));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 30,
                      color: Colors.indigo,
                    )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Highlights Section
  Widget _buildHighlightsSection(ActivityDetailsModel data) {
    return Column(
      children: [
        const Text(
          "Highlights",
          style: TextStyle(fontSize: 22, fontFamily: 'Serif', fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: data.highlightsImages.length,
            controller: PageController(viewportFraction: 0.75),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(data.highlightsImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            data.highlightText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87, height: 1.4, fontSize: 13),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Read more", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  // Included Section
  Widget _buildIncludedSection(ActivityDetailsModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text(
            "What's Included",
            style: TextStyle(fontSize: 22, fontFamily: 'Serif', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Column(
            children: data.whatsIncluded
                .map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.blueAccent, size: 20),
                  const SizedBox(width: 12),
                  Text(item, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // Similar Experiences
  Widget _buildSimilarExperiences(ActivityDetailsModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "You may also like",
            style: TextStyle(fontSize: 22, fontFamily: 'Serif', fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: data.similarExperiences.length,
          itemBuilder: (context, index) {
            final item = data.similarExperiences[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item["image"]!,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Serif'),
                        ),
                        const SizedBox(height: 6),
                        Text("★ ${item['rating']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        const SizedBox(height: 6),
                        Text(
                          "starting from ₹${item['price']} >",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Bottom Fixed Bar
  Widget _buildBottomBookBar(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("STARTING FROM", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text("₹$price / person", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text("Book now", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}