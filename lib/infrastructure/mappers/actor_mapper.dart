import 'package:moviepedia_app/config/constants/environment.dart';
import 'package:moviepedia_app/domain/entities/actor.dart';
import 'package:moviepedia_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? '${Environment.imageUrl}${cast.profilePath}'
          : Environment.imageNotFoundUrl,
      character: cast.character,
    );
  }
}
