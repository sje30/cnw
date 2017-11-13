## Read in the faces data.

using(MAT)
vars = matread("FaceA-v73.mat")
i1 = vars["FaceA"]
heatmap(i1)
using Plots
pyplot()
heatmap(0:0.1:1, 0:0.2:2, (x,y) -> e^-(x+y))
heatmap(z)
x = 0:0.1:1; y=0:0.2:2
heatmap(x,y, (x,y) -> e^-(x+y))

xs = [string("x",i) for i = 1:10]
ys = [string("y",i) for i = 1:4]
z = linspace(1.0, 4.0, 10) * linspace(1.0, 4.0,  30)'
spy(z)
heatmap(z,aspect_ratio=1)
