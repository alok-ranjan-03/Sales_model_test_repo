view: product_dimension {
  sql_table_name: `looker-training-475011.Sales_Dataset_A.Product Dimension` ;;

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
    drill_fields: [category]
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
  dimension: product_image {
    type: string
    sql: ${TABLE}.product_name ;;
    html:
    {% if product_name._value == "Action Figure" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/3/3d/Action_figure_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Belt" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/9/9b/Leather_belt_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Board Game" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/6/6f/Board_game_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Camera" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Camera_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Cookware Set" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/0/0e/Cookware_set_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Curtains" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/7/7f/Curtains_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Dinner Set" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/2/2d/Dinner_set_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Doll" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/1/1f/Doll_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Dress" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/4/44/Dress_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Handbag" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/5/57/Handbag_example.jpg" height="170" width="255">
    {% elsif product_name._value == "Headphones" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/8/8a/Headphones_example.jpg" height="170" width="255">
    {% else %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png" height="170" width="170">
    {% endif %} ;;
  }

}
