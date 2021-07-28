class HistoryOrderModel{
  final String invoice;
  final String idUser;
  final String orderAt;
  final String status;
  final List<HistoryOrderDetailModel> detail;

  HistoryOrderModel(
      {required this.invoice,
        required  this.idUser,
        required  this.orderAt,
        required this.status,
        required this.detail});

  factory HistoryOrderModel.fromJson(Map<String,dynamic> dataOrder){
    final list =dataOrder['detail'] as List;
    List<HistoryOrderDetailModel> dataListDetail =
        list.map((e) => HistoryOrderDetailModel.fromJson(e)).toList();
    return HistoryOrderModel(
        invoice: dataOrder['invoice'],
        idUser: dataOrder['id_user'],
        orderAt: dataOrder['order_at'],
        status: dataOrder['status'],
        detail: dataOrder['detail'],
    );
  }

}

class HistoryOrderDetailModel{
  final String idOrder;
  final String invoice;
  final String idProduct;
  final String nameProduct;
  final String quantity;
  final String price;

  HistoryOrderDetailModel(
      {
        required this.idOrder,

        required this.invoice,
        required this.idProduct,
        required this.nameProduct,
        required this.quantity,
        required this.price});
  
  
  factory HistoryOrderDetailModel.fromJson(Map<String,dynamic> data) {
    return HistoryOrderDetailModel(
        idOrder: data['id_orders'],
        invoice: data['invoice'],
        idProduct: data['id_product'],
        nameProduct: data['nameProduct'],
        quantity: data['quantity'],
        price: data['price'],
    );
  }
}