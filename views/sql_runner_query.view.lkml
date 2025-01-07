
view: sql_runner_query {
  derived_table: {
    sql: SELECT
          users.id  AS users_id,
          orders.order_id  AS orders_order_id,
          COUNT(DISTINCT orders.order_id ) AS orders_count
      FROM `thelook_ecommerce.order_items`  AS order_items
      LEFT JOIN `thelook_ecommerce.users`  AS users ON order_items.user_id = users.id
      LEFT JOIN `thelook_ecommerce.orders`  AS orders ON order_items.order_id = orders.order_id
      GROUP BY
          1,
          2
      ORDER BY
          3 DESC
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.users_id ;;
  }

  dimension: orders_order_id {
    type: number
    sql: ${TABLE}.orders_order_id ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.orders_count ;;
  }

  set: detail {
    fields: [
        users_id,
  orders_order_id,
  orders_count
    ]
  }
}
