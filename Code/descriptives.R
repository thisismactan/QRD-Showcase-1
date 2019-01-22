source("Code/merge_data.R")

#### Descriptives ####

## Overlaid histogram of user residual
reviews_cuisines %>%
  ggplot(aes(x = user_resid, fill = as.factor(mexican))) +
  geom_density(col = "black", alpha = 0.5, position = "identity") +
  scale_fill_manual(name = "Cuisine", labels = c("Italian/pizza", "Mexican"), values = c("red", "green4")) +
  labs(title = "The Mexican-Italian Culinary Smackdown",
       subtitle = "User preferences from Yelp reviews",
       x = "Review stars - user average stars",
       y = "Count")

## Overlaid histogram of stars
reviews_cuisines %>%
  ggplot(aes(x = stars, fill = as.factor(mexican))) +
  geom_bar(aes(y = ..prop..), col = "black", alpha = 0.5, position = "dodge2") +
  scale_fill_manual(name = "Cuisine", labels = c("Italian/pizza", "Mexican"), values = c("red", "green4")) +
  labs(title = "The Mexican-Italian Culinary Smackdown",
       subtitle = "User preferences from Yelp reviews",
       x = "Stars",
       y = "Proportion")

# By region
reviews_cuisines %>%
  ggplot(aes(x = stars, fill = as.factor(mexican))) +
  facet_wrap(~region) + 
  geom_bar(aes(y = ..prop..), col = "black", alpha = 0.5, position = "dodge2") +
  scale_fill_manual(name = "Cuisine", labels = c("Italian/pizza", "Mexican"), values = c("red", "green4")) +
  labs(title = "The Mexican-Italian Culinary Smackdown",
       subtitle = "User preferences from Yelp1 reviews",
       x = "Stars",
       y = "Proportion")

## Some light regressions
stars.lm <- lm(stars~mexican, data = reviews_cuisines)
resid.lm <- lm(user_resid~mexican, data = reviews_cuisines)

stars_region.lm <- lm(stars~mexican*region, data = reviews_cuisines)
resid_region.lm <- lm(user_resid~mexican*region, data = reviews_cuisines)

## Displaying these as pivot tables
reviews_cuisines %>%
  group_by(region) %>%
  mutate(n = n()) %>%
  group_by(mexican, region) %>%
  summarise(stars = mean(stars, na.rm = TRUE),
            n = mean(n, na.rm = TRUE)) %>%
  spread(mexican, stars)

reviews_cuisines %>%
  group_by(region) %>%
  mutate(n = n()) %>%
  group_by(mexican, region) %>%
  summarise(resid = mean(user_resid, na.rm = TRUE),
            n = mean(n, na.rm = TRUE)) %>%
  spread(mexican, resid)
