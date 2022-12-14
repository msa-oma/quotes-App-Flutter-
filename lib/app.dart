import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/locale/app_localization_setup.dart';
import 'config/routes/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'features/splash/presentation/cubit/locale_cubit.dart';
import 'injection_container.dart' as di;
import 'config/themes/app_theme.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<LocaleCubit>()..getSavedLang(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (previousState, currentState) {
            return previousState != currentState;
          },
          builder: (context, state) {
            return MaterialApp(
              title: AppStrings.appName,
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
            );
          },
        ));
  }
}
