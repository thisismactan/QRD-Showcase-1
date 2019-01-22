source("Code/library.R")

#### Merges ####
businesses <- fread_to_tbl("Data/businesses.csv")
users <- fread_to_tbl("Data/users.csv")
reviews <- fread_to_tbl("Data/reviews.csv")

user_reviews <- reviews %>%
  left_join(users, by = "user_id")

business_reviews <- businesses %>%
  left_join(user_reviews, by = "business_id") %>%
  mutate(italian = grepl("italian", cuisines, ignore.case = TRUE),
         pizza = grepl("pizza", cuisines, ignore.case = TRUE),
         mexican = grepl("mexican", cuisines, ignore.case = TRUE)) %>%
  filter(state %in% c("AL", "AK", "AR", "AZ", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
                      "MA", "MD", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", 
                      "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")) %>%
  mutate(user_resid = stars - average_stars,
         region = case_when(state %in% c("ME", "NH", "VT", "MA", "RI", "CT", "NY", "NJ", "DE", "MD", "PA") ~ "Northeast",
                            state %in% c("OH", "MI", "IN", "IL", "WI", "MN", "IA") ~ "Midwest",
                            state %in% c("VA", "WV", "NC", "KY", "TN", "SC", "GA", "FL", "AL", "MS", "LA", "AR", "MO", "OK") ~ "South",
                            state %in% c("TX", "NM", "AZ", "NV", "CA") ~ "Southwest",
                            state %in% c("WA", "OR", "ID", "MT", "HI", "AK", "UT", "CO", "ND", "SD", "NE", "KS") ~ "The rest"))

## Filter to Italian/pizza/Mexican
reviews_cuisines <- business_reviews %>%
  filter(italian|pizza|mexican)

reviews_cuisines %>%
  group_by(mexican) %>%
  summarise(average_resid = mean(user_resid, na.rm = TRUE), 
            sd_resid = sd(user_resid, na.rm = TRUE))
