part of 'loader_cubit.dart';

@immutable
abstract class LoaderState {}

class LoaderInitial extends LoaderState {}

class Loading extends LoaderState {}

class Loaded extends LoaderState {}

