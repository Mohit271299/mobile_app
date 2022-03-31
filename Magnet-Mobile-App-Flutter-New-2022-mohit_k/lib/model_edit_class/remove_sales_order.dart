class edit_sales_order_model {
  String? productname;
  String? product_qnty;
  String? product_rate;
  String? product_tax;
  String? product_dis;

  edit_sales_order_model(
      { this.product_rate,
        this.product_tax,
        this.product_dis,
        this.product_qnty,
        this.productname});
}

class sales_texable_value extends edit_sales_order_model{
  String product_texable_excl;
  String product_texable_incl;
  String product_final_tax_excl;
  String product_final_tax_incl;

  sales_texable_value(
      {required this.product_texable_excl,
        required this.product_texable_incl,
        required this.product_final_tax_incl,
        required this.product_final_tax_excl}) ;

}
