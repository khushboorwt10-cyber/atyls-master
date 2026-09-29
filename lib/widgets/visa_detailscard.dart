import 'package:atyls/screens/camera_per_screen.dart';
import 'package:atyls/widgets/visa_documentcard.dart';
import 'package:atyls/widgets/visa_infocard.dart';
import 'package:atyls/widgets/visa_pricecard.dart';
import 'package:atyls/widgets/visa_reviews.dart';
import 'package:atyls/widgets/visa_timeline.dart';
import 'package:atyls/widgets/visa_topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visa_bloc.dart';
import '../event/visa_event.dart';
import '../state/visa_state.dart';
import 'approval_intelligentcard.dart';




class VisaDetailsScreen extends StatelessWidget {
  const VisaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisaBloc, VisaState>(
      listener: (context, state) {
        if (state is VisaApplicationStarted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Application started for ${state.visa.country}',
              ),
            ),
          );
        }
      },

      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F5),

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

            if (state is VisaLoaded) {
              final visa = state.visa;

              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: VisaTopBar(
                          country: visa.country, flag: '', category: '',
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      ),

                      SliverToBoxAdapter(
                        child: VisaPriceCard(
                          visa: visa,
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 14),
                      ),

                      SliverToBoxAdapter(
                        child: VisaInfoCard(
                          visa: visa,
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 18),
                      ),

                      SliverToBoxAdapter(
                        child: VisaDocumentsCard(
                          visa: visa,
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 18),
                      ),

                      SliverToBoxAdapter(
                        child: VisaTimeline(
                          visa: visa,
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 18),
                      ),

                      SliverToBoxAdapter(
                        child: ApprovalIntelligence(
                          visa: visa,
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 18),
                      ),

                      SliverToBoxAdapter(
                        child: VisaReviews(
                          visa: visa,
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 130),
                      ),
                    ],
                  ),

                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 18,

                    child: SafeArea(
                      top: false,

                      child: SizedBox(
                        height: 56,

                        child: ElevatedButton(
                          onPressed: () {
                            // Yahan par CameraPermissionScreen par navigate karne ke liye code lagaya hai
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CameraPermissionScreen(),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: Text(
                            'Start ${visa.country} Visa Application',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}