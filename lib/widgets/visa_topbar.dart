import 'package:flutter/material.dart';

class VisaTopBar extends StatelessWidget {
  final String country;
  final String flag;
  final String category;
  final VoidCallback? onBack;

  const VisaTopBar({
    super.key,
    required this.country,
    required this.flag,
    required this.category,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 315,
      child: Stack(
        children: [
          // Top visual area
          Container(
            height: 315,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF70A6B5),
                  Color(0xFFC8D7D8),
                ],
              ),
            ),
          ),

          // Back
          Positioned(
            top: 52,
            left: 18,
            child: _circleButton(
              icon: Icons.arrow_back_ios_new,
              onTap: onBack ??
                      () {
                    Navigator.pop(context);
                  },
            ),
          ),

          // Share
          Positioned(
            top: 52,
            right: 18,
            child: _circleButton(
              icon: Icons.ios_share_outlined,
              onTap: () {},
            ),
          ),

          // Bottom white sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 155,
              padding: const EdgeInsets.fromLTRB(
                28,
                28,
                28,
                20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(34),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flag,
                    style: const TextStyle(
                      fontSize: 31,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$country Visa',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'serif',
                              ),
                            ),
                            const TextSpan(
                              text: '  •  ',
                              style: TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: category,
                              style: const TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 17,
                                fontFamily: 'serif',
                                decoration:
                                TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 12,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}