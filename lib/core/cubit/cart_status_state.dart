part of 'cart_status_cubit.dart';

sealed class CartStatusState {}

final class CartStatusInitial extends CartStatusState {}

final class CartStatusLoaded extends CartStatusState {}
