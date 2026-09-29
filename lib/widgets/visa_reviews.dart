import 'package:flutter/material.dart';

import '../models/visa_model.dart';

class VisaReviews extends StatelessWidget {
  final VisaModel visa;

  const VisaReviews({
    super.key,
    required this.visa,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        30,
        35,
        30,
        0,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            'Traveler Reviews',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 25),

          ...visa.reviews.map(
                (review) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 28,
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor:
                      const Color(0xFFEDEDED),
                      child: Text(
                        review.name[0],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(width: 13),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children:
                            List.generate(
                              review.rating,
                                  (_) => const Icon(
                                Icons.star,
                                size: 15,
                              ),
                            ),
                          ),

                          const SizedBox(height: 7),

                          Text(
                            review.review,
                            style: const TextStyle(
                              fontSize: 13,
                              color:
                              Color(0xFF777777),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}