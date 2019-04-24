## How to run
All the matlab source codes are in the code folder. The code folder also contains a folder `images` which contains all the images I choose (from 1 to 20) and the photos taken of my self in the folder `me`.

### 1. PCA
Inside the `code` folder, run
```
pca()
```
It will first load the images, and then generate the PCs. It will do 2D and 3D visualization and plot the 3 eigen faces. It will then project the images into dimensionality of 40, 80 and 200 and do classification using nearest neighbors. All the steps are described in the comments of the code.

### 2. LDA
Inside the `code` folder, run
```
lda()
```
It will first load the images, and then generate the LDA. It will do 2D and 3D visualization. It will then project the images into dimensionality of 2, 3 and 9 and do classification using nearest neighbors. All the steps are described in the comments of the code.

### 3. SVM
Inside the `code` folder, run
```
[acc_origin, acc_80, acc_200] = svm(C)
```
It will first load the images and use SVM to do classification and output the accuracy. It will then do PCA to get the PCs. It will use the PCs to project the data into dimensionality of 80 and 200. It will use SVM to do classification on these dimensionality 80 and 200 data and output the accuracy.

### 4. CNN
Inside the `code` folder, run
```
accuracy = cnn()
```
It will use CNN to do classification on the image data and output the accuracy.
