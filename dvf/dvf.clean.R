# Fonction pour installer un package s'il n'est pas déjà installé
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Installer les packages si nécessaire
packages <- c("openxlsx", "data.table", "arrow", "janitor")
for (pkg in packages) {
  install_if_missing(pkg)
}

# Charger les packages une fois installés
library(openxlsx)
library(data.table)
library(arrow)
library(janitor)

save_dvf_parquet <- function(annee){
  data <- fread(paste0("dvf/data/valeursfoncieres-",annee,".txt"),sep = "|")
  
  data <- clean_names(data)
  data[,valeur_fonciere := gsub(pattern = ",",replacement = ".",x = valeur_fonciere)][,valeur_fonciere := as.numeric(valeur_fonciere)]
  data[,annee := annee]
  write_parquet(data,paste0("dvf/data/valeurs_foncieres-",annee,".parquet"))
}
save_dvf_parquet(2019)
save_dvf_parquet(2020)
save_dvf_parquet(2021)
save_dvf_parquet(2022)
save_dvf_parquet(2023)

data19 <- as.data.table(read_parquet("dvf/data/valeurs_foncieres-2019.parquet"))
data20 <- as.data.table(read_parquet("dvf/data/valeurs_foncieres-2020.parquet"))
data21 <- as.data.table(read_parquet("dvf/data/valeurs_foncieres-2021.parquet"))
data22 <- as.data.table(read_parquet("dvf/data/valeurs_foncieres-2022.parquet"))
data23 <- as.data.table(read_parquet("dvf/data/valeurs_foncieres-2023.parquet"))

data <- rbind(data19,data20,data21,data22,data23)
write_parquet(data,"dvf/data/valeurs_foncieres-2019-2023.parquet")
