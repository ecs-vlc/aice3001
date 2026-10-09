size(300,0);

path[] paths ={(4,0)--(0,3), (0,2)--(5,5), (2,4)--(8,4), (6,5)--(9,1), (9,3)--(2,0)};

fill(buildcycle(paths[0],paths[1],paths[2],paths[3],paths[4]), lightgray);

for (int i=0; i<paths.length; ++i) {
  draw(paths[i]);
}

