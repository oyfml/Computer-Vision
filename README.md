# Computer-Vision Projects:

### (1.) Visualisation of 8-point algorithm to determine epipolar lines in stereo pair camera images

__Steps__  

'''

*1.) Run main.m script*  

*2.) Select at least 8 corresponding points in both pair of images*

'''

**Details:**

> The fundamental matrix completely describes the epipolar geometry of the pair of images, as it represents the relationship between any two images of the same scene that constrains where the projection of points from the scene can occur in both images. Since information loss occurs when a camera image is taken (3D projection to 2D plane), we cannot retrieve any depth information with one camera image. But with a stereo pair of camera images and the fundamental matrix, we can retrieve the depth of objects (points) in the scene.

<br />
<br />

### (2.) Texture Synthesiser by non-parametric sampling (Efros & Leung Algorithm)

__Steps:__

*1.) Run main.m script*

> *- Edit the input to im2double(__); line 13, to specify desired texture file for synthesis*
*Note: Available texture matrices ranges from t1 - t11.*

> *- Edit the 2nd argument for function my_Texture_Synthesiser for desired window size; line 15*

> *Note: Window size must always be odd!*

> *- Edit the last argument for function my_Texture_Synthesiser for desired n-th fold size; line 15*

> *Note: Outputs texture of size [n*r,n*c] from original sample of size [r,c].*
  
**Details:**

> "Hole-filling" or synthesising texture patterns from given input images to generate photo-realistic output images. 

> The texture synthesis process grows a new image outward from an initial seed, one pixel at a time. A Markov random field model is assumed, and the conditional distribution of a pixel given all its neighbors synthesized so far is
estimated by querying the sample image and finding all similar neighborhoods. The degree of randomness is controlled
by a single perceptually intuitive parameter. The method aims at preserving as much local structure as possible and
produces good results for a wide variety of synthetic and
real-world textures.

**Observation:**

> With respect to synthesis quality and accuracy, a relatively smaller window size will output poor texture synthesis as compared to a larger window. This is because the large window will be able to explore more pixels in the neighbourhood which might provide information regarding the patterns evident in the pixel intensity. Such success can be observed in textures like texture 4, where the increased window size shows significant improvement over the small one.
However, the drawback of using a larger window is the longer processing time. By including more details for comparison, computational time will be longer. If image resolution is not of concern, by resizing the sample texture to a smaller size will decrease processing time as well as synthesise a good representation of the sample texture.

<br />
<br />

### (3.) PatchMatch: A Randomized Correspondence Algorithm for Structural Image Editing

__Steps:__

*1.) Run main.m script*

*- Choose size of patch length, p_len*

*- Patch area = p_len x p_len*

*- p_len must be >=1 and odd*

**Details:**

> PatchMatch finds the patch correspondence by defining a nearest-neighbor field (NNF) as a function of offsets, which is over all possible matches of patch (location of patch centers) in image A, for some distance function of two patches D. So, for a given patch coordinate a in image A and its corresponding nearest neighbor b in image B, f(a) is simply b-a. However, if we search for every point in image B, the work will be too hard to complete. So the algorithm follows a randomized approach in order to accelerate the calculation speed. 

> There are three main components. Initially, the nearest-neighbor field is filled with either random offsets or some prior information. Next, an iterative update process is applied to the NNF, in which good patch offsets are propagated to adjacent pixels, followed by random search in the neighborhood of the best offset found so far. Independent of these three components, the algorithm also use a coarse-to-fine approach by building an image pyramid to obtain the better result.

**Observation:**

> In patch match algorithm, the size of patch does not drastically affect computational time, since all possible permutations of patches in A are computed by shifting the patch pixel by pixel. The drawbacks of using large patch size is when reconstruction occurs, the large patch is also extracted from the reference image B, which would show huge
dissimilarities between the input and reconstructed image (as seen in using patch length 9 above), since it is uncommon for large patches of A & B to be similar looking.



