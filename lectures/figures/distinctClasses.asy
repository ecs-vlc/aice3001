import myutil;
import stats;
size(200,0);

pen col[] = {red, green, blue};
pair centres[] = {(0,0), (1,0.6), (0.5, 2)};
pair sd[] = {(0.1, 0.3), (0.15, 0.2), (0.1, 0.3)};

pair randPos(pair c, pair sd) {
  return c + (sd.x*Gaussrand(), sd.y*Gaussrand());
}

for(int i=0; i<col.length; ++i) {
  for(int j=0; j<20; ++j) {
    dot(randPos(centres[i], sd[i]), col[i]+linewidth(4));
  }
}
