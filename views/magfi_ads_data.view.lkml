view: magfi_ads_data {
  sql_table_name: `rabia-sandbox-336410.thelook_ecommerce.magfi_ads_data` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: advertisement_id {
    type: number
    sql: ${TABLE}.advertisement_id ;;
  }
  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }
  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }
  dimension: conversion {
    type: number
    sql: ${TABLE}.conversion ;;
  }
  dimension: cpa {
    type: number
    sql: ${TABLE}.cpa ;;
  }
  dimension: cpc {
    type: number
    sql: ${TABLE}.cpc ;;
  }
  dimension: cpm {
    type: number
    sql: ${TABLE}.cpm ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year,month_name,day_of_week,week_of_year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: ctr {
    type: number
    sql: ${TABLE}.ctr ;;
  }
  dimension: cvr {
    type: number
    sql: ${TABLE}.cvr ;;
  }
  dimension: deleted_at {
    type: string
    sql: ${TABLE}.deleted_at ;;
  }
  dimension: group_id {
    type: number
    sql: ${TABLE}.group_id ;;
  }
  dimension: spending {
    type: number
    sql: ${TABLE}.spending ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  dimension: views {
    type: number
    sql: ${TABLE}.views ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
  measure: total_click {
    type: sum
    sql: ${TABLE}.clicks ;;
  }
  measure: total_view {
    type: sum
    sql: ${TABLE}.views ;;
  }
  measure: total_spending {
    type: sum
    sql: ${TABLE}.spending ;;
  }
  measure: sum_cpa {
    type: sum
    sql: ${TABLE}.cpa ;;
  }
  measure: sum_cpc {
    type: sum
    sql: ${TABLE}.cpc ;;
  }
  measure: sum_cpm {
    type: sum
    sql: ${TABLE}.cpm ;;
  }
  measure: sum_ctr {
    type: sum
    sql: ${TABLE}.ctr ;;
  }
  measure: sum_cvr {
    type: sum
    sql: ${TABLE}.cvr ;;
  }
}
