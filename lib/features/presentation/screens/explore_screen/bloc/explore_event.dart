part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class ProductsFetchAllEvent extends ExploreEvent {

}


class ProductsFetchFilterEvent extends ExploreEvent {
final String brand;
final String category;
final String subCategory;
final double sliderStart;
final double sliderEnd;
final BuildContext context;

  ProductsFetchFilterEvent({required this.context,required this.brand, required this.category, required this.subCategory, required this.sliderStart, required this.sliderEnd});
}
