part of 'random_quotes_cubit.dart';

@immutable
abstract class RandomQuotesState extends Equatable {
  const RandomQuotesState();
  @override
  List<Object?> get props => [];
}

class RandomQuotesInitial extends RandomQuotesState {}

class RandomQuoteIsLoading extends RandomQuotesState {}

class RandomQuoteIsLoaded extends RandomQuotesState {
  final Quote quote;

  const RandomQuoteIsLoaded({required this.quote});

  @override
  List<Object?> get props => [quote];
}

class RandomQuoteIsError extends RandomQuotesState {
  final String msg;

  const RandomQuoteIsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
