# If necessary, uncomment the line below to include explore_source.
# include: "ecommerce_training_model.model.lkml"

view: order_count {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: count {}
    }
  }
  dimension: order_id {
    description: ""
    type: number
  }
  dimension: count {
    description: ""
    type: number
  }
}
