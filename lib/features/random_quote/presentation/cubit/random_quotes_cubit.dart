import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_quote/domain/entities/quote.dart';

import '../../domain/use_cases/get_random_quote.dart';

part 'random_quotes_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuotesState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuotesInitial());

  Future<void> getRandomQuote() async {
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());

    emit(response.fold(
        (failure) => RandomQuoteIsError(msg: _mapFailureToMsg(failure)),
        (quote) => RandomQuoteIsLoaded(quote: quote)));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
