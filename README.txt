==================================================================
Analysis of Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Brandon Brunner
Johns Hopkins University (kind of)
email@email.com
123-456-7890
"People who put quotes in their signatures are dumb" ~Unknown source
==================================================================

This folder contains the following:
--README.txt
This file.  Obviously.

--UCI HAR Dataset
"Raw" data.  See below for info and citation.  "Raw" because it was the data given, but the readme gives details of the processing that went into the dataset, particularly filtering and frequency-domain processing.

--OutputData: 
Processed data.  See below for description.

--run_analysis.R: 
Beautifully commented source code that yields everything in OutputData.

--Codebook.pdf:
The list of all variables, what their units are, how they were derived, etc.

UCI HAR Dataset used with permission from the Johns Hopkins Data Science Specialization in Coursera.  Original data provided by [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

==================================================================
OutputData
==================================================================

--1merged.csv
The dataframe from question 1.  It is a merged set between the test and training data from the raw data.  Variable names have been tidied up all pretty.  The Subject and Activity variables have also been joined.

--2mean.csv
The dataframe from question 2, where the mean measurements were requested.

--2sd.csv
The dataframe from question 2, where the [you guessed it] standard deviation measurements were requested.

--5Activity.csv
The dataframe from question 5, which summarized by the activity (see the code book for more information)

--5Subject.csv
The dataframe from question 5, which summarized by [bet you didn't see this one coming] the subject (see the code book for more information)

--averages.txt
A text file that merges 5Activity.csv and 5Subject.csv.  Row names were removed per given requirement.


==================================================================
UCI HAR Dataset
==================================================================


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws