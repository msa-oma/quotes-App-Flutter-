import 'package:quotes_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/usecases/usecase.dart';

import '../repositories/lang_repository.dart';

class ChangeLangUseCase extends UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await langRepository.changeLang(langCode: params);
  }
}
