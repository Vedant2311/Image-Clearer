# Deblurring-Library

Implemented the Deblurring using Weiner filter. Used it for the following cases

  1. Known Noise and Blur
  
      * Blurred the clean image with a disk-shaped point spread function h(x,y), i.e. constant inside a disk and zero outside, and normalized so the coefficients sum to 1. Add Gaussian noise η(x,y) of some chosen variance.
      * Then performed deblurring using the Wiener filter. For this, it is needed to provide an estimate of the desired image’s spectrum |F(u,v)|. Experimented with different choices: 
      
        * use the ground-truth spectrum from the original image 
        * use |F(u,v)|= const 
        * use |F(u,v)|∝(√u2+v2)^α for some manually chosen α that best fits the ground-truth spectrum

2. Unknown Noise and Blur

    * First of all, the noise variation of the image is obtained from locating a uniform location
    * Then, it is approximated to be a gaussian noise with that std deviation
    * Then, the blur is estimated by finding the image of a point light source to estimate the PSF (this can also be done by choosing a blur model manually and then fitting it's parameters to the features in the image)
    * Then, the SNR is approximated for the image by applying the inverse filtering on the input image and then adding the gaussian noise of the obtained variance and then computing their SNR 
    * Then, this SNR value is used in the Weiner filter and the final image is obtained
    
An Edge preserving smoothing method is incorporated for deblurring by taking the Total Variation regularized deconvolution approach, which results in a non-smooth optimization problem, which is solved effectively with the **ADMM** algorithm (http://stanford.edu/class/ee367/reading/lecture6_notes.pdf)
    
