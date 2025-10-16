
view: last_year_selected_date_sql_runner {
  derived_table: {
    sql: with cte as(
      select extract(year from sales_analytics.order_date) as year , round(SUM(sales_analytics.total_amount),2) as total_sales
      from `looker-training-475011.Sales_Dataset_A.Sales Fact`  AS sales_analytics
      group by 1
      )
      
      select 
        curr.year, 
        curr.total_sales, 
        prev.total_sales as prev_sales
      from cte curr 
      left join cte prev
      on curr.year-1=prev.year
      ORDER BY
          1 DESC
      LIMIT 500 ;;
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
