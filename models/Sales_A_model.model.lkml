# Define the database connection

connection: "prateek_gcp_demo"

# Include all views
include: "/views/**/*.view.lkml"

# Define a datagroup for caching
datagroup: Sales_A_model_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: Sales_A_model_default_datagroup

# Single unified Explore combining Sales Fact with Customer, Product, and Sales Rep Dimensions
explore: sales_analytics {
  label: "Sales Analytics"
  description: "Explore combining Sales Fact with Customer, Product, and Sales Rep Dimensions."

  from: sales_fact

  # Join Customer Dimension
  join: customer_dimension {
    view_label: "Customer"
    type: left_outer
    sql_on: ${sales_analytics.customer_id} = ${customer_dimension.customer_id} ;;
    relationship: many_to_one
  }

  # Join Product Dimension
  join: product_dimension {
    view_label: "Product"
    type: left_outer
    sql_on: ${sales_analytics.product_id} = ${product_dimension.product_id} ;;
    relationship: many_to_one
  }

  # Join Sales Rep Dimension
  join: sales_rep_dimension {
    view_label: "Sales Rep"
    type: left_outer
    sql_on: ${sales_analytics.sales_rep_id} = ${sales_rep_dimension.sales_rep_id} ;;
    relationship: many_to_one
  }
}
