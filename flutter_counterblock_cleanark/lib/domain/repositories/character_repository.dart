import 'package:dartz/dartz.dart';
import 'package:flutter_counterblock_cleanark/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Exception, List<Character>>> getAllCharacters();
}
