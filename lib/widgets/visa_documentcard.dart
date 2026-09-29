import 'package:flutter/material.dart';
import '../models/visa_model.dart';

class VisaDocumentsCard extends StatelessWidget {
  final VisaModel visa;

  const VisaDocumentsCard({
    super.key,
    required this.visa,
  });

  @override
  Widget build(BuildContext context) {
    return _section(
      title: 'Documents Required',

      child: Column(
        children: visa.documents.map(
              (document) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),

              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,

                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.check,
                      size: 16,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      document,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
      ),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }
}