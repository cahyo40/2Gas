import 'package:twogass/apps/data/model/comment_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class FetchCommentUsecase {
  final ProjectRepository _r;
  FetchCommentUsecase(this._r);

  Future<List<CommentModel>> call(String id) => _r.getComment(id);
}
