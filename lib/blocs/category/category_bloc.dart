import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contoso_ecom/repositories/category/category_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }

  FutureOr<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories().listen(
          (products) => add(
            UpdateCategories(products),
          ),
        );
  }

  FutureOr<void> _onUpdateCategories(
    UpdateCategories event,
    Emitter<CategoryState> emit,
  ) {
    emit(CategoryLoaded(categories: event.categories));
  }
}
