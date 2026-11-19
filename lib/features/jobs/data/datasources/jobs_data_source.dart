import '../models/jobs_catalog_model.dart';

abstract interface class JobsDataSource {
  Future<JobsCatalogModel> fetchJobsCatalog();
}
