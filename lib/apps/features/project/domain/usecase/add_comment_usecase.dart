import 'package:twogass/apps/data/model/comment_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class AddCommentUsecase {
  final ProjectRepository _r;
  AddCommentUsecase(this._r);

  Future<void> call(CommentModel model) => _r.addComment(model: model);
}
