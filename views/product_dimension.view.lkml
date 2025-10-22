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
      <img src="https://unsplash.com/photos/a-statue-of-a-man-in-a-superman-suit-99rNTJ22Zps" height="170" width="255">
    {% elsif product_name._value == "Belt" %}
      <img src="https://www.freepik.com/free-photo/cinturon-con-fondo-blanco_990692.htm#fromView=keyword&page=1&position=2&uuid=e2ce5096-8652-4a6e-86c2-f5613a6719dd&query=Belt" height="170" width="255">
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
  dimension: product_image_url {
    label: "Product Image URL"
    type: string
    sql:
    CASE
      WHEN ${product_name} = 'Action Figure' THEN 'https://images.unsplash.com/photo-1575936123452-b67c3203c357'
      WHEN ${product_name} = 'Belt' THEN 'https://images.unsplash.com/photo-1580910051073-d1d274b4dd8b'
      WHEN ${product_name} = 'Board Game' THEN 'https://upload.wikimedia.org/wikipedia/commons/6/6f/Board_game_example.jpg'
      WHEN ${product_name} = 'Camera' THEN 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Camera_example.jpg'
      WHEN ${product_name} = 'Cookware Set' THEN 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Cookware_set_example.jpg'
      WHEN ${product_name} = 'Curtains' THEN 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Curtains_example.jpg'
      WHEN ${product_name} = 'Dinner Set' THEN 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Dinner_set_example.jpg'
      WHEN ${product_name} = 'Doll' THEN 'https://upload.wikimedia.org/wikipedia/commons/1/1f/Doll_example.jpg'
      WHEN ${product_name} = 'Dress' THEN 'https://upload.wikimedia.org/wikipedia/commons/4/44/Dress_example.jpg'
      WHEN ${product_name} = 'Handbag' THEN 'https://upload.wikimedia.org/wikipedia/commons/5/57/Handbag_example.jpg'
      WHEN ${product_name} = 'Headphones' THEN 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Headphones_example.jpg'
      ELSE 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'
    END
  ;;
  }

  dimension: product_image_link {
    type: string
    sql: ${product_image_url} ;;
    html:
    <a href="{{ value }}" target="_blank">{{ value }}</a>
  ;;
  }

  #drill analysis
  measure: total_sales_test_drill {
    type: number
    sql: ${unit_price} ;;
    drill_fields: [brand_name, product_name, unit_price, count]
  }

  dimension: category_drill {
    sql: ${TABLE}.category ;;
    drill_fields: [product_name, total_sales_test_drill]
  }

  dimension: product_name_drill {
    sql: ${TABLE}.product_name ;;
    drill_fields: [product_id, rating, description]
  }
}
