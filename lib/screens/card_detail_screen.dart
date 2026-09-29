import 'package:atyls/screens/start_now_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/designation_model.dart';
import '../models/visa_model.dart';


class DestinationDetailScreen extends StatefulWidget {
  final DestinationModel destination;

  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath = widget.destination.image;
    final String flagText = widget.destination.flag;
    final String countryName = widget.destination.country;
    final String validity = widget.destination.validDays;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // =========================================
          // 1. BACKGROUND IMAGE
          // =========================================
          Hero(
            tag: 'destination_${widget.destination.id}',
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: const Color(0xFFAED0DF),
                );
              },
            ),
          ),

          // =========================================
          // 2. DARK GRADIENT
          // =========================================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.75),
                ],
              ),
            ),
          ),

          // =========================================
          // 3. MAIN CONTENT
          // =========================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Column(
                children: [
                  // =========================================
                  // TOP BAR
                  // =========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          // Share functionality later
                        },
                        child: const Icon(
                          Icons.ios_share,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // =========================================
                  // FLAG
                  // =========================================
                  Text(
                    flagText,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =========================================
                  // COUNTRY NAME
                  // =========================================
                  Text(
                    '$countryName Visa',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // =========================================
                  // VALIDITY
                  // =========================================
                  Text(
                    'guaranteed in $validity',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC5EBA4),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // =========================================
                  // START NOW CIRCLE
                  // =========================================
                  Center(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Rotating dashed circle
                          RotationTransition(
                            turns: _rotationController,
                            child: CustomPaint(
                              size: const Size(140, 140),
                              painter: DashedCirclePainter(
                                color: Colors.white.withOpacity(0.7),
                                strokeWidth: 1.5,
                                dashLength: 6,
                                dashSpace: 6,
                              ),
                            ),
                          ),

                          // =========================================
                          // START NOW BUTTON
                          // =========================================
                          GestureDetector(
                            onTap: () {
                              // Dynamic country data
                              final visa = VisaModel.dummy(
                                country: widget.destination.country,
                                flag: widget.destination.flag,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreatingApplicationScreen(
                                        visa: visa,
                                      ),
                                ),
                              );
                            },
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Start',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  'Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // =========================================
                  // VIEW MORE INFO
                  // =========================================
                  GestureDetector(
                    onTap: () {
                      // View more info later
                    },
                    child: const Text(
                      'VIEW MORE INFO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// CUSTOM PAINTER - DASHED CIRCLE
// ======================================================

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;

    final Offset center = Offset(
      size.width / 2,
      size.height / 2,
    );

    double angle = 0;

    const double fullCircle = 2 * 3.141592653589793;

    while (angle < fullCircle) {
      final double sweepAngle = dashLength / radius;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        angle,
        sweepAngle,
        false,
        paint,
      );

      angle += (dashLength + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) {
    return false;
  }
}