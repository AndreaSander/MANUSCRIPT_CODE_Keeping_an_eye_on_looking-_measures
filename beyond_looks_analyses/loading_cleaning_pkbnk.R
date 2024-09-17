
# remotes::install_github("peekbank/peekbankr")
library(peekbankr)
library(dplyr)
library(tidyr)
library(dbplyr)


#Get peekbank data 

adams_marchmann<- get_aoi_timepoints(dataset_name = "adams_marchman_2018") %>%
  left_join(get_administrations(dataset_name ="adams_marchman_2018")) %>%
  left_join(get_trials(dataset_name = "adams_marchman_2018")) %>%
  left_join(get_trial_types(dataset_name = "adams_marchman_2018")) %>%
  left_join(get_stimuli(dataset_name = "adams_marchman_2018"))
