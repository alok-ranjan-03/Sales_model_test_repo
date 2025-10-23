view: sales_rep_dimension {
  sql_table_name: `looker-training-475011.Sales_Dataset_A.Sales Rep Dimension` ;;

  dimension: achieved_sales {
    type: number
    sql: ${TABLE}.achieved_sales ;;
  }
  dimension_group: hire {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.hire_date ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: sales_rep_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.sales_rep_id ;;
  }
  dimension: sales_rep_name {
    type: string
    sql: ${TABLE}.sales_rep_name ;;
  }
  dimension: sales_target {
    type: number
    sql: ${TABLE}.sales_target ;;
  }
  measure: count {
    type: count
    drill_fields: [sales_rep_name]
  }
}
