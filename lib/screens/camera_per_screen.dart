import 'package:flutter/material.dart';

class CameraPermissionScreen extends StatelessWidget {
  const CameraPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===============================
            // TOP BAR (Back, Visa Badge, Home)
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A56E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Visa on 30 Sep, 03:58 PM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A56E8).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Color(0xFF5A56E8),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===============================
            // STEP PROGRESS BAR (Photo -> Passport -> Detail -> Checkout)
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Photo', style: TextStyle(color: Color(0xFF5A56E8), fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('Passport', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                      Text('Detail', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                      Text('Checkout', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStepIndicator(isActive: true, isCompleted: false, icon: Icons.camera_alt),
                      _buildLine(),
                      _buildStepIndicator(isActive: false, isCompleted: false, icon: Icons.badge),
                      _buildLine(),
                      _buildStepIndicator(isActive: false, isCompleted: false, icon: Icons.person),
                      _buildLine(),
                      _buildStepIndicator(isActive: false, isCompleted: false, icon: Icons.check),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===============================
            // SCROLLABLE CONTENT
            // ===============================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CAMERA ICON WITH SPARKLE
                    Stack(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Text(
                            '✨',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // HEADING
                    const Text(
                      'Camera permission\nrequired',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // SUBTITLE
                    const Text(
                      'To auto-capture your selfie, please allow camera access in the prompt on the next screen',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // SECTION TITLE
                    const Text(
                      'WHY WE NEED CAMERA ACCESS:',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 0.8,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // FEATURE LIST ITEMS
                    _buildFeatureItem(
                      icon: Icons.document_scanner_outlined,
                      title: 'Instant Auto-Fill:',
                      description: 'Auto-detects passport numbers, dates, and names so you skip manual typing entirely',
                    ),
                    const Divider(height: 24, color: Color(0xFFEEEEEE), thickness: 1, indent: 45),

                    _buildFeatureItem(
                      icon: Icons.text_snippet_outlined,
                      title: 'Instant Error-Checking:',
                      description: 'Ensures MRZ lines and expiration dates are read accurately without human typos',
                    ),
                    const Divider(height: 24, color: Color(0xFFEEEEEE), thickness: 1, indent: 45),

                    _buildFeatureItem(
                      icon: Icons.lock_outline,
                      title: 'Bank-Grade Encryption:',
                      description: 'Extracted data is instantly encrypted and locked inside your private DocVault',
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // ===============================
            // BOTTOM GRADIENT CONTINUE BUTTON
            // ===============================
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFC4B5FD), // Light Purple
                        Color(0xFFFDE68A), // Light Yellow/Peach gradient tone
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfirmSelfieScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator({required bool isActive, required bool isCompleted, required IconData icon}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5A56E8).withOpacity(0.15) : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? const Color(0xFF5A56E8) : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Icon(
        icon,
        size: 14,
        color: isActive ? const Color(0xFF5A56E8) : Colors.grey,
      ),
    );
  }

  Widget _buildLine() {
    return Expanded(
      child: Container(
        height: 1.5,
        color: Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String title, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF5A56E8).withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF5A56E8), size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ConfirmSelfieScreen extends StatelessWidget {
  const ConfirmSelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===============================
            // TOP BAR (Back, Visa Badge, Home)
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A56E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Visa on 30 Sep, 03:58 PM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A56E8).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Color(0xFF5A56E8),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===============================
            // STEP PROGRESS BAR
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Photo', style: TextStyle(color: Color(0xFF5A56E8), fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('Passport', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                      Text('Detail', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                      Text('Checkout', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStepIndicator(isActive: true, isCompleted: false, icon: Icons.camera_alt),
                      _buildLine(),
                      _buildStepIndicator(isActive: false, isCompleted: false, icon: Icons.badge),
                      _buildLine(),
                      _buildStepIndicator(isActive: false, isCompleted: false, icon: Icons.person),
                      _buildLine(),
                      _buildStepIndicator(isActive: false, isCompleted: false, icon: Icons.check),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===============================
            // REQUIREMENTS NOTIFICATION BANNER
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Image will be edited to fit government requirements',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ===============================
            // SCROLLABLE CONTENT (CARD & QUALITY CHECKS)
            // ===============================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      // PROFILE/SELFIE ICON WITH DASHED BORDER EFFECT
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF5A56E8),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_outline,
                            size: 45,
                            color: Color(0xFF5A56E8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // TITLE
                      const Text(
                        'Performing Quality Checks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // QUALITY CHECK ITEMS LIST
                      _buildCheckItem(
                        icon: Icons.hourglass_empty_rounded,
                        iconColor: Colors.orange,
                        title: 'Applying final touches',
                        isDone: false,
                      ),
                      const SizedBox(height: 16),
                      _buildCheckItem(
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                        title: 'Matching official standards',
                        isDone: true,
                      ),
                      const SizedBox(height: 16),
                      _buildCheckItem(
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                        title: 'Scanning facial features',
                        isDone: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ===============================
            // BOTTOM ACTION BUTTONS
            // ===============================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // CONFIRM SELFIE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // Agle step ka navigation yahan lagayein
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A56E8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Confirm Selfie',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // RETAKE SELFIE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF5A56E8), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Retake Selfie',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A56E8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator({required bool isActive, required bool isCompleted, required IconData icon}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5A56E8).withOpacity(0.15) : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? const Color(0xFF5A56E8) : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Icon(
        icon,
        size: 14,
        color: isActive ? const Color(0xFF5A56E8) : Colors.grey,
      ),
    );
  }

  Widget _buildLine() {
    return Expanded(
      child: Container(
        height: 1.5,
        color: Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildCheckItem({required IconData icon, required Color iconColor, required String title, required bool isDone}) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDone ? Colors.black87 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}