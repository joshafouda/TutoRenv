# Charger les packages nécessaires
library(dplyr)
library(ggplot2)

# Manipulation de la dataframe iris avec dplyr
iris_summary <- iris %>%
  group_by(Species) %>%
  summarise(
    Sepal.Length.Mean = mean(Sepal.Length),
    Sepal.Width.Mean = mean(Sepal.Width),
    Petal.Length.Mean = mean(Petal.Length),
    Petal.Width.Mean = mean(Petal.Width)
  )

print(iris_summary)

# Création d'un graphique avec ggplot2
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  labs(
    title = "Relation entre la longueur et la largeur des sépales",
    x = "Longueur des sépales",
    y = "Largeur des sépales"
  ) +
  theme_minimal()
