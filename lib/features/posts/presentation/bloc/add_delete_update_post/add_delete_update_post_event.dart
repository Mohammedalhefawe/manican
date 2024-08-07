part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
