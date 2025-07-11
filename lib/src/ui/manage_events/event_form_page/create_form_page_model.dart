import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:Saturnalia/src/models/dynamic_form_data.dart';

import '../../../logic/services/firebase_firestore.dart';

part 'create_form_page_model.freezed.dart';

final createFormPageProvider =
    StateNotifierProvider.autoDispose<CreateFormPageModel, CreateFormPageState>(
  (ref) => CreateFormPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class CreateFormPageModel extends StateNotifier<CreateFormPageState> {
  final FirebaseFirestore firebaseFirestore;
  StreamSubscription? _subscription;
  CreateFormPageModel({required this.firebaseFirestore})
      : super(const CreateFormPageState());

  addField() {
    state = state.copyWith(
      formList: state.formList.toList()
        ..add(
          DyamicFormData(
            type: 0,
            id: state.counter + 1,
            data: const FormType(title: ''),
          ),
        ),
      counter: state.counter + 1,
    );
  }

  init(List<DyamicFormData> data) {
    final datas = data.toList()..sort((a, b) => a.id.compareTo(b.id));

    state =
        state.copyWith(formList: datas, counter: datas[datas.length - 1].id);
  }

  addOptions(int index) {
    List<DyamicFormData> data = state.formList.toList();

    data[index] = data[index].copyWith(
      data: data[index].data.copyWith(
            options: (data[index].data.options ?? []).toList()
              ..add(
                OptionFormType(
                    optionValue: '',
                    id: (data[index].data.options?.last.id ?? 0) + 1),
              ),
          ),
    );
    state = state.copyWith(formList: data);
  }

  removeOptions(int formIndex, int optionIndex) {
    List<DyamicFormData> data = state.formList.toList();

    data[formIndex] = data[formIndex].copyWith(
      data: data[formIndex].data.copyWith(
            options: (data[formIndex].data.options!).toList()
              ..removeAt(optionIndex),
          ),
    );

    state = state.copyWith(formList: data);
  }

  setOptionTitle(int fieldIndex, optionIndex, String title) {
    List<DyamicFormData> data = state.formList.toList();
    List<OptionFormType> datas = data[fieldIndex].data.options!.toList();
    datas[optionIndex] = datas[optionIndex].copyWith(optionValue: title);

    data[fieldIndex] = data[fieldIndex].copyWith(
      data: data[fieldIndex].data.copyWith(options: datas),
    );
    state = state.copyWith(formList: data);
  }

  removeField(int index) {
    state = state.copyWith(
      formList: state.formList.toList()..removeAt(index),
    );
  }

  setFieldTitle(int index, String title) {
    List<DyamicFormData> data = state.formList.toList();
    data[index] = data[index].copyWith(
      data: data[index].data.copyWith(title: title),
    );
    state = state.copyWith(formList: data);
  }

  setFieldMaxLines(int index, int maxLines) {
    List<DyamicFormData> data = state.formList.toList();
    data[index] = data[index].copyWith(
      data: data[index].data.copyWith(maxLines: maxLines),
    );
    state = state.copyWith(formList: data);
  }

  setFieldMaxLength(int index, int maxLength) {
    List<DyamicFormData> data = state.formList.toList();
    data[index] = data[index].copyWith(
      data: data[index].data.copyWith(maxLength: maxLength),
    );
    state = state.copyWith(formList: data);
  }

  setFieldType(int index, int type) {
    List<DyamicFormData> data = state.formList.toList();
    data[index] = data[index].copyWith(
      type: type,
      data: data[index].data.copyWith(
          maxLength: null,
          maxLines: null,
          options: type == 4
              ? ([const OptionFormType(optionValue: '', id: 0)])
              : null),
    );
    state = state.copyWith(formList: data);
  }

  String validateForm() {
    final form = state.formList;
    if (form.isEmpty) {
      return 'please add atleat one field';
    }
    for (int i = 0; i < form.length; i++) {
      if (form[i].data.title.trim().isEmpty) {
        return 'please enter form ${i + 1} title';
      }
      if (form[i].type == 4) {
        for (int j = 0; j < (form[i].data.options?.length ?? 0); j++) {
          if (form[i].data.options![j].optionValue.trim().isEmpty) {
            return 'Enter ${i + 1} field option ${j + 1} value';
          }
        }
      }
    }
    return '';
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

@freezed
class CreateFormPageState with _$CreateFormPageState {
  const factory CreateFormPageState({
    @Default(CreateFormPageStatus.initial) CreateFormPageStatus status,
    @Default([DyamicFormData(data: FormType(title: ''), id: 0, type: 0)])
    List<DyamicFormData> formList,
    @Default(0) int counter,
    // @Default('all') String tag,
  }) = _CreateFormPageState;
}

enum CreateFormPageStatus {
  initial,
  loading,
  loaded,
  error,
}
