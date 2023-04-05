import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_onStartWishList);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishlist>(_onRemoveProductFromWishlist);
  }

  Future<FutureOr<void>> _onStartWishList(
    StartWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        const WishlistLoaded(),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  FutureOr<void> _onAddProductToWishlist(
    AddProductToWishlist event,
    Emitter<WishlistState> emit,
  ) {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from((state as WishlistLoaded).wishlist.products)
                ..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  FutureOr<void> _onRemoveProductFromWishlist(
    RemoveProductFromWishlist event,
    Emitter<WishlistState> emit,
  ) {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from((state as WishlistLoaded).wishlist.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }
}
