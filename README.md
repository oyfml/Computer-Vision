# Computer-Vision Projects

## Visualisation of 8-point algorithm to determine epipolar lines in stereo pair camera images.

__Steps:__

1.) Run main.m file

2.) Select at least 8 corresponding points in both pair of images

** Details:**

The eight-point algorithm is an algorithm used in computer vision to estimate the essential matrix or the fundamental matrix related to a stereo camera pair from a set of corresponding image points.

The fundamental matrix completely describes the epipolar geometry of the pair of images, as it represents the relationship between any two images of the same scene that constrains where the projection of points from the scene can occur in both images. Since information loss occurs when a camera image is taken (3D projection to 2D plane), we cannot retrieve any depth information with one camera image. But with a stereo pair of camera images and the fundamental matrix, we can retrieve the depth of objects (points) in the scene.



