import 'package:hostel_complain_management_app/data/data_providers/database_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class FeedRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Complain>> getComplains(ComplainType complainType) async {
    return await _databaseService.getAllComplains(type: complainType);
  }
}
