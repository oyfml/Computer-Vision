# Computer-Vision Projects:

### Visualisation of 8-point algorithm to determine epipolar lines in stereo pair camera images**

__Steps:__

*1.) Run main.m script*

*2.) Select at least 8 corresponding points in both pair of images*

**Details:**

The eight-point algorithm is an algorithm used in computer vision to estimate the essential matrix or the fundamental matrix related to a stereo camera pair from a set of corresponding image points.

The fundamental matrix completely describes the epipolar geometry of the pair of images, as it represents the relationship between any two images of the same scene that constrains where the projection of points from the scene can occur in both images. Since information loss occurs when a camera image is taken (3D projection to 2D plane), we cannot retrieve any depth information with one camera image. But with a stereo pair of camera images and the fundamental matrix, we can retrieve the depth of objects (points) in the scene.


### Texture Synthesiser by non-parametric sampling (Efros & Leung Algorithm)

__Steps:__

*1.) Run main.m script*

**Details:**
"Hole-filling" or synthesising texture patterns from given input images to generate photo-realistic output images. 

The texture synthesis process grows a new image outward from an initial seed, one pixel at a time. A Markov random field model is assumed, and the conditional distribution of a pixel given all its neighbors synthesized so far is
estimated by querying the sample image and finding all similar neighborhoods. The degree of randomness is controlled
by a single perceptually intuitive parameter. The method
aims at preserving as much local structure as possible and
produces good results for a wide variety of synthetic and
real-world textures.

### PatchMatch

**Details:**




