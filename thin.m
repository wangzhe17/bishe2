function thinGraphic=thin(graphic)

se=strel('disk',7);
B=imdilate(graphic,se);

B=~B;
[A,B]=zhang(B);
se1=strel('disk',7);
B=imerode(B,se1);
se2=strel('disk',5);
B=imerode(B,se2);
[A,B]=zhang(B);
B=thinner(B);
thinGraphic=B;