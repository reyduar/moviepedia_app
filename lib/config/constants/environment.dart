import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String dbkey = dotenv.env['TMDB_KEY'] ?? 'API Key not found.';
  static String apiUrl = dotenv.env['TMMB_API'] ?? 'API Url not found.';
  static String imageUrl = dotenv.env['TMDB_IMAGE'] ?? 'Image Url not found.';
  static String imageNotFoundUrl =
      dotenv.env['NOTF_IMAGE'] ?? 'Image Url not found.';
}
