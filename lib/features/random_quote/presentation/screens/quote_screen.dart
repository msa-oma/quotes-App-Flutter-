import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/widgets/error_widget.dart' as error_widget;
import 'package:quotes_app/features/random_quote/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes_app/features/splash/presentation/cubit/locale_cubit.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

import '../widgets/quoete_content.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() {
    BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  }

  @override
  void initState() {
    _getRandomQuote();
    super.initState();
  }

  Widget _buildRefreshBtn() {
    return InkWell(
      onTap: () => _getRandomQuote(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
        child: const Icon(
          Icons.refresh,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuotesState>(
        builder: (context, state) {
      if (state is RandomQuoteIsLoading) {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primary,
          ),
        );
      } else if (state is RandomQuoteIsError) {
        return error_widget.XxErrorWidget(
          onPress: () => _getRandomQuote(),
        );
      } else if (state is RandomQuoteIsLoaded) {
        return Column(
          children: [
            QuoteContent(
              quote: state.quote,
            ),
            _buildRefreshBtn(),
          ],
        );
      } else {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primary,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.translate_outlined,
            color: AppColors.primary,
          ),
          onPressed: () {
            if (AppLocalizations.of(context)!.isEnLocale) {
              BlocProvider.of<LocaleCubit>(context).toArabic();
            } else {
              BlocProvider.of<LocaleCubit>(context).toEnglish();
            }
          },
        ),
        title: Text(AppLocalizations.of(context)!.translate('app_name')!));
    return RefreshIndicator(
      onRefresh: () => _getRandomQuote(),
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyContent(),
      ),
    );
  }
}
