class VisaModel {
  final String country;
  final String flag;
  final String city;
  final String category;
  final String visaType;

  final String processingTime;
  final String validity;
  final String entries;

  final double governmentFees;
  final double serviceFees;

  final List<String> documents;

  final List<VisaTimelineStep> timeline;

  final int approvalPercentage;

  final List<VisaReview> reviews;

  const VisaModel({
    required this.country,
    required this.flag,
    required this.city,
    required this.category,
    required this.visaType,
    required this.processingTime,
    required this.validity,
    required this.entries,
    required this.governmentFees,
    required this.serviceFees,
    required this.documents,
    required this.timeline,
    required this.approvalPercentage,
    required this.reviews,
  });

  double get totalFees => governmentFees + serviceFees;

  factory VisaModel.dummy({
    required String country,
    required String flag,
  }) {
    return VisaModel(
      country: country,
      flag: flag,
      city: country,
      category: 'Tourism',
      visaType: 'Tourist Visa',
      processingTime: '5 - 7 Working Days',
      validity: '90 Days',
      entries: 'Single Entry',
      governmentFees: 3000,
      serviceFees: 1416,
      documents: const [
        'Valid Passport',
        'Recent Passport Size Photograph',
        'Return Flight Ticket',
        'Hotel Booking',
        'Bank Statement',
        'Travel Insurance',
      ],
      timeline: const [
        VisaTimelineStep(
          title: 'Application Submitted',
          subtitle: 'Your application is submitted',
          completed: true,
        ),
        VisaTimelineStep(
          title: 'Document Verification',
          subtitle: 'Documents are being verified',
          completed: true,
        ),
        VisaTimelineStep(
          title: 'Embassy Processing',
          subtitle: 'Application is under review',
          completed: false,
        ),
        VisaTimelineStep(
          title: 'Visa Decision',
          subtitle: 'Final decision will be updated',
          completed: false,
        ),
      ],
      approvalPercentage: 92,
      reviews: const [
        VisaReview(
          name: 'Rahul Sharma',
          rating: 5,
          review:
          'The application process was simple and everything was explained clearly.',
        ),
        VisaReview(
          name: 'Priya Singh',
          rating: 5,
          review:
          'Very smooth experience. Documents and processing time were clearly explained.',
        ),
      ],
    );
  }
}

class VisaTimelineStep {
  final String title;
  final String subtitle;
  final bool completed;

  const VisaTimelineStep({
    required this.title,
    required this.subtitle,
    required this.completed,
  });
}

class VisaReview {
  final String name;
  final int rating;
  final String review;

  const VisaReview({
    required this.name,
    required this.rating,
    required this.review,
  });
}