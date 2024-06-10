import '../core/localizations.dart';

String tranlator(context, String key) {
  return AppLocalizations.of(context).getTranslate(key);
}
