---
layout: post
title: "Ray Tracing"
date: 2016-03-27 16:50:46 +0800
comments: true
categories: C++

---

## openCV

### Mat

Matrix.

```
Mat RT_image = Mat::zeros( w.vp.vres, w.vp.hres, CV_8UC3 );
```

CV8UC3: 8 bit unsigned, channel 3.

### circle

```
// void circle(Mat& img, Point center, int radius, const Scalar& color, int thickness=1, int lineType=8, int shift=0)
circle(RT_image, Point(30, 30), 1, Scalar(255,255,0));
```
### imshow

```
char RT_window[] = "Ray Trace";  
imshow( RT_window, RT_image );  
```

### imwrite

```
imwrite("../ray_trace.bmp", RT_image);
```

### waitKey

* waitKey(0) will display the window infinitely until any keypress (it is suitable for image display). 
* waitKey(25) will display a frame for 25 ms, after which display will be automatically closed. (If you put it in a loop to read videos, it will display the video frame-by-frame)

---

## World

```
World w;
w.build();
w.camera_ptr->render_scene(w, RT_image);
```

```
ViewPlane					vp;
RGBColor					background_color;
Tracer*						tracer_ptr;
Light*   					ambient_ptr;
Camera*						camera_ptr;		
vector<GeometricObject*>	objects;		
vector<Light*> 				lights;

void build();
```

### ViewPlane

```
int hres;   // horizontal image resolution 
int vres;   // vertical image resolution
double   s;  // pixel size
int num_samples;    // number of samples per pixel

double   gamma;   // gamma correction factor
double   inv_gamma;    // the inverse of the gamma correction factor
bool show_out_of_gamut;  // display red if RGBColor out of gamut
int max_depth;					
Sampler * sampler_ptr;
```

## Camera

```
Point3D  eye;   // eye point
Point3D  lookat;    // lookat point
double   ra;   // roll angle
Vector3D  u, v, w;   // orthonormal basis vectors
Vector3D  up;  // up vector
double   exposure_time;

Camera& // assignment operator
operator= (const Camera& camera);
```

### Pinhole

```
double d; // view plane distance
double  zoom;  // zoom factor
```

```
void Pinhole::render_scene(const World& w, cv::Mat &img) {
	RGBColor	L;
	ViewPlane	vp(w.vp);
	Ray			ray;
	int 		depth = 0;  // recursion depth
	// sampler
	Point2D 	pp;		// sample point on a pixel
	int n = (int)sqrt((double)vp.num_samples);

	vp.s /= zoom;
	ray.o = eye;
		
	for (int r = 0; r < vp.vres; r++)			// up
		for (int c = 0; c < vp.hres; c++) {		// across 					
			L = black; 
			
			for (int p = 0; p < n; p++)			// up pixel
				for (int q = 0; q < n; q++) {	// across pixel
					pp.x = vp.s * (c - 0.5 * vp.hres + (q + 0.5) / n); 
					pp.y = vp.s * (r - 0.5 * vp.vres + (p + 0.5) / n);
					ray.d = get_direction(pp);
					L += w.tracer_ptr->trace_ray(ray, depth);
					//L += w.tracer_ptr->trace_ray(ray);
				}
			L /= vp.num_samples;
			L *= exposure_time;
			w.display_pixel(r, c, L, img);
		} 
}
```

## Tracer

```
virtual RGBColor trace_ray(const Ray& ray) const;
virtual RGBColor trace_ray(const Ray ray, const int depth) const;

World* world_ptr;
```

### Whitted

```
if (depth > world_ptr->vp.max_depth)
		return(black);
else {
	ShadeRec sr(world_ptr->hit_objects(ray));
	
	if (sr.hit_an_object) {
		sr.depth = depth;
		sr.ray = ray;	
		return (sr.material_ptr->shade(sr));
	}  
    else 
		return (world_ptr->background_color);
}	
```

### AreaLighting

```
    return (sr.material_ptr->area_light_shade(sr));
```

## ShadeRec

```
bool    hit_an_object;  // Did the ray hit an object?
Material*   material_ptr;   // Pointer to the nearest object's material
Point3D hit_point;  // World coordinates of intersection
Point3D local_hit_point;    // World coordinates of hit point on generic object (used for texture transformations)
Normal  normal; // Normal at hit point
Ray    ray; // Required for specular highlights and area lights
int    depth;   // recursion depth
World&  w;  // World reference
Vector3D    dir;    // for area lights
double  t;  // ray parameter, distance from hit point
```

## Material

### Phong

```
Lambertian*		ambient_brdf;
Lambertian*		diffuse_brdf;
GlossySpecular* specular_brdf;
```

```
RGBColor
Phong::shade(ShadeRec& sr) {
	Vector3D 	wo 			= -sr.ray.d;
	RGBColor 	L 			= ambient_brdf->rho(sr, wo) * sr.w.ambient_ptr->L(sr);
	int 		num_lights	= sr.w.lights.size();
	
	for (int j = 0; j < num_lights; j++) {
		Vector3D wi = sr.w.lights[j]->get_direction(sr);    
		double ndotwi = sr.normal * wi;
	
		if (ndotwi > 0.0) {
			bool in_shadow = false;
			if(sr.w.lights[j]->casts_shadows){
				Ray shadowRay(sr.hit_point, wi);
				in_shadow = sr.w.lights[j]->in_shadow(shadowRay, sr);
			}

			if(!in_shadow)
				L += (diffuse_brdf->f(sr, wo, wi) + specular_brdf->f(sr, wo, wi)) * sr.w.lights[j]->L(sr) * ndotwi;
		}
	}
	
	return (L);
}
```

### Transparent

