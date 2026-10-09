size(210,0);

draw(rotate(-30)*((0,0)--(0,1)), Arrow);
draw(rotate(-30)*((-1,0)--(1,0)), linewidth(1.5));
draw(rotate(-30)*((0.2,0)--(0.2,0.2)--(0,0.2)));
draw(rotate(-30)*((-1,-0.3)..(0,0)..(1,-0.3)), brown);
label("$\{\mathbf{x}\vert (\mathbf{x}-\mathbf{x}_0)^T\mathbf{\nabla}f(\mathbf{x}_0)=0\}$", rotate(-30)*(-1,0),W);
label("$\mathbf{\nabla}f(\mathbf{x}_0)$",  rotate(-30)*(0,1), E);
dot((0,0));
label("$\mathbf{x}_0$", (0,0), SW);
