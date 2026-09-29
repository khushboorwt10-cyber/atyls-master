import 'package:flutter/material.dart';

import '../models/visa_model.dart';

class VisaTimeline extends StatelessWidget {
  final VisaModel visa;

  const VisaTimeline({
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
            'Visa Process',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 30),

          ...List.generate(
            visa.timeline.length,
                (index) {
              final step =
              visa.timeline[index];

              final isLast =
                  index == visa.timeline.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: step.completed
                                ? Colors.black
                                : const Color(0xFFE9E9E9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step.completed
                                ? Icons.check
                                : Icons.circle,
                            size: 14,
                            color: step.completed
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 1,
                              color:
                              const Color(0xFFD5D5D5),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(
                          bottom: 28,
                          top: 3,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style:
                              const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              step.subtitle,
                              style: const TextStyle(
                                fontSize: 13,
                                color:
                                Color(0xFF777777),
                              ),
                            ),
                          ],
                        ),
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