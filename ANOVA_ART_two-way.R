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


# ----- SAMPLE: A two-way repeated measures ANOVA with ART (sAB model) ----- #
dat = read.csv("twoway_sample.csv", header=T)

condition   = rep(c("condA","condA","condA","condA","condB","condB","condB","condB"), 10)
session     = rep(c("session1","session2","session3","session4"), 20)
f_condition = factor(condition)
f_session   = factor(session)

# ----- ANOVA ----- #
m       = art(dependent_val ~ f_condition * f_session + (1|Participant) + (1|Participant : f_condition) + (1|Participant : f_session), data=dat)
m_anova = anova(m)

# ----- Post hoc ----- #
# post-hoc: condition
m_posthoc_condition = contrast(emmeans(artlm(m, "f_condition"), ~ f_condition), method="pairwise")

# post-hoc: session
m_posthoc_session   = contrast(emmeans(artlm(m, "f_session"), ~ f_session), method="pairwise")

# post-hoc: condition * session
m_posthoc_condition_session = contrast(emmeans(artlm(m, "f_condition:f_session"), ~ f_condition:f_session), method="pairwise", interaction=TRUE)


# ----- Cohen's d ----- #
# effsize: condition
m_condition = artlm(m, "f_condition")
condition_contrasts_art   = summary(pairs(emmeans(m_condition, ~ f_condition)))
condition_contrasts_art$d = condition_contrasts_art$estimate / sigmaHat(m_condition)

# effsize: session
m_session   = artlm(m, "f_session")
session_contrasts_art   = summary(pairs(emmeans(m_session, ~ f_session)))
session_contrasts_art$d = session_contrasts_art$estimate / sigmaHat(m_session)

# effsize: condition * session
m_condition_session = artlm(m, "f_condition:f_session")
condition_session_contrasts_art   = summary(pairs(emmeans(m_condition_session, ~ f_condition:f_session)))
condition_session_contrasts_art$d = condition_session_contrasts_art$estimate / sigmaHat(m_condition_session)


# ----- Export as text file ----- #
path = "Result/TwoWay/"
if(!dir.exists(path)) {
  dir.create(path, recursive=T)
}

capture.output(m_anova, file=paste(path, "ANOVA_twoway.txt", sep=""))
capture.output(condition_contrasts_art, file=paste(path, "ANOVA_posthoc_twoway_condition.txt", sep=""))
capture.output(session_contrasts_art, file=paste(path, "ANOVA_posthoc_twoway_session.txt", sep=""))
capture.output(condition_session_contrasts_art, file=paste(path, "ANOVA_posthoc_twoway_condition_session.txt", sep="")) 
