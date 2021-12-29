# ----- ANOVA with ART Sample: One-way ----- #
# Created: 2021/2/11
# Author: Takayoshi Hagiwara (Graduate School of Media Design, Keio University)
#
# Environment
#   - R 4.0.2 or later
#
# Reference
# Wobbrock, J. O., Findlater, L., Gergle, D., & Higgins, J. J. (2011). 
# The aligned rank transform for nonparametric factorial analyses using only ANOVA procedures. 
# In Proceedings of the SIGCHI Conference on Human Factors in Computing Systems, 143-146.

# Setup (If the installation is not yet complete)
# install.packages("ARTool")
# install.packages("phia")
# install.packages("emmeans")
# install.packages("effsize") # Optional

library(ARTool)
library(phia)
library(emmeans)
library(effsize) # (Optional)

effsize_cliff = F # (Optional)


# ----- SAMPLE: A one-way repeated measures ANOVA with ART ----- #
dat = read.csv("oneway_sample.csv", header=T)
condition   = rep(c("cond1","cond2","cond3"), 10)
f_condition = factor(condition)

# ----- ANOVA ----- #
m       = art(dependent_val ~ f_condition + (1|participant), data=dat)
m_anova = anova(m)

# -----Post-hoc ----- #
m_posthoc = contrast(emmeans(artlm(m, "f_condition"), ~ f_condition), method="pairwise")

# ----- Cohen's d ----- #
m_condition = artlm(m, "f_condition")
condition_contrasts_art   = summary(pairs(emmeans(m_condition, ~ f_condition)))
condition_contrasts_art$d = condition_contrasts_art$estimate / sigmaHat(m_condition)


# ----- Export as text file ----- #
path = "Result/OneWay/"
if(!dir.exists(path)) {
  dir.create(path, recursive=T)
}

capture.output(m_anova, file=paste(path, "ANOVA_oneway.txt", sep=""))
capture.output(condition_contrasts_art, file=paste(path, "ANOVA_posthoc_oneway.txt", sep="")) 


# ------------------------------ #
# (Optional) Effect size for Non-parametric (Cliff's delta)
if(effsize_cliff) {
  dat = read.csv("oneway_sample.csv", header=T)
  effsize_12 = cliff.delta(dat[dat$condition == 0, "dependent_val"], dat[dat$condition == 1, "dependent_val"])
  effsize_13 = cliff.delta(dat[dat$condition == 0, "dependent_val"], dat[dat$condition == 2, "dependent_val"])
  effsize_23 = cliff.delta(dat[dat$condition == 1, "dependent_val"], dat[dat$condition == 2, "dependent_val"])
  
  # ----- Export as text file ----- #
  path = "Result/OneWay/"
  if(!dir.exists(path)) {
    dir.create(path, recursive=T)
  }
  
  capture.output(effsize_12, file=paste(path, "effsize_cliff_12.txt", sep=""))
  capture.output(effsize_13, file=paste(path, "effsize_cliff_13.txt", sep=""))
  capture.output(effsize_23, file=paste(path, "effsize_cliff_23.txt", sep="")) 
}