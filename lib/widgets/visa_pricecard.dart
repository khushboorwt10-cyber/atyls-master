import 'package:flutter/material.dart';

import '../models/visa_model.dart';

class VisaPriceCard extends StatefulWidget {
  final VisaModel visa;

  const VisaPriceCard({
    super.key,
    required this.visa,
  });

  @override
  State<VisaPriceCard> createState() =>
      _VisaPriceCardState();
}

class _VisaPriceCardState
    extends State<VisaPriceCard> {
  int travellers = 1;

  @override
  Widget build(BuildContext context) {
    final visa = widget.visa;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        30,
        34,
        30,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General info',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 31,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 35),

          Row(
            children: [
              Expanded(
                child: _infoItem(
                  'Visa process',
                  'Digital',
                ),
              ),
              Expanded(
                child: _infoItem(
                  'Number of entries',
                  widget.visa.entries
                      .replaceAll(' Entry', ''),
                ),
              ),
            ],
          ),

          const SizedBox(height: 34),

          const Text(
            'Entry period',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              const Text(
                "01 OCT '26",
                style: TextStyle(
                  color: Color(0xFF858585),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: CustomPaint(
                    size: const Size(
                      double.infinity,
                      10,
                    ),
                    painter: _DottedPainter(),
                  ),
                ),
              ),

              const Text(
                "29 DEC '26",
                style: TextStyle(
                  color: Color(0xFF858585),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF5B55E8),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xFF4340C9),
                    ),
                  ),
                ),

                Positioned(
                  left: 42,
                  top: 0,
                  bottom: 0,
                  width: 105,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF5B55E8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              const Text(
                'Enter ',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                ),
              ),
              const Text(
                '1 Oct',
                style: TextStyle(
                  color: Color(0xFF2635A9),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Text(
                'Return ',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                ),
              ),
              const Text(
                '30 Oct',
                style: TextStyle(
                  color: Color(0xFF2635A9),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 75),

          const Text(
            'Price details',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 31,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(34),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 25,
                    ),
                    const SizedBox(width: 18),
                    const Expanded(
                      child: Text(
                        'Travellers',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _counterButton(
                      Icons.remove,
                          () {
                        if (travellers > 1) {
                          setState(() {
                            travellers--;
                          });
                        }
                      },
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Text(
                        '$travellers',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _counterButton(
                      Icons.add,
                          () {
                        setState(() {
                          travellers++;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.fromLTRB(
                    22,
                    24,
                    22,
                    22,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(27),
                  ),
                  child: Column(
                    children: [
                      _priceRow(
                        icon:
                        Icons.account_balance_outlined,
                        title: 'Government Fees',
                        amount:
                        '₹${visa.governmentFees.toStringAsFixed(0)}',
                        underline: true,
                      ),

                      const SizedBox(height: 24),

                      _priceRow(
                        icon: Icons.verified_outlined,
                        title: 'Atlys Fees',
                        amount:
                        '₹${visa.serviceFees.toStringAsFixed(0)}',
                        iconColor:
                        const Color(0xFF5B55E8),
                        underline: true,
                      ),

                      const SizedBox(height: 22),

                      const Divider(
                        height: 1,
                      ),

                      const SizedBox(height: 18),

                      _priceRow(
                        icon:
                        Icons.receipt_long_outlined,
                        title: 'Total Amount',
                        amount:
                        '₹${visa.totalFees.toStringAsFixed(0)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(25),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Cancellation Policy',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(
      String title,
      String value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF858585),
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _counterButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFD0D0D0),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: const Color(0xFF555555),
        ),
      ),
    );
  }

  Widget _priceRow({
    required IconData icon,
    required String title,
    required String amount,
    Color iconColor = Colors.black,
    bool underline = false,
    bool bold = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: iconColor,
        ),
        const SizedBox(width: 17),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold
                  ? FontWeight.w700
                  : FontWeight.w500,
              decoration: underline
                  ? TextDecoration.underline
                  : null,
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: bold
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DottedPainter extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final paint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..strokeWidth = 1.5;

    double x = 0;

    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + 4, size.height / 2),
        paint,
      );
      x += 8;
    }
  }

  @override
  bool shouldRepaint(
      CustomPainter oldDelegate,
      ) {
    return false;
  }
}