import 'package:bloc/bloc.dart';

class SocialLinksCubit extends Cubit<List<String>> {
  SocialLinksCubit([socialLinks = const []]) : super(socialLinks);

  void addLink(String link) {
    emit(List.of(state)..add(link));
  }

  void deleteLink(int linkIndex) {
    emit(List.of(state)..removeAt(linkIndex));
  }
}
