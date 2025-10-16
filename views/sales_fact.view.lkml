view: sales_fact {
  sql_table_name: `looker-training-475011.Sales_Dataset_A.Sales Fact` ;;

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }
  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }
  dimension: discount_percentage {
    type: number
    sql: ${TABLE}.discount_percentage ;;
  }
  dimension: gross_margin_percentage {
    type: number
    sql: ${TABLE}.gross_margin_percentage ;;
  }
  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }
  dimension: order_status {
    type: string
    sql: ${TABLE}.order_status ;;
  }
  dimension: payment_status {
    type: string
    sql: ${TABLE}.payment_status ;;
  }
  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }
  dimension: promo_code {
    type: string
    sql: ${TABLE}.promo_code ;;
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }
  dimension: sales_id {
    type: number
    sql: ${TABLE}.sales_id ;;
  }
  dimension: sales_rep_id {
    type: number
    sql: ${TABLE}.sales_rep_id ;;
  }
  dimension: shipping_amount {
    type: number
    sql: ${TABLE}.shipping_amount ;;
  }
  dimension: subtotal {
    type: number
    sql: ${TABLE}.subtotal ;;
  }
  dimension: tax_amount {
    type: number
    sql: ${TABLE}.tax_amount ;;
  }
  dimension: tax_percentage {
    type: number
    sql: ${TABLE}.tax_percentage ;;
  }
  measure: total_amount {
    type: sum
    sql: ${TABLE}.total_amount ;;
  }
  dimension: unit_price {
    type: number
    sql: ${TABLE}.unit_price ;;
  }
  measure: count {
    type: count
  }
  parameter: selected_date {
    type: date
    default_value: "now"
  }

}
