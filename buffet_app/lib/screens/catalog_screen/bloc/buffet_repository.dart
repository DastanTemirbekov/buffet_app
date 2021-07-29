import 'package:buffet_app/screens/catalog_screen/bloc/buffet_provider.dart';
import '../catalog_model.dart';

class BuffetRepository {
  Future<List<BuffetModels>> getBuffet() {
    BuffetProvider provider = BuffetProvider();
    return provider.getBuffet();
  }
}
