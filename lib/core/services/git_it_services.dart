import 'package:get_it/get_it.dart';
import '../../features/authiciation/data/repo/auth_repo_impl.dart';
import '../../features/authiciation/domain/repo/auth_repo.dart';
import '../../features/home/data/repos/chat_repo_impl.dart';
import '../../features/home/domain/chat_repo.dart';
import '../../secrets.dart';
import 'chat_services.dart';
import 'firebase_auth_services.dart';
import 'netwok_services.dart';

final getIt = GetIt.instance;

void setupServices() {
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(firebaseAuthServices: getIt<FirebaseAuthServices>()),
  );

  getIt.registerSingleton<ChatRepo>(
    ChatRepoImpl(
      Secrets.groqApiKey,
    ),
  );

  getIt.registerSingleton<ChatService>(ChatService());

  getIt.registerSingleton<NetworkService>(NetworkService());

}