# The name of this view in Looker is "Products"
view: products {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `thelook_ecommerce.products` ;;
  drill_fields: [id,brand,category]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Brand" in Explore.

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    drill_fields: [id,category]
    link: {
      label: "Get More Information"
      url: "http://www.google.com/search?q={{ category }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Mail office"
      url: "mailto:{{value}}@elementrental.com"
      icon_url: "https://ssl.gstatic.com/ui/v1/icons/mail/rfr/gmail.ico"
    }
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    suggestions: ["Jeans","Dresses"]
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;

    action: {
      label: "Send customer a poke"
      icon_url: "http://google.com/favicon.ico"
      url: "https://example.com"

      param: {
        name: "id"
        value: "{{value}}"
      }

      form_param: {
        name: "message"
        type: string
        label: "Message"
        description: "This is the message that you want to send to the customer"
      }

      }

  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: sum_retail_price {
    type: sum
    sql: ${TABLE}.retail_price ;;
  }

  measure: total_cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }
  measure: count {
    type: count
    drill_fields: [id,department,distribution_center_id]
   # drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  name,
  distribution_centers.name,
  distribution_centers.id,
  order_items1.count,
  inventory_items.count,
  order_items.count
  ]
  }

}
