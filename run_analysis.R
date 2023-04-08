#Charger les données requises
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)

#Charger les données d'entraînement
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

#Charger les données de test
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

#Fusionner les données d'entraînement et de test
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

#Nommer les colonnes
names(X) <- features[,2]
names(Y) <- "activityId"
names(subject) <- "subjectId"

#Extraire uniquement les mesures sur la moyenne et l'écart type pour chaque mesure
X_mean_std <- X[,grepl("mean()|std()", names(X))]

#Utiliser des noms d'activité descriptifs pour nommer les activités dans l'ensemble de données
Y[,1] <- activity_labels[Y[,1],2]

#Nommer la variable de l'activité
names(Y) <- "activity"

#Etiquetage des donnees avec des noms de variable descriptifs
names(subject) <- "subject"
tidy_data <- cbind(subject, Y, X_mean_std)

#Création d'un deuxième ensemble de données ordonné indépendant avec la moyenne de chaque variable pour chaque activité et chaque sujet
library(dplyr)
tidy_data_avg <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidy_data_avg, "tidy_data_avg.txt", row.names = FALSE)