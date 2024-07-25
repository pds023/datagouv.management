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

