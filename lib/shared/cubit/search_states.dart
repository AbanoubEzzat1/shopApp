abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErorrStates extends SearchStates {
  final String erorr;

  SearchErorrStates(this.erorr);
}
