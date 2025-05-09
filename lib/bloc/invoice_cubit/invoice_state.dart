part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLinkGeneratingState extends InvoiceState {}

class InvoiceLinkGeneratedState extends InvoiceState {
  final String invoiceLink;

  InvoiceLinkGeneratedState(this.invoiceLink);

  @override
  List<Object> get props => [invoiceLink];
}

class InvoiceLinkGenerationErrorState extends InvoiceState {
  final String message;

  InvoiceLinkGenerationErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class AiInvoiceCreatedState extends InvoiceState {}

class AiInvoiceInProgressState extends InvoiceState {}

class AiInvoicePaidSuccessState extends InvoiceState {}

class AiInvoiceUserRejectState extends InvoiceState {}

class AiInvoiceErrorState extends InvoiceState {
  final String message;

  AiInvoiceErrorState(this.message);

  @override
  List<Object> get props => [message];
}
