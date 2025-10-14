view: product_dimension {
  sql_table_name: `looker-training-475011.Sales_Dataset_A.Product Dimension` ;;

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }
  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
  }
  dimension: unit_price {
    type: number
    sql: ${TABLE}.unit_price ;;
  }
  measure: count {
    type: count
    drill_fields: [brand_name, product_name]
  }
}