```
PerfectSpecular* 	reflective_brdf;
PerfectTransmitter* specular_btdf;	
```

## BRDF

```
void set_sampler(Sampler* sPtr);

virtual RGBColor
f(const ShadeRec& sr, const Vector3D& wo, const Vector3D& wi) const;

virtual RGBColor
sample_f(const ShadeRec& sr, const Vector3D& wo, Vector3D& wi) const;

virtual RGBColor
sample_f(const ShadeRec& sr, const Vector3D& wo, Vector3D& wi, double& pdf) const;

virtual RGBColor
rho(const ShadeRec& sr, const Vector3D& wo) const;

Sampler* sampler_ptr;
```

### Lambertian

```
double		kd;// diffuse coefficient
RGBColor 	cd;// diffuse color

RGBColor
Lambertian::f(const ShadeRec& sr, const Vector3D& wo, const Vector3D& wi) const {
	return (kd * cd * invPI);
}


RGBColor
Lambertian::sample_f(const ShadeRec& sr, const Vector3D& wo, Vector3D& wi, double& pdf) const {
	
	Vector3D w = sr.normal;
	Vector3D v = Vector3D(0.0034, 1, 0.0071) ^ w;
	v.normalize();
	Vector3D u = v ^ w;
	
	Point3D sp = sampler_ptr->sample_hemisphere();  
	wi = sp.x * u + sp.y * v + sp.z * w;
	wi.normalize(); 	
	
	pdf = sr.normal * wi * invPI;
	
	return (kd * cd * invPI); 
}
// ---------------------------------------------------------------------- rho

RGBColor
Lambertian::rho(const ShadeRec& sr, const Vector3D& wo) const {
	return (kd * cd);
}
```

## BTDF

### PerfectTransmitter

```
double	kt;			// transmission coefficient
double	ior;		// index of refraction

RGBColor
PerfectTransmitter::sample_f(const ShadeRec& sr, const Vector3D& wo, Vector3D& wt) const {
	
	Normal n(sr.normal);
	double cos_thetai = n * wo;
	double eta = ior;	
		
	if (cos_thetai < 0.0) {			// transmitted ray is outside     
		cos_thetai = -cos_thetai;
		n = -n;  					// reverse direction of normal
		eta = 1.0 / eta; 			// invert ior 
	}

	double temp = 1.0 - (1.0 - cos_thetai * cos_thetai) / (eta * eta);
	double cos_theta2 = sqrt(temp);
	wt = -wo / eta - (cos_theta2 - cos_thetai / eta) * n;   
	
	return (kt / (eta * eta) * white / fabs(sr.normal * wt));
}
```

## Sampler

```
int num_samples;    // the number of sample points in a set
int num_sets;   // the number of sample sets
vector<Point2D> samples;    // sample points on a unit square
vector<int> shuffled_indices;   // shuffled samples array indices
vector<Point2D> disk_samples;   // sample points on a unit disk
vector<Point3D> hemisphere_samples; // sample points on a unit hemisphere
vector<Point3D> sphere_samples; // sample points on a unit sphere
unsigned long   count;  // the current number of sample points used
int jump;   // random index jump

Point3D
Sampler::sample_hemisphere(void) {
	srand((unsigned)time(0));
	if (count % num_samples == 0)  								// start of a new pixel
		jump = (rand() % num_sets) * num_samples;
		
	return (hemisphere_samples[jump + shuffled_indices[jump + count++ % num_samples]]);		
}
```

## GeometricObject

```
mutable Material*   material_ptr; 
```

### Plane

```
Point3D   a; // point through which plane passes 
Normal   n;    // normal to the plane
		
static const double kEpsilon;    // for shadows and secondary rays

bool 															 
Plane::hit(const Ray& ray, double& tmin, ShadeRec& sr) const {	
	double t = (a - ray.o) * n / (ray.d * n); 
														
	if (t > kEpsilon) {
		tmin = t;
		sr.normal = n;
		sr.local_hit_point = ray.o + t * ray.d;
		
		return (true);	
	}

	return(false);
}

bool Plane::shadow_hit(const Ray& ray, double& tmin) const {	
	double t = (a - ray.o) * n / (ray.d * n); 
														
	if (t > kEpsilon) {
		tmin = t;
		return (true);	
	}
	return(false);
}
```

## Light

```
virtual Vector3D get_direction(ShadeRec& sr) = 0;

virtual RGBColor L(ShadeRec& sr) const ;

void set_shadows(const bool b);

virtual double G(ShadeRec &sr) const ;

virtual double pdf(ShadeRec& sr) const ;

virtual bool in_shadow(const Ray &ray, const ShadeRec &sr) const = 0;
```

### PointLight

```
double		ls;
RGBColor	color;
Vector3D	location;

RGBColor
PointLight::L(ShadeRec& sr) const{	
	return (ls * color);
}

bool PointLight::in_shadow(const Ray& ray, const ShadeRec& sr) const{
	double t;
	int num_objects = sr.w.objects.size();
	double d = (location - ray.o).length();

	for(int j=0; j < num_objects; j++)
		if(sr.w.objects[j]->shadow_hit(ray, t) && t<d)
			return true;
	return false;
}
```

## Texture

### Checker3D

```
double size;
RGBColor color1;
RGBColor color2;

RGBColor Checker3D::get_color(const ShadeRec& sr) const{
	double eps = -0.000187453738;	// small random number
	double x = sr.local_hit_point.x + eps;
	double y = sr.local_hit_point.y + eps;
	double z = sr.local_hit_point.z + eps;		
	
	if (((int)floor(x / size) + (int)floor(y / size) + (int)floor(z / size)) % 2 == 0)	
		return (color1);
	else	
		return (color2);
}
```