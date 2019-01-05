# <img src="CUBELOGO.png" width = "160" height = "100"  /> Github Repository For CUBE
## Regularize The Curvature Of Patch Manifold Via Biharmonic Extension


Code for "CUBE: Curvature Regularization Via Weighted Nonlocal BiHarmonic For Image Processing"


### Image Inpainting

(Ground Turth, Inpainting, Sample Rate:20%)

<img src="Fig/bar.png" width = "160" height = "100"  /><img src="Fig/bari.png" width = "160" height = "100"  />

(Ground Turth, W-CUBE:28.56dB, WNLL:27.78dB)

<img src="Fig/bar1.png" width = "200" height = "140"  /><img src="Fig/barCUBE.png" width = "200" height = "140"  /><img src="Fig/barWNLL.png" width = "200" height = "140"  />


PSNR

<img src="Inpainting/PSNR.png" width = "600" height = "300"  />

SSIM

<img src="Inpainting/SSIM.png" width = "600" height = "300"  />

### Semi-supervised Learning

In our test, we label 700, 100, 70, 50 and 35 images in MNIST respectively. The labeled images are selected at random in 70,000 images. For each sampling rate, we take 10 different random samples for comparisons.
<center>
<img src="Fig/average.png" width = "300" height = "200"  />
</center>

### Image Denoising
