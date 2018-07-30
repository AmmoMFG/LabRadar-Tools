#
# This was the R-code I used to generate some of the reports. It's in serious need of revision, and being formatted as an actual loop
#  I'm still kinda new to this part of R, so deal with it.
#


#read the data into observation matrix
SHOT_0010 <- read.delim("~/StatBallistics/S-0010.tsv", header=TRUE)

#Plot it
plot(SHOT_0010$Time.s., SHOT_0010$Shot.1, type="l", main="Velocity/Time: Shot Series 10 (PMC)", ylab="Velocity (FPS)", xlab="Time of Flight (S)",col = "1")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.2, col="2")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.3, col="3")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.4, col="4")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.5, col="5")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.6, col="6")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.7, col="7")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.8, col="8")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.9, col="9")
lines(SHOT_0010$Time.s., SHOT_0010$Shot.10, col="10")
legend("topright", c("Shot 1","Shot 2","Shot 3","Shot 4","Shot 5","Shot 6","Shot 7","Shot 8","Shot 9","Shot 10"),fill=c(1:10))
