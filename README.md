# lajolla
UCSD CSE 272 renderer

# Build
All the dependencies are included. Use XMake to build, try
```sh
xmake
```

# Run
Try 
```sh
xmake run
# xmake run lajolla scenes/cbox/cbox.xml
```
This will generate an image "image.exr".

To view the image, use [hdrview](https://github.com/wkjarosz/hdrview), or [tev](https://github.com/Tom94/tev).

# Acknowledgement
The renderer is heavily inspired by [pbrt](https://pbr-book.org/), [mitsuba](http://www.mitsuba-renderer.org/index_old.html), and [SmallVCM](http://www.smallvcm.com/).

We use [Embree](https://www.embree.org/) for ray casting.

We use [pugixml](https://pugixml.org/) to parse XML files.

We use [pcg](https://www.pcg-random.org/) for random number generation.

We use [stb_image](https://github.com/nothings/stb) and [tinyexr](https://github.com/syoyo/tinyexr) for reading & writing images.

We use [miniz](https://github.com/richgel999/miniz) for compression & decompression.

Many scenes in the scenes folder are directly downloaded from [http://www.mitsuba-renderer.org/download.html](http://www.mitsuba-renderer.org/download.html). Scenes courtesy of Wenzel Jakob, Cornell Program of Computer Graphics, Marko Dabrovic, Eric Veach, Jonas Pilo, and Bernhard Vogl.
