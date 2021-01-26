# Denoising-Library

Implemented the following basic algorithms for the images having **Gaussian** and **Salt and Pepper** noise

  1. Mean filter
  2. Median filter
  
Checked these methods by adding the Noise on a clear image and then denoising it. The size of the filter is taken close to the size corresponding to the best **PSNR** value

Also implemented the Non-Local means (https://doi.org/10.1109/CVPR.2005.38) for edge preserving smoothing. The user is free to use any of these three methods according to his requirements of speed, smoothing level etc. Though it will be more preferred to use the Median filter for the salt and pepper noise images and not going for the computationally heavy NL means
