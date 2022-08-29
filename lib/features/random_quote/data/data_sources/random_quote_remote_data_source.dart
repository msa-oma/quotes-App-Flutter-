import 'package:quotes_app/core/api/api_consumer.dart';
import 'package:quotes_app/core/api/end_points.dart';

import '../../../random_quote/data/models/quoet_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  ApiConsumer apiConsumer;
  RandomQuoteRemoteDataSourceImpl({
    required this.apiConsumer,
  });

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(
      EndPoints.randomQuote,
    );

    return QuoteModel.fromJson(response);
  }
}
