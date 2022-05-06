import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/scheduler_class_model.dart';

final schedulerProvider = ChangeNotifierProvider<SchedulerProvider>((ref) {
  return SchedulerProvider([
    const SchedulerClassModel.initial(),
  ]);
});

class SchedulerProvider extends ChangeNotifier {
  final List<SchedulerClassModel> _selectedClasses;

  SchedulerProvider(this._selectedClasses);

  UnmodifiableListView<SchedulerClassModel> get selectedClasses =>
      UnmodifiableListView(_selectedClasses);

  void addClass() {
    _selectedClasses.add(const SchedulerClassModel.initial());
    notifyListeners();
  }

  void removeClass(int i) {
    _selectedClasses.removeAt(i);
    notifyListeners();
  }

  void updateClass(int i, SchedulerClassModel cls) {
    _selectedClasses[i] = cls;
    notifyListeners();
  }
}
