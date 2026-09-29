import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visa_bloc.dart';
import '../event/visa_event.dart';
import '../models/visa_model.dart';
import '../widgets/visa_detailscard.dart';


class CreatingApplicationScreen extends StatefulWidget {
  final VisaModel visa;

  const CreatingApplicationScreen({
    super.key,
    required this.visa,
  });

  @override
  State<CreatingApplicationScreen> createState() =>
      _CreatingApplicationScreenState();
}

class _CreatingApplicationScreenState
    extends State<CreatingApplicationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _navigationTimer = Timer(
      const Duration(seconds: 4),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => VisaBloc()
                ..add(
                  LoadVisaDetails(widget.visa),
                ),
              child: const VisaDetailsScreen(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.home_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(
                height: 220,
                width: 200,

                child: AnimatedBuilder(
                  animation: _controller,

                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,

                      children: [
                        Transform.translate(
                          offset: Offset(
                            -20 * _controller.value,
                            -15 * _controller.value,
                          ),

                          child: Transform.rotate(
                            angle: -0.15,

                            child: _buildCardItem(
                              title: widget.visa.country,
                              opacity: 0.5,
                            ),
                          ),
                        ),

                        Transform.translate(
                          offset: Offset(
                            -10 * _controller.value,
                            -8 * _controller.value,
                          ),

                          child: Transform.rotate(
                            angle: -0.08,

                            child: _buildCardItem(
                              title: widget.visa.visaType,
                              opacity: 0.75,
                            ),
                          ),
                        ),

                        _buildCardItem(
                          title: widget.visa.country,
                          opacity: 1,
                          isMain: true,
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Creating Application',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'serif',
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Just a moment! We\'re getting everything\n'
                    'ready for ${widget.visa.country}.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required String title,
    required double opacity,
    bool isMain = false,
  }) {
    return Opacity(
      opacity: opacity,

      child: Container(
        width: 130,
        height: 160,
        padding: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Center(
                  child: Text(
                    widget.visa.flag,
                    style: const TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,

              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isMain
                    ? Colors.black
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}