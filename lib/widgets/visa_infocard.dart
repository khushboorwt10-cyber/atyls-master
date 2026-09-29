import 'package:flutter/material.dart';

import '../models/visa_model.dart';

class VisaInfoCard extends StatelessWidget {
  final VisaModel visa;

  const VisaInfoCard({
    super.key,
    required this.visa,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Row(
        children: [
          Expanded(
            child: _item(
              Icons.schedule_rounded,
              'Processing',
              visa.processingTime,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _item(
              Icons.calendar_month_outlined,
              'Validity',
              visa.validity,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _item(
              Icons.confirmation_number_outlined,
              'Entries',
              visa.entries,
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            size: 20,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}