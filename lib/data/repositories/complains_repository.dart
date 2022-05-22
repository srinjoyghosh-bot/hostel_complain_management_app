import 'package:hostel_complain_management_app/data/data_providers/database_service.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class ComplainsRepository {
  final DatabaseService _service = DatabaseService();

  Future<List<Complain>> getSelfComplains() async {
    return await _service.getSelfComplains();
  }
}
