part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class FetchSearchResultEvent extends SearchEvent {
  final String letter;

  FetchSearchResultEvent({required this.letter});
}
class SearchFetchFilterEvent extends SearchEvent{
  final String brand;
  final String category;
  final String subCategory;
  final double sliderStart;
  final double sliderEnd;
  final BuildContext context;

  SearchFetchFilterEvent({required this.context,required this.brand, required this.category, required this.subCategory, required this.sliderStart, required this.sliderEnd});

}
