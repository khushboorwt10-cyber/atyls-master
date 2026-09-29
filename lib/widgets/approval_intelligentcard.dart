import 'package:flutter/material.dart';

import '../models/visa_model.dart';

class ApprovalIntelligence extends StatelessWidget {
  final VisaModel visa;

  const ApprovalIntelligence({
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
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFFF2EEE7),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              'Approval Intelligence',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child:
                        CircularProgressIndicator(
                          value:
                          visa.approvalPercentage /
                              100,
                          strokeWidth: 8,
                          backgroundColor:
                          Colors.white,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${visa.approvalPercentage}%',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 22),

                const Expanded(
                  child: Text(
                    'Applications with complete documents generally move through the process more smoothly.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
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
}