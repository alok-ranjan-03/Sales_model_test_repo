# Define the database connection to be used for this model.
connection: "prateek_gcp_demo"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: Sales_A_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: Sales_A_model_default_datagroup

