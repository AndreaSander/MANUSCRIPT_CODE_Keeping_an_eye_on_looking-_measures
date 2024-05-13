############################################
### Autocorrelation function source file ###
############################################

# This script provides a function that is used in Section 3 of the main script

# The function needs the name of the input dataframe (dat), a vector of participant
# IDs, the name of the variable in the dataframe where experimental item numbers
# are stored (item_name), the name of the variable where timestamps are saved
# (time_name), and the number of lags from the first timestamp for which 
# autocorrelation should be computed.

autocor.binom <- function(dat, subject_id_vector, item_name, time_name, Nlags){
  
  PCM2 <- matrix(NA,nrow=length(subject_id_vector), ncol=Nlags)
  
  for (j in 1:length(subject_id_vector)) { 
    print(paste0(j,"/",length(subject_id_vector)))
    tmp <- dat %>% filter(Participant==subject_id_vector[j])
    tmp <- arrange(tmp, tmp[[item_name]], tmp[[time_name]])
    tmp <- tmp %>% group_by(!!time_name) %>% mutate(nI=1:length(pTarget))
    tmp$pT  <- tmp$pTarget
    
    for(k in 1:Nlags){
      ln <- paste0("pT", k)
      tmp[[ln]] <- lag(tmp$pT, k)
      tmp[[ln]][tmp$nI %in% c(1:k)] <- NA
    }
    
    for(m in 1:Nlags){
      
      lagno <- paste0("pT", m)
      PCM2[j,m] <- suppressWarnings(polychor(tmp$pT, tmp[[lagno]]))
      
    }
    
  }
  
  d_plot <<- data.frame(lag=0:Nlags, 
                        cor=c(1,colMeans(PCM2, na.rm=TRUE)),
                        se =c(0,apply(PCM2, 2, 
                                      function(x) sd(x, na.rm=TRUE)/sqrt(sum(!is.na(x))))))
  
}