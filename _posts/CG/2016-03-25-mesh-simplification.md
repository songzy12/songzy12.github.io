---
layout: post
title: "Mesh Simplification"
date: 2016-03-25 11:51:15 +0800
comments: true
categories: C++

---

## Triangle

```
class Triangle{
public:
	Vertex *vertex[3];
	
	Vec3f normal;
	double M[4][4];
	
	Triangle(Vertex *v0, Vertex *v1, Vertex *v2);
	~Triangle();
	
	void ComputeNormalMatrix();
};
```

### normal

```
Vec3f v0=vertex[0]->position;
Vec3f v1=vertex[1]->position;
Vec3f v2=vertex[2]->position;
normal = Cross(v1-v0, v2-v0);
normal.Normalize();
```

### M

```
double temp[4]={ normal.x, normal.y, normal.z,
	-(normal.x * vertex[0]->position.x 
	+ normal.y * vertex[0]->position.y 
	+ normal.z * vertex[0]->position.z)};
for(int i=0;i<4;i++){
	for(int j=0;j<4;j++){
		M[i][j] = temp[i] * temp[j];
	}
}
```

## Vertex

```
class Vertex{
public:
	int index;
	Vec3f position;
	bool deleted;

	std::vector<Edge *> pairs;
	std::vector<Triangle *> faces;
	std::vector<Vertex *> neighbors;

	double Q[4][4];
	void ComputeMatrix();

	Vertex(Vec3f v);
	void CleanNeighbor(Vertex *u);
	~Vertex();
};
```

### Q

```
for(int i=0; i<4; i++)
	for (int j=0; j<4; j++)
		Q[i][j]=0;
for(int i=0; i<4; i++)
	for(int j=0; j<4; j++)
		for(std::vector<Triangle *>::iterator iter=faces.begin(); iter!=faces.end(); iter++)
			Q[i][j] += (*iter)-> M[i][j];
```

## Edge

```
class Edge{
public:
	Vertex *vertex[2];
	
	double Q[4][4];
	double cost;
	Vec3f vbar;
	bool deleted;

	void ComputeMatrix();
    double ComputeCost(Vec3f v);
	void ComputeVbar();

	bool operator == (const Edge other) const;
	Edge(Vertex *v0, Vertex *v1);
	~Edge();
};
```

### Q

```
for(int i=0; i<4; i++){
	for(int j=0; j<4; j++){
		Q[i][j]=vertex[0]->Q[i][j]+vertex[1]->Q[i][j]; 
	}
}
```

### cost

```
double t[4]={v.x, v.y, v.z, 1};
		
double temp[4]={0};
for(int i=0; i<4; i++){
	for(int j=0; j<4; j++){
		temp[i]+=t[j]*Q[j][i];
	}
}
double result=0;
for(int i=0; i<4; i++){
	result+=temp[i] * t[i];
}
return result;
```

### vbar

```
double det=Det(Q[0][0], Q[0][1], Q[0][2], 
	Q[1][0], Q[1][1], Q[1][2],
	Q[2][0], Q[2][1], Q[2][2]);

if(det>1e-9 || det<-1e-9){
	double x= -1/det * Det(Q[0][1], Q[0][2], Q[0][3],
		Q[1][1], Q[1][2], Q[1][3],
		Q[2][1], Q[2][2], Q[2][3]);
	double y= 1/det * Det(Q[0][0], Q[0][2], Q[0][3],
		Q[1][0], Q[1][2], Q[1][3],
		Q[2][0], Q[2][2], Q[2][3]);
	double z= -1/det * Det(Q[0][0], Q[0][1], Q[0][3],
		Q[1][0], Q[1][1], Q[1][3],
		Q[2][0], Q[2][1], Q[2][3]);
	vbar = Vec3f (x, y, z);
	cost = ComputeCost(vbar);
	return;
}


double error1=ComputeCost(vertex[0]->position);
double error2=ComputeCost(vertex[1]->position);
double error3=ComputeCost((vertex[0]->position+vertex[1]->position)/2);
cost = error1 < error2 ? (error1 < error3 ? error1: error3):(error2 < error3 ? error2 : error3);
if(cost == error1) 
	vbar = vertex[0]->position;
else if(cost == error2)
	vbar = vertex[1]->position;
else
	vbar= (vertex[0]->position+vertex[1]->position)/2;
return;
```

## Simplify

```
make_heap(edges.begin(), edges.end(), cmp);
pop_heap(edges.begin(), edges.end(), cmp);
push_heap(edges.begin(), edges.end(),cmp);
```

```
Vertex *u = e->vertex[0];
Vertex *v = e->vertex[1];

v->Q[i][j]=e->Q[i][j];
v->position = e->vbar;

// refresh the vertexes, edges, faces of v
```