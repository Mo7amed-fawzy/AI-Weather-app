import 'package:celluweather_task1/features/ai_analysis/domain/usecases/predict_tennis_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiPredictState {
  final bool isLoading;
  final int? result;
  final String? error;

  AiPredictState({this.isLoading = false, this.result, this.error});
}

class AiPredictCubit extends Cubit<AiPredictState> {
  final PredictTennisUseCase useCase;

  AiPredictCubit(this.useCase) : super(AiPredictState());

  void predict(List<int> inputs) async {
    emit(AiPredictState(isLoading: true));
    try {
      final result = await useCase(inputs);
      emit(AiPredictState(result: result));
    } catch (e) {
      emit(AiPredictState(error: e.toString()));
    }
  }
}
