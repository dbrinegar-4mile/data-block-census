include: "/views/*"
include: "/maps/map_layers.lkml"

view: congressional_district {
  extends: [gender, education, employment, population, commute, family]
  sql_table_name: `bigquery-public-data.census_bureau_acs.congressionaldistrict_2018_5yr` ;;


  dimension: congressional_district {
    primary_key: yes
    sql: ${TABLE}.geo_id ;;
    view_label: "Geography"

    map_layer_name: congressional_districts
  }

  dimension: state_key {
    hidden: yes
    sql: SUBSTR(CAST(${congressional_district} as STRING),0,2)  ;;
  }

  dimension: congressional_district_median_income_dim {
    sql: ${TABLE}.median_income ;;
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: usd
    hidden: yes
  }

  dimension: congressional_district_median_year_structure_built_dim {
    sql: ${TABLE}.median_year_structure_built ;;
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: congressional_district_median_rent_dim {
    sql: ${TABLE}.median_rent ;;
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: usd
    hidden: yes
  }

  dimension: congressional_district_gross_rent_dim {
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: usd
    hidden: yes
  }

  measure: congressional_district_median_rent {
    sql: MAX(${congressional_district_median_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: usd
  }

  measure: congressional_district_median_income {
    sql: MAX(${congressional_district_median_income_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: usd
  }

  measure: congressional_district_median_year_structure_built {
    sql: MAX(${congressional_district_median_year_structure_built_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: decimal_0
  }

  measure: congressional_district_gross_rent {
    sql: MAX(${congressional_district_gross_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Congressional District"
    value_format_name: usd
  }


}
