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
  dimension: total_amount {
    type: number
    sql: ${TABLE}.total_amount ;;
  }
  dimension: unit_price {
    type: number
    sql: ${TABLE}.unit_price ;;
  }
  measure: count {
    type: count
  }
  # parameter: selected_date {
  #   type: date
  # }
  # dimension: last_date_last {
  #   type: date
  #   sql: DATE_TRUNC({% parameter selected_date %},month);;
  # }

  # dimension: start_date_3_months_back {
  #   type: date
  #   datatype: date
  #   sql: DATE_TRUNC(DATE_SUB(CAST({% parameter selected_date %} as date),interval 3 month),month);;
  # }
  # dimension: is_in_period {
  #   type: yesno
  #   sql: ${order_date}>=${start_date_3_months_back} AND ${order_date}<=${last_date_last} ;;
  # }
  # measure: sales_3_mnths_avg {
  #   type: sum
  #   sql: ${total_amount}/3 ;;
  #   filters: {
  #     field: is_in_period
  #     value: "yes"
  #   }
  # }
  parameter: selected_date {
    type: date
  }

  dimension: last_date_last {
    type: date
    sql: DATE({% parameter selected_date %}) ;;
  }

  dimension: start_date_3_months_back {
    type: date
    sql: DATE_SUB(DATE({% parameter selected_date %}), INTERVAL 3 MONTH) ;;
  }

  dimension: is_in_trailing_3_months {
    type: yesno
    sql: ${order_date} BETWEEN ${start_date_3_months_back} AND ${last_date_last} ;;
  }

  measure: total_sales_trailing_3_months {
    type: sum
    sql: ${total_amount} ;;
    filters: {
      field: is_in_trailing_3_months
      value: "yes"
    }
  }

  measure: total_orders_trailing_3_months {
    type: count
    filters: {
      field: is_in_trailing_3_months
      value: "yes"
    }
  }

  measure: average_sales_trailing_3_months {
    type: number
    sql: ${total_sales_trailing_3_months} / NULLIF(${total_orders_trailing_3_months}, 0) ;;
    value_format_name: "usd"
  }

  measure: conditional_formatting_discount_perc {

    type: sum
    sql: ${discount_percentage} ;;
    html:
    {% if value >= 10 %}
      <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 5 %}
      <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
      <p style="color: white; background-color: red;  font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
  ;;
  }

  dimension: sales_same_date_last_year {
    type: number
    sql:
    CASE
      WHEN ${order_date} = DATE_SUB(cast({% parameter selected_date %} as date), INTERVAL 1 YEAR)
      THEN ${total_amount}
      ELSE 0
    END ;;
    label: "Sales (Same Date Last Year)"
    description: "Sum of total_amount for the same date last year as the selected date"
  }

  parameter: order_status_filter {
    label: "Order Status (with All)"
    type: string
    allowed_value: { label: "All" value: "ALL" }
    allowed_value: { label: "Cancelled" value: "Cancelled" }
    allowed_value: { label: "Completed" value: "Completed" }
    allowed_value: { label: "Returned" value: "Returned" }
    allowed_value: { label: "Shipped" value: "Shipped" }
    default_value: "All"
  }
  dimension: filtered_order_status {
    type: string
    sql:
    CASE
      WHEN {% parameter order_status_filter %} = 'All'
        THEN ${order_status}
      ELSE
        CASE
          WHEN ${order_status} = {% parameter order_status_filter %}
          THEN ${order_status}
        END
    END ;;
    label: "Order Status (Filtered)"
  }

}
