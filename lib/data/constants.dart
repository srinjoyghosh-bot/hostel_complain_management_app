import 'package:hostel_complain_management_app/data/enums.dart';

const Map<String, String> HOSTEL_NAME = {
  'rkb': 'Radhakrishnan Bhawan',
  'rjb': 'Rajendra Bhawan',
  'rb': 'Rajiv Bhawan',
  'kb': 'Kasturba Bhawan',
  'sb': 'Sarojini Bhawan',
};

const Map<String, ComplainType> COMPLAIN_TYPE = {
  'miscellaneous': ComplainType.miscellaneous,
  'mess': ComplainType.mess,
  'maintenance': ComplainType.maintenance,
  'cultural': ComplainType.cultural,
  'sports': ComplainType.sports,
  'none': ComplainType.none,
};
