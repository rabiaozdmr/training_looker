# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `thelook_ecommerce.order_items` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: date_week {
    type: date
    sql: ${TABLE}.created_week ;;
  }
  dimension: days_since_signup {
    type: number
    sql: DATE_DIFF(${shipped_date}, ${created_date}, DAY);;
  }

  dimension: total_sale_bigger_1 {
    type: yesno
    sql: ${sale_price} >= 1 ;;
  }

  measure: total_sale_bigger_1_list {
    type: list
    list_field:id
  }

  measure: total_more_than_1_usd {
    type: sum
    sql: ${sale_price} ;;
    filters: {
      field: total_sale_bigger_1
      value: "Yes"
    }
  }


  dimension_group: delivered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.delivered_at ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  parameter: partitioning_dimension {
    type: string
    allowed_value: {
      label: "Date Week"
      value: "date_week"
    }
    allowed_value: {
      label: "status"
      value: "status"
    }
  }


  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }


  measure: AVG_sale_price {
    type: average
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: rank_by_count_of_purchase {
    type: number
    sql: |
          ROW_NUMBER() OVER (
            PARTITION BY
            {% if partitioning_dimension._parameter_value %}
              {% assign dimensions = partitioning_dimension._parameter_value | split: ',' %}
              {% for dimension in dimensions %}
                {% if dimension == 'date_week' %}
                  ${date_week}
                {% elsif dimension == 'status' %}
                  ${status}
                {% endif %}
                {% if forloop.last == false %}, {% endif %}
              {% endfor %}
            {% else %}
              NULL
            {% endif %}
            ORDER BY ${count_of_purchase} DESC
          ) ;;
  }

  measure: count_of_purchase {
    type: sum
    sql: ${TABLE}.purchase_count ;;
  }
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  inventory_items.id,
  inventory_items.product_name,
  products.name,
  products.id,
  orders.order_id
  ]
  }

}
