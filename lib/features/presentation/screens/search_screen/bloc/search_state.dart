part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}


class FetchSearchItemsLoadingState extends SearchState {}

class FetchSearchItemsSuccessState extends SearchState {
  final List<ProductsModel> productList;

  FetchSearchItemsSuccessState({required this.productList});
}

class FetchSearchItemsNULLState extends SearchState {}

class MicListeningState extends SearchState {
  final bool isNotListening;

  MicListeningState({required this.isNotListening});
}