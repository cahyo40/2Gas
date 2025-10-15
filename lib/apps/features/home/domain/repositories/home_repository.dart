import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';

abstract class HomeRepository {
  Future<List<OrganizationHomeResponseModel>> homeOrganization();
}
