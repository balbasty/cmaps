# cmaps
(Some) Matplotlib colormaps in Matlab


## Usage

```matlab
a = reshape(linspace(0, 1, 256*256), 256, 256);
imshow(a);
colormap(make_colormap('RdBu', 256));
```

## License

This is a pure port of some of the colormaps embedded in Matplotlib.
Matplotlib's license (or the license of the indiviudal colormaps) is retained.
See https://matplotlib.org/stable/users/license.html
