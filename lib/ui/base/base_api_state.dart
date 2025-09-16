abstract class BaseApiState{}
class BaseLoadingState extends BaseApiState{}
class BaseErrorState extends BaseApiState{
  String errorMessage;
  BaseErrorState(this.errorMessage);
}
class BaseSuccessState<T> extends BaseApiState{
  T data ;
  BaseSuccessState(this.data);
}