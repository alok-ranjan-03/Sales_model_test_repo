
view: category_cost_price {
  derived_table: {
    sql: SELECT
          product_dimension.product_id AS product_id,,
          product_dimension.category,
              ROUND(AVG(product_dimension.unit_price), 2) AS category_cost_price
      FROM `looker-training-475011.Sales_Dataset_A.Sales Fact`  AS sales_analytics
      LEFT JOIN `looker-training-475011.Sales_Dataset_A.Product Dimension`  AS product_dimension ON sales_analytics.product_id = product_dimension.product_id
      GROUP BY
          1
      ORDER BY
          1;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: category_cost_price {
    type: number
    sql: ${TABLE}.category_cost_price ;;
  }

  set: detail {
    fields: [
        category,
  category_cost_price
    ]
  }
}
