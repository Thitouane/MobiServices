abstract class UseCase<R> {
  Future<R> call();
}

abstract class UseCaseOneParam<R, P> {
  Future<R> call(P param);
}

abstract class StreamUseCase<R, P> {
  Stream<R> call({required P params});
}

abstract class StreamUseCaseTwoParams<R, A, B> {
  Stream<R> call({required A paramsOne, required B paramsTwo});
}

abstract class UseCaseTwoParams<R, A, B> {
  Future<R> call({required A paramsOne, required B paramsTwo});
}

abstract class UseCaseThreeParams<R, A, B, C> {
  Future<R> call(
      {required A paramsOne, required B paramsTwo, required C paramsThree});
}

abstract class UseCaseFourParams<R, A, B, C, D> {
  Future<R> call(
      {required A paramsOne,
        required B paramsTwo,
        required C paramsThree,
        required D paramsFour});
}