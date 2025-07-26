import 'package:celluweather_task1/features/ai_analysis/presentation/manager/ai_predict_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget fetchApiDataWidget(BuildContext context) {
  return Column(
    children: [
      ElevatedButton(
        onPressed: () {
          context.read<AiPredictCubit>().predict([1, 0, 1, 1, 0]);
        },
        child: Text('Predict'),
      ),
      BlocBuilder<AiPredictCubit, AiPredictState>(
        builder: (context, state) {
          if (state.isLoading) return CircularProgressIndicator();
          if (state.result != null) return Text('Result: ${state.result}');
          if (state.error != null) return Text('Error: ${state.error}');
          return SizedBox.shrink();
        },
      ),
    ],
  );
}
