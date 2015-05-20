# read column names into data frame c
c=read.table("features.txt", stringsAsFactors=FALSE)

# identify columns that contain mean or std
x1=grep("mean",c[,2])
x2=grep("std",c[,2])

# x contains the columns to retain
x=sort(union(x1,x2))

# use x to identify columns to retain on input
colClass=rep("NULL",nrow(c))
colClass[x]="numeric"

# merge train and test set
data=read.table("X_train.txt", colClasses=colClass)
data1=read.table("X_test.txt", colClasses=colClass)
data=rbind(data, data1)

# merge activity codes for data
y=read.table("y_train.txt")
y1=read.table("y_test.txt")
y=rbind(y,y1)

# add activity codes column to data
data=cbind(data,y)

# merge subject codes for data
s=read.table("subject_train.txt")
s1=read.table("subject_test.txt")
s=rbind(s,s1)

# add subject codes column to data
data=cbind(data,s)

# read activity labels
a=read.table("activity_labels.txt")

# add new column to data with activity labels correspnding to activity codes
data[,82]=a$V2[y[,1]]

# add descriptive variable names to columns of data

# get numeric column names from data frame c
names(data)[1:length(x)]=c[,2][x]

# next columns hold activity code, subject and activity labels
names(data)[(length(x)+1):(length(x)+3)]=c("activity_code", "subject", "activity_label")

# aggregate data using mean by subject and activity
out=aggregate(data[,1:length(x)], by=list(data$activity_label, data$subject), FUN=mean, na.rm=TRUE)
names(out)[1:2]=c("activity", "subject")

# write out to file tidy.txt
write.table(out, file="tidy.txt", row.names=FALSE)











