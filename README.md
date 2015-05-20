The script run_analysis.R produces the file tidy.txt from a subset of files in the UCI HAR Dataset folder.

The raw data contains 561 variables, and tidy.txt contains only those variables with either the string "mean" or "std" in their names.  Our first processing, therefore, is to identify the columns with either the string "mean" or "std" in their names, so that only those columns are read from the raw data.

The file feaures.txt contains the names of all 561 raw data variables.  We read these names into an R-object called c, and store a list of the indices that correspond to elements of c containing either the string "mean" or "std" in vector called x.

We use x to create a vector called colClass that has "numeric" at indices that correspond to the values in x, and "NULL" otherwise.  We then read X_train.txt using read.table with colClasses=colClass, read X_test.txt using read.table with colClasses=colClass, and rbind them together in an object called data.  data has 79 columns.

We read y_train.txt and y_test.txt, and rbind them together for a column of activity codes whose length equals the number of rows in data, and cbind this column to data.  This generates column 80 of data.

We do the same thing with subject_train.txt and subject_test.txt.  This generates column 81 of data.

We read activity_labels.txt to create a lookup table to assign descriptive activity names to the activity codes in data. We apply the lookup table to generate column 82 of data. 

At this point, the column names for data are default values such as V17.  We use the vector x to subset the names column of c and assign these names to columns 1 through 79 of data.  We name columns 80:82 of data through direct assignment of descriptive names.

data is now a data frame of dimension 10,299 by 82.  Each row represents measurements for a given subject and activity.  Each subject, activity pair has many rows, so we average these rows by subject and activity using the R aggregate function.
  The result is a data frame called out, which is saved to a file called tidy.txt.


