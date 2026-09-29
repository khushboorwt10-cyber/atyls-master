import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visa_bloc.dart';
import '../event/visa_event.dart';
import '../state/visa_state.dart';
import '../widgets/approval_intelligentcard.dart';
import '../widgets/visa_documentcard.dart';
import '../widgets/visa_infocard.dart';
import '../widgets/visa_pricecard.dart';
import '../widgets/visa_reviews.dart';
import '../widgets/visa_timeline.dart';
import '../widgets/visa_topbar.dart';
import 'camera_per_screen.dart';


class VisaDetailsScreen extends StatefulWidget {
  const VisaDetailsScreen({
    super.key,
  });

  @override
  State<VisaDetailsScreen> createState() =>
      _VisaDetailsScreenState();
}

class _VisaDetailsScreenState
    extends State<VisaDetailsScreen> {
  final ScrollController _scrollController =
  ScrollController();

  final GlobalKey priceKey = GlobalKey();
  final GlobalKey documentsKey = GlobalKey();
  final GlobalKey timelineKey = GlobalKey();
  final GlobalKey approvalKey = GlobalKey();
  final GlobalKey reviewsKey = GlobalKey();

  int selectedTab = 0;

  final List<String> tabs = [
    'Price',
    'Documents',
    'Timeline',
    'Approval intelligence',
    'Reviews',
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      _updateSelectedTab,
    );
  }

  void _updateSelectedTab() {
    if (!mounted) return;

    final keys = [
      priceKey,
      documentsKey,
      timelineKey,
      approvalKey,
      reviewsKey,
    ];

    int current = 0;

    for (int i = 0; i < keys.length; i++) {
      final context =
          keys[i].currentContext;

      if (context == null) continue;

      final box =
      context.findRenderObject() as RenderBox?;

      if (box == null) continue;

      final position =
          box.localToGlobal(Offset.zero).dy;

      if (position <= 120) {
        current = i;
      }
    }

    if (current != selectedTab) {
      setState(() {
        selectedTab = current;
      });
    }
  }

  void _goTo(GlobalKey key) {
    final context = key.currentContext;

    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(
        milliseconds: 550,
      ),
      curve: Curves.easeOutCubic,
      alignment: .08,
    );
  }

  void _selectTab(int index) {
    setState(() {
      selectedTab = index;
    });

    switch (index) {
      case 0:
        _goTo(priceKey);
        break;
      case 1:
        _goTo(documentsKey);
        break;
      case 2:
        _goTo(timelineKey);
        break;
      case 3:
        _goTo(approvalKey);
        break;
      case 4:
        _goTo(reviewsKey);
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(
      _updateSelectedTab,
    );
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisaBloc, VisaState>(
      listener: (context, state) {
        if (state is VisaApplicationStarted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                'Application started for ${state.visa.country}',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor:
        const Color(0xFFF7F7F5),

        body: BlocBuilder<VisaBloc, VisaState>(
          builder: (context, state) {
            if (state is VisaLoading ||
                state is VisaInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }

            if (state is VisaError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is! VisaLoaded) {
              return const SizedBox();
            }

            final visa = state.visa;

            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: VisaTopBar(
                        country: visa.country,
                        flag: visa.flag,
                        category: visa.category,
                      ),
                    ),

                    // STICKY TABS
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _VisaTabsDelegate(
                        tabs: tabs,
                        selectedIndex:
                        selectedTab,
                        onSelected:
                        _selectTab,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        key: priceKey,
                        color: Colors.white,
                        child: VisaPriceCard(
                          visa: visa,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        child: VisaInfoCard(
                          visa: visa,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        key: documentsKey,
                        color: Colors.white,
                        child: VisaDocumentsCard(
                          visa: visa,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        key: timelineKey,
                        color: Colors.white,
                        child: VisaTimeline(
                          visa: visa,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        key: approvalKey,
                        color: Colors.white,
                        child:
                        ApprovalIntelligence(
                          visa: visa,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        key: reviewsKey,
                        color: Colors.white,
                        child: VisaReviews(
                          visa: visa,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 145,
                      ),
                    ),
                  ],
                ),

                // FIXED BOTTOM CTA
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 12,
                  child: SafeArea(
                    top: false,
                    child: Container(
                      height: 86,
                      padding:
                      const EdgeInsets.fromLTRB(
                        22,
                        10,
                        10,
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(44),
                        border: Border.all(
                          color:
                          const Color(0xFFD8D8D8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(.12),
                            blurRadius: 20,
                            offset:
                            const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Visa on 1 Oct, 10:44 pm',
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.verified,
                                      size: 18,
                                      color:
                                      Color(0xFF2436A5),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'On time, ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color:
                                        Color(0xFF2436A5),
                                      ),
                                    ),
                                    const Text(
                                      'or free',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color:
                                        Color(0xFF2436A5),
                                        decoration:
                                        TextDecoration
                                            .underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 10),

                          SizedBox(
                            width: 125,
                            height: 62,
                            child: ElevatedButton(
                              onPressed: () {
                                // 1. Pehle wala bloc event agar chalana hai toh woh rahega
                                context.read<VisaBloc>().add(
                                  CameraPermissionScreen() as VisaEvent,
                                );

                                // 2. Ab CameraPermissionScreen par navigate karne ke liye yeh add karein:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CameraPermissionScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5A56E8),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: const Text(
                                'Start now',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _VisaTabsDelegate
    extends SliverPersistentHeaderDelegate {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  _VisaTabsDelegate({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  double get minExtent => 59;

  @override
  double get maxExtent => 59;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      height: 59,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics:
        const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(
            tabs.length,
                (index) {
              final selected =
                  index == selectedIndex;

              return GestureDetector(
                onTap: () => onSelected(index),
                child: Container(
                  height: 59,
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selected
                            ? const Color(
                          0xFF5652E5,
                        )
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: selected
                            ? Colors.black
                            : const Color(
                          0xFF858585,
                        ),
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(
      covariant _VisaTabsDelegate oldDelegate,
      ) {
    return oldDelegate.selectedIndex !=
        selectedIndex ||
        oldDelegate.tabs != tabs;
  }
}