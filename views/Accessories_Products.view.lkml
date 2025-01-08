include: "products.view"

view: accessories_products {

  extends: [products] # Extending the base products view

  # Custom Dimensions
  dimension: is_accessory {
    type: string
    sql: ${category} = "Accessories" ;; # True if the product is in the Accessories category
  }

  dimension: is_women_department {
    type: yesno
    sql: ${department} = "Women" ;; # True if the product belongs to the Women's department
  }

}
