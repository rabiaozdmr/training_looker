# The name of this view in Looker is "Users"
view: users {
  view_label: "Users Table"
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `thelook_ecommerce.users` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    label: "ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18, 25, 35, 45, 55, 65, 75, 90]
    style: relational
    sql: CASE WHEN ${age} IS NOT NULL THEN ${age} ELSE NULL END;;
  }

  dimension: age_group {
    type: bin
    bins: [18, 25, 35, 45, 55, 65]
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    hidden: yes
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: city1 {
    type: string
    label: "City Name"
    description: "City's name in users table"
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
      sql: ${TABLE}.gender IS NOT NULL;;
  }


  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street_address {
    type: string
    sql: ${TABLE}.street_address ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_female_users {
    type: count
    filters: {
      field: gender
      value: "F"
    }
  }

  measure: percentage_female_users {
    type: number
    value_format_name: percent_1
    sql: ${count_female_users} / NULLIF(${count}, 0) ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  last_name,
  first_name,
  order_items1.count,
  orders.count,
  order_items.count,
  events.count
  ]
  }

}
