#### WARNING: DO NOT ATTEMPT TO RUN THIS. ####

source("Code/library.R")

#### Import JSON files ####
users <- ndjson::stream_in("Data/yelp_academic_dataset_user.json") 
businesses <- ndjson::stream_in("Data/yelp_academic_dataset_business.json") 

businesses_small <- businesses %>%
  as.data.frame() %>%
  dplyr::select(name, business_id, state, postal_code, open = is_open, attire = attributes.RestaurantsAttire, 
                price = attributes.RestaurantsPriceRange2, cuisines = categories)

users_small <- users %>%
  dplyr::select(user_id, start_date = yelping_since, reviews = review_count, average_stars)

## Handle reviews separately
reviews <- fread_to_tbl("Data/reviews_full.csv")
reviews_small <- reviews %>%
  mutate(date = as.Date(date)) %>%
  dplyr::select(business_id, user_id, review_id, date, stars)

## Full datasets
write.csv(users, "Data/users_full.csv", row.names = FALSE)
write.csv(businesses, "Data/businesses_full.csv", row.names = FALSE)

## Selected variables
write.csv(users_small, "Data/users.csv", row.names = FALSE)
write.csv(businesses_small, "Data/businesses.csv", row.names = FALSE)
write.csv(reviews_small, "Data/reviews.csv", row.names = FALSE)
