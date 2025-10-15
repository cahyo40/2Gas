import 'package:twogass/apps/data/model/organitation_model.dart';

abstract class OrganizationCreateUpdateRepository {
  Future<bool> createOrganization(OrganizationModel model);
}
