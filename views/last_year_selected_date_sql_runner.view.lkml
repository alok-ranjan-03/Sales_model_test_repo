
view: last_year_selected_date_sql_runner {
  parameter: selected_date {
    type: date
    default_value: "today"
    description: "Select a date to compare sales with last year"
  }

  derived_table: {
    sql: SELECT
  curr.year,
  curr.total_sales AS sales_selected_date,
  prev.total_sales AS sales_previous_year
FROM
  (
    SELECT
      EXTRACT(YEAR FROM order_date) AS year,
      ROUND(SUM(total_amount),2) AS total_sales
    FROM `looker-training-475011.Sales_Dataset_A.Sales Fact`
    WHERE DATE(order_date) IN (
        {% parameter selected_date %},
        DATE_SUB(DATE({% parameter selected_date %}), INTERVAL 1 YEAR)
    )
    GROUP BY 1
  ) AS curr
LEFT JOIN
  (
    SELECT
      EXTRACT(YEAR FROM order_date) AS year,
      ROUND(SUM(total_amount),2) AS total_sales
    FROM `looker-training-475011.Sales_Dataset_A.Sales Fact`
    WHERE DATE(order_date) IN (
        {% parameter selected_date %},
        DATE_SUB(DATE({% parameter selected_date %}), INTERVAL 1 YEAR)
    )
    GROUP BY 1
  ) AS prev
ON curr.year - 1 = prev.year
ORDER BY curr.year DESC;
;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: total_sales {
    type: number
    sql: ${TABLE}.total_sales ;;
  }

  dimension: prev_sales {
    type: number
    sql: ${TABLE}.prev_sales ;;
  }

  set: detail {
    fields: [
        year,
  total_sales,
  prev_sales
    ]
  }
}
