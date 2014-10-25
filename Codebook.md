Codebook
========================================================
The final_dataset.txt is the result of running the script *run_analyis.R* to the dataset available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Please note that after the data processing, all values of the resulting dataset are averages per subject.**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals *time accelerometer-XYZ* and *time gyroscope-XYZ*. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (*time body acceloremeter-XYZ* and *time Gravity acceloremeter-XYZ*) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (*time Body  acceloremeter jerk signal-XYZ* and *time Body gyroscope jerk signal-XYZ*). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (*time Body  acceloremeter magnitude*, *time Gravity  acceloremeter magnitude*, *time Body gyroscope jerk signal-XYZ*, *time Body gyroscope magnitude*, *time Body gyroscope jerk signal magnitude*). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing *frequency domain signal Body acceloremeter -XYZ*, *frequency domain signal Body  acceloremeter jerk signal-XYZ*, *frequency domain signal Body gyroscope -XYZ*, *frequency domain signal Body acceloremeter jerk signal magnitude*, *frequency domain signal Body gyroscope magnitude*, *frequency domain signal Body gyroscope jerk signal magnitude*. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


* time body acceloremeter -XYZ
* time Gravity acceloremeter-XYZ
* time Body  acceloremeter jerk signal-XYZ
* time Body gyroscope -XYZ
* time Body gyroscope jerk signal-XYZ
* time Body  acceloremeter magnitude
* time Gravity  acceloremeter magnitude
* time Body acceloremeter jerk signal magnitude
* time Body gyroscope magnitude
* time Body gyroscope jerk signal magnitude
* frequency domain signal Body acceloremeter -XYZ
* frequency domain signal Body  acceloremeter jerk signal-XYZ
* frequency domain signal Body gyroscope -XYZ
* frequency domain signal Body acceloremeter magnitude
* frequency domain signal Body acceloremeter jerk signal magnitude
* frequency domain signal Body gyroscope magnitude
* frequency domain signal Body gyroscope jerk signal magnitude


The set of variables that were estimated from these signals are: 

* Mean value
* Standard deviation

