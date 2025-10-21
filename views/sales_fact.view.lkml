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

  dimension: is_same_date_last_year {
    type: yesno
    sql:
    CASE
      WHEN ${order_date} = DATE_SUB(CAST({% parameter selected_date %} AS DATE), INTERVAL 1 YEAR)
      THEN TRUE
      ELSE FALSE
    END ;;
    hidden: yes
  }

  measure: sales_same_date_last_year_measure {
    type: sum
    sql: ${total_amount} ;;
    filters: {
      field: is_same_date_last_year
      value: "yes"
    }
    label: "Sales (Same Date Last Year)"
  }


  parameter: order_status_filter {
    label: "Order Status (with All)"
    type: string
    allowed_value: { label: "All" value: "ALL" }
    allowed_value: { label: "Cancelled" value: "Cancelled" }
    allowed_value: { label: "Completed" value: "Completed" }
    allowed_value: { label: "Returned" value: "Returned" }
    allowed_value: { label: "Shipped" value: "Shipped" }
    default_value: "ALL"
  }
  dimension: filtered_order_status {
    type: string
    sql:
    CASE
      WHEN {% parameter order_status_filter %} = 'ALL' THEN ${order_status}
      ELSE ${order_status}
    END ;;
  }

  parameter: year_filter {
    type: number
    label: "Select Year"
    hidden: yes   # initially hidden
  }
  dimension: show_year_filter {
    type: yesno
    hidden: yes
    sql:
    CASE
      WHEN {% parameter selected_date %} IS NOT NULL THEN TRUE
      ELSE FALSE
    END ;;
  }

  measure: total_sales_conditional {
    type: sum
    sql:
      CASE
        -- Apply year filter only if both parameters are selected
        WHEN {% parameter selected_date %} IS NOT NULL
             AND {% parameter year_filter %} IS NOT NULL
             AND EXTRACT(YEAR FROM ${order_date}) = {% parameter year_filter %}
        THEN ${total_amount}

      -- Otherwise, include all rows
      ELSE ${total_amount}
      END ;;
    value_format_name: "usd"
  }


##creating dynamic measures
  parameter: dynamic_measure_val {
    type: unquoted
    allowed_value: {
      label: "Total Cost"
      value: "unit_price"
    }
    allowed_value: {
      label: "Total Sales"
      value: "total_amount"
    }
    allowed_value: {
      label: "Total Quantity"
      value: "quantity"
    }
  }

  measure: dynamic_sum_using_measure {
    type: sum
    sql: ${TABLE}.{% parameter dynamic_measure_val %} ;;
  }

  ## creating dynamic date granularity
  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Calculations by Day"
      value: "day"
    }
    allowed_value: {
      label: "Calculations by Month"
      value: "month"
    }
    allowed_value: {
      label: "Calculations by Year"
      value: "year"
    }
  }

  dimension: dynamic_calculations_by_date_granulaity {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${order_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${order_month}
    {% else %}
      ${order_year}
    {% endif %}
    ;;

    html:
    {% if date_granularity._parameter_value == 'day' %}
    <font color="darkgreen">{{ rendered_value }}</font>
    {% elsif date_granularity._parameter_value == 'month' %}
    <font color="darkred">{{ rendered_value }}</font>
    {% elsif date_granularity._parameter_value == 'year' %}
    <font color="darkblue">{{ rendered_value }}</font>
    {% else %}
    <font color="black">{{ rendered_value }}</font>
    {% endif %};;

  }

  measure: total_sales_measure {
    type: sum
    sql: ${total_amount} ;;
  }

  parameter: top_n {
    type: number
    default_value: "10"
    allowed_value: {
      label: "Top 5"
      value: "5"
    }
    allowed_value: { label: "Top 10" value: "10" }
    allowed_value: { label: "Top 20" value: "20" }
  }

}
