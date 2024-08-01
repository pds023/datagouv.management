

library(data.table)
library(openxlsx)
library(janitor)
library(arrow)

controles_2014 <- as.data.table(clean_names(read.csv2("cnil_controles/data/OpenCNIL_Liste_controles_2014_VD_20150604.csv")))
# controles_2015 <- as.data.table(clean_names(read.csv2("data/OpenCNIL_liste_controles_2015.csv"))) INVALID FILE
controles_2015 <- as.data.table(clean_names(read.xlsx("cnil_controles/data/OpenCNIL_liste_controles_2015.xlsx")))
controles_2016 <- as.data.table(clean_names(read.csv2("cnil_controles/data/OpenCNIL_liste_controles_2016.csv")))
controles_2017 <- as.data.table(clean_names(read.csv2("cnil_controles/data/OpenCNIL_liste_controles_2017.csv")))
controles_2018 <- as.data.table(clean_names(read.csv2("cnil_controles/data/opencnil-liste-controles-2018.csv")))
controles_2019 <- as.data.table(clean_names(read.csv2("cnil_controles/data/opencnil-liste-controles-2019.csv")))
controles_2020 <- as.data.table(clean_names(read.csv2("cnil_controles/data/open-data-controles-2020-vd-20210603.csv")))
controles_2021 <- as.data.table(clean_names(read.csv2("cnil_controles/data/open-data-controles-2021-v20220921.csv")))
controles_2022 <- as.data.table(clean_names(read.csv2("cnil_controles/data/open-data-controles-cnil-2022-v20231003.csv")))

colnames(controles_2014) <- c("annee","type","organisme_controle","lieu","dep","secteur")
controles_2014[,modalite_controle := ""]
controles_2014[,pays := ""]

colnames(controles_2015) <- c("annee","type","organisme_controle","lieu","dep","secteur")
controles_2015[,modalite_controle := ""]
controles_2015[,pays := ""]

controles_2016 <- controles_2016[,.(annee,type_de_controle,organismes,lieu_de_controle,departement,secteur_d_activite_de_l_organisme)]
colnames(controles_2016) <- c("annee","type","organisme_controle","lieu","dep","secteur")
controles_2016[,modalite_controle := ""]
controles_2016[,pays := ""]

colnames(controles_2017) <- c("type","modalite_controle","organisme_controle","dep","lieu","secteur")
controles_2017[,annee := 2017]
controles_2017[,pays := ""]

colnames(controles_2018) <- c("type","modalite_controle","organisme_controle","dep","lieu","secteur")
controles_2018[,annee := 2018]
controles_2018[,pays := ""]

colnames(controles_2019) <- c("type","modalite_controle","organisme_controle","dep","lieu","secteur")
controles_2019[,annee := 2019]
controles_2019[,pays := ""]

colnames(controles_2020) <- c("type","modalite_controle","organisme_controle","dep","lieu","secteur")
controles_2020[,annee := 2020]
controles_2020[,pays := ""]

controles_2021 <- controles_2021[,.(categorie_de_controle,modalite_de_controle,organismes_controles,dept,ville,pays,activite_de_l_organisme)]
colnames(controles_2021) <- c("type","modalite_controle","organisme_controle","dep","lieu","pays","secteur")
controles_2021[,annee := 2021]

controles_2022 <- controles_2022[,.(categorie_de_controle,modalites_de_controle,organismes_controles,dept,ville,pays,activite_de_l_organisme)]
colnames(controles_2022) <- c("type","modalite_controle","organisme_controle","dep","lieu","pays","secteur")
controles_2022[,annee := 2022]

controles_2014_2022 <- rbind(controles_2014,controles_2015,
                             controles_2016,controles_2017,
                             controles_2018,controles_2019,
                             controles_2020,controles_2021,
                             controles_2022)
write_parquet(controles_2014_2022,"cnil_controles/data/cnil_controles_2014_2022.parquet")

