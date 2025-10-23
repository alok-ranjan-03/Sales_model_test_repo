view: customer_dimension {
  sql_table_name: `looker-training-475011.Sales_Dataset_A.Customer Dimension` ;;

  dimension: avg_order_value {
    type: number
    sql: ${TABLE}.avg_order_value ;;
  }
  dimension: city {
    type: zipcode
    sql: ${TABLE}.city ;;
  }
  dimension: credit_limit {
    type: number
    sql: ${TABLE}.credit_limit ;;
  }
  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
  }
  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }
  dimension_group: join {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.join_date ;;
  }
  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.lifetime_value ;;
  }
  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }
  dimension: state {
    type: zipcode
    sql: ${TABLE}.state ;;
  }
  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }
  measure: count {
    type: count
    drill_fields: [customer_name]
  }
}
