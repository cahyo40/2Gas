import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';

class HomeOfflineDatasource implements HomeRepository {
  @override
  Future<List<OrganizationHomeResponseModel>> homeOrganization() {
    // TODO: implement homeOrganization
    throw UnimplementedError();
  }

  // TODO: local db / shared pref
}
