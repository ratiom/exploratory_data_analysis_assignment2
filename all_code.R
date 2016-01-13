

### Import data
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)
NEI$SCC <- as.factor(NEI$SCC)

annual_emission_sum <- tapply(NEI$Emissions, NEI$year, sum)
years <- as.numeric(levels(NEI$year))
q1 <- rbind(annual_emission_sum, years)
barplot(q1)

balti <- subset(NEI, fips=='24510')
annual_emission_balti <- tapply(balti$Emissions, balti$year, sum)
q2 <- rbind(annual_emission_balti, years)
barplot(q2)

type_emission_balti <- as.numeric(tapply(balti$Emissions, balti$type, sum))
q3 <- as.data.frame(cbind(as.numeric(type_emission_balti), levels(balti$type)))
p3 <- ggplot(q3, aes(x=q3$V2, y=q3$V1)) + geom_bar(stat = "identity")

coal <- SCC[grep('Coal', SCC$Short.Name),]
NEICoal <- NEI[NEI$SCC %in% coal$SCC,]

Balti_mobile <- NEI[NEI$SCC %in% SCC_mobile$SCC & NEI$fips=='24510',]
