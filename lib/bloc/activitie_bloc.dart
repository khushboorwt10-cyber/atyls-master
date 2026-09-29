import 'package:flutter_bloc/flutter_bloc.dart';

// Activity Model Data Class
class ActivityDetailsModel {
  final String title;
  final double rating;
  final int reviewsCount;
  final String price;
  final String operatingHours;
  final String locationTitle;
  final String locationSubtitle;
  final List<String> images;
  final List<String> highlightsImages;
  final String highlightText;
  final List<String> whatsIncluded;
  final List<Map<String, String>> similarExperiences;

  ActivityDetailsModel({
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.operatingHours,
    required this.locationTitle,
    required this.locationSubtitle,
    required this.images,
    required this.highlightsImages,
    required this.highlightText,
    required this.whatsIncluded,
    required this.similarExperiences,
  });
}

// Events
abstract class ActivityDetailsEvent {}

class FetchActivityDetailsEvent extends ActivityDetailsEvent {
  final String activityId;
  FetchActivityDetailsEvent(this.activityId);
}

class ChangeTabEvent extends ActivityDetailsEvent {
  final int tabIndex;
  ChangeTabEvent(this.tabIndex);
}

// States
abstract class ActivityDetailsState {}

class ActivityLoadingState extends ActivityDetailsState {}

class ActivityLoadedState extends ActivityDetailsState {
  final ActivityDetailsModel data;
  final int selectedTabIndex;

  ActivityLoadedState({
    required this.data,
    this.selectedTabIndex = 0,
  });

  ActivityLoadedState copyWith({
    ActivityDetailsModel? data,
    int? selectedTabIndex,
  }) {
    return ActivityLoadedState(
      data: data ?? this.data,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}

class ActivityErrorState extends ActivityDetailsState {
  final String message;
  ActivityErrorState(this.message);
}

// BLoC Implementation
class ActivityDetailsBloc
    extends Bloc<ActivityDetailsEvent, ActivityDetailsState> {
  ActivityDetailsBloc() : super(ActivityLoadingState()) {
    on<FetchActivityDetailsEvent>((event, emit) async {
      emit(ActivityLoadingState());
      try {
        // Dynamic Data Fetching simulation (API response)
        await Future.delayed(const Duration(milliseconds: 500));

        final mockData = ActivityDetailsModel(
          title: "Dubai Crocodile\nPark Tickets",
          rating: 4.8,
          reviewsCount: 430,
          price: "1,573",
          operatingHours: "Open today · 10:00 – 20:00",
          locationTitle: "Dubai Crocodile Park, Mushrif ,",
          locationSubtitle: "DUBAI, United Arab Emirates",
          images: [
            "https://images.unsplash.com/photo-1522069169874-c58ec4b76be5",
            "https://images.unsplash.com/photo-1544551763-46a013bb70d5",
          ],
          highlightsImages: [
            "https://images.unsplash.com/photo-1534438327276-14e5300c3a48",
            "https://images.unsplash.com/photo-1544551763-46a013bb70d5",
          ],
          highlightText:
          "Witness 250 Nile crocodiles basking lazily in their recreated natural habitat at the African wetland-themed park. Unearth 200 million years of crocodilian evolution at the park's natural history museum or soak up deeper insights from educator-led visits.",
          whatsIncluded: [
            "Entry to Dubai Crocodile Park",
            "Access to Park journey",
            "Access to Crocodile Museum",
            "Access to Crocodile Aquarium"
          ],
          similarExperiences: [
            {
              "title": "Dubai Safari Park Tickets with Explorer Safari & Shuttle Train",
              "rating": "4.6 | 3.6K",
              "price": "3,289",
              "image": "https://images.unsplash.com/photo-1507608869274-d3177c8bb4c7"
            },
            {
              "title": "Aquaventure Waterpark Tickets with Sea Lion Experiences",
              "rating": "4.5 | 680",
              "price": "13,764",
              "image": "https://images.unsplash.com/photo-1544551763-46a013bb70d5"
            },
            {
              "title": "Dubai Aquarium & Underwater Zoo with Penguin Cove Tickets",
              "rating": "4.4 | 15.5K",
              "price": "4,695",
              "image": "https://images.unsplash.com/photo-1512453979798-5ea266f8880c"
            }
          ],
        );

        emit(ActivityLoadedState(data: mockData));
      } catch (e) {
        emit(ActivityErrorState("Failed to load details"));
      }
    });

    on<ChangeTabEvent>((event, emit) {
      if (state is ActivityLoadedState) {
        final currentState = state as ActivityLoadedState;
        emit(currentState.copyWith(selectedTabIndex: event.tabIndex));
      }
    });
  }
}