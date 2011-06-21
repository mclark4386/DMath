module DMath.Mat;

private{
	import std.math,std.stdio,std.array,std.math;
}

//version = Use_Assimp

version(Use_Assimp)
{
	private
	{
		import assimp.math;
	}
}

public{
	import DMath.Vec;
}

alias gl_float float //GLfloat

//for hints look at SpiderWeb/UtilSrc/matrixUtils.c

class Mat4
{
	//local vectors r = right vec, u = up vec, l = look vec("forward")(as long as the matrix hasn't been scaled)
	//t = position
	/*---------------------------
	
	[   rx    ry    rz     tx   ]
	
	[   ux    uy    uz     ty   ]
	
	[   lx    ly    lz     tz   ]
	
	[   b1    b2    b3     1.0  ]
	
	---------------------------*/
	
	public gl_float matrix[16];
	public this(){
               //[ 0][ 4][ 8][12]
               //[ 1][ 5][ 9][13]
               //[ 2][ 6][10][14]
               //[ 3][ 7][11][15]
		matrix = [
		1.0, 0.0, 0.0, 0.0,
		0.0, 1.0, 0.0, 0.0,
		0.0, 0.0, 1.0, 0.0,
		0.0, 0.0, 0.0, 1.0
		];
	}
	public this(Mat4 other){
			matrix = other.matrix;
		}
	
	version(Use_Assimp)
	{
		public void loadFromAIMatrix4x4(aiMatrix4x4* mat)
		{
			this.matrix[0] = mat.a1;
			this.matrix[1] = mat.b1;
			this.matrix[2] = mat.c1;
			this.matrix[3] = mat.d1;
			this.matrix[4] = mat.a2;
			this.matrix[5] = mat.b2;
			this.matrix[6] = mat.c2;
			this.matrix[7] = mat.d2;
			this.matrix[8] = mat.a3;
			this.matrix[9] = mat.b3;
			this.matrix[10] = mat.c3;
			this.matrix[11] = mat.d3;
			this.matrix[12] = mat.a4;
			this.matrix[13] = mat.b4;
			this.matrix[14] = mat.c4;
			this.matrix[15] = mat.d4;
		}
	
		public void loadFromAIQuaternion(aiQuaternion* q)
		{
			// This is the formula optimized to work with unit quaternions.
			// |1-2y²-2z²        2xy-2zw         2xz+2yw       0|
			// | 2xy+2zw        1-2x²-2z²        2yz-2xw       0|
			// | 2xz-2yw         2yz+2xw        1-2x²-2y²      0|
			// |    0               0               0          1|
	    
			// And this is the code.
			// First Column
			matrix[0] = 1 - 2 * (q.y * q.y + q.z * q.z);
			matrix[1] = 2 * (q.x * q.y + q.z * q.w);
			matrix[2] = 2 * (q.x * q.z - q.y * q.w);
			matrix[3] = 0;
	    
			// Second Column
			matrix[4] = 2 * (q.x * q.y - q.z * q.w);
			matrix[5] = 1 - 2 * (q.x * q.x + q.z * q.z);
			matrix[6] = 2 * (q.z * q.y + q.x * q.w);
			matrix[7] = 0;
	    
			// Third Column
			matrix[8] = 2 * (q.x * q.z + q.y * q.w);
			matrix[9] = 2 * (q.y * q.z - q.x * q.w);
			matrix[10] = 1 - 2 * (q.x * q.x + q.y * q.y);
			matrix[11] = 0;
	    
			// Fourth Column
			matrix[12] = 0;
			matrix[13] = 0;
			matrix[14] = 0;
			matrix[15] = 1;
		}
	}
	
	public void loadFromQuaternion(Vec4 q)
		{
		    // This is the formula optimized to work with unit quaternions.
		       // |1-2y²-2z²        2xy-2zw         2xz+2yw       0|
		       // | 2xy+2zw        1-2x²-2z²        2yz-2xw       0|
		       // | 2xz-2yw         2yz+2xw        1-2x²-2y²      0|
		       // |    0               0               0          1|
		    
		       // And this is the code.
		       // First Column
		       matrix[0] = 1 - 2 * (q.y * q.y + q.z * q.z);
		       matrix[1] = 2 * (q.x * q.y + q.z * q.w);
		       matrix[2] = 2 * (q.x * q.z - q.y * q.w);
		       matrix[3] = 0;
		    
		       // Second Column
		       matrix[4] = 2 * (q.x * q.y - q.z * q.w);
		       matrix[5] = 1 - 2 * (q.x * q.x + q.z * q.z);
		       matrix[6] = 2 * (q.z * q.y + q.x * q.w);
		       matrix[7] = 0;
		    
		       // Third Column
		       matrix[8] = 2 * (q.x * q.z + q.y * q.w);
		       matrix[9] = 2 * (q.y * q.z - q.x * q.w);
		       matrix[10] = 1 - 2 * (q.x * q.x + q.y * q.y);
		       matrix[11] = 0;
		    
		       // Fourth Column
		       matrix[12] = 0;
		       matrix[13] = 0;
		       matrix[14] = 0;
		       matrix[15] = 1;
		}
	
	version(Use_Assimp)
	{
		public Mat4 createFromAIMatrix4x4(aiMatrix4x4* mat)
			{
				Mat4 newMe = new Mat4();
				newMe.matrix[0] = mat.a1;
				newMe.matrix[1] = mat.b1;
				newMe.matrix[2] = mat.c1;
				newMe.matrix[3] = mat.d1;
				newMe.matrix[4] = mat.a2;
				newMe.matrix[5] = mat.b2;
				newMe.matrix[6] = mat.c2;
				newMe.matrix[7] = mat.d2;
				newMe.matrix[8] = mat.a3;
				newMe.matrix[9] = mat.b3;
				newMe.matrix[10] = mat.c3;
				newMe.matrix[11] = mat.d3;
				newMe.matrix[12] = mat.a4;
				newMe.matrix[13] = mat.b4;
				newMe.matrix[14] = mat.c4;
				newMe.matrix[15] = mat.d4;
				return newMe;
			}
	
		public aiMatrix4x4* createAIMatrix4x4FromSelf()
		{
			aiMatrix4x4* mat = new aiMatrix4x4();
			mat.a1 = this.matrix[0];
			mat.b1 = this.matrix[1];
			mat.c1 = this.matrix[2];
			mat.d1 = this.matrix[3];
			mat.a2 = this.matrix[4];
			mat.b2 = this.matrix[5];
			mat.c2 = this.matrix[6];
			mat.d2 = this.matrix[7];
			mat.a3 = this.matrix[8];
			mat.b3 = this.matrix[9];
			mat.c3 = this.matrix[10];
			mat.d3 = this.matrix[11];
			mat.a4 = this.matrix[12];
			mat.b4 = this.matrix[13];
			mat.c4 = this.matrix[14];
			mat.d4 = this.matrix[15];
			return mat;
		}
	}
	
	public gl_float* getGLMatrix()
	{
		return matrix.ptr;
	}
	
	public void loadIdentity()
	{
		matrix[0] = matrix[5] = matrix[10] = matrix[15] = 1.0f;
	    matrix[1] = matrix[2] = matrix[3] = matrix[4]
	    = matrix[6] = matrix[7] = matrix[8] = matrix[9]
	    = matrix[11] = matrix[12] = matrix[13] = matrix[14] = 0.0f;
	}
	
	public Mat4 transpose()
	{
		Mat4 temp = new Mat4();
		
		temp.matrix[0] = matrix[0];
		temp.matrix[1] = matrix[4];
		temp.matrix[2] = matrix[8];
		temp.matrix[3] = matrix[12];
		temp.matrix[4] = matrix[1];
		temp.matrix[5] = matrix[5];
		temp.matrix[6] = matrix[9];
		temp.matrix[7] = matrix[13];
		temp.matrix[8] = matrix[2];
		temp.matrix[9] = matrix[6];
		temp.matrix[10] = matrix[10];
		temp.matrix[11] = matrix[14];
		temp.matrix[12] = matrix[3];
		temp.matrix[13] = matrix[7];
		temp.matrix[14] = matrix[11];
		temp.matrix[15] = matrix[15];
		
		return temp;
	}
	
	public void rotateAboutX(gl_float angle)
	{
		debug writeln("X");
		float rad = angle * M_PI180;
		gl_float c = cos(rad);
		gl_float s = sin(rad);
		
		//float t4 = matrix[4],t5 = matrix[5],t6 = matrix[6],t7 = matrix[7];
		
		//matrix[4] = matrix[8]*s + t4*c;
		//matrix[8] = matrix[8]*c - t4*s;
		//matrix[5] = matrix[9]*s + t5*c;
		//matrix[9] = matrix[9]*c - t5*s;
		//matrix[6] = matrix[10]*s + t6*c;
		//matrix[10] = matrix[10]*c - t6*s;
		//matrix[7] = matrix[11]*s + t7*c;
		//matrix[11] = matrix[11]*c - t7*s;
		
		Mat4 rot = new Mat4;
		rot.matrix[5] = c;
		rot.matrix[6] = -s;
		rot.matrix[9] = s;
		rot.matrix[10] = c;
		
		this = this * rot;
		//debug writeln("rot:",rot.matrix," this:",this.matrix);
	}
	
	public void rotateAboutY(gl_float angle)
	{
		debug writeln("Y");
		float rad = angle * M_PI180;
		gl_float c = cos(rad);
		gl_float s = sin(rad);

		float t0 = matrix[0],t1 = matrix[1],t2 = matrix[2],t3 = matrix[3];
		
		matrix[0] = matrix[8]*s + t0*c;
		matrix[8] = matrix[8]*c - t0*s;
		matrix[1] = matrix[9]*s + t1*c;
		matrix[9] = matrix[9]*c - t1*s;
		matrix[2] = matrix[10]*s + t2*c;
		matrix[10] = matrix[10]*c - t2*s;
		matrix[3] = matrix[11]*s + t3*c;
		matrix[11] = matrix[11]*c - t3*s;
	}
		
	public void rotateAboutZ(gl_float angle)
	{
		debug writeln("Z");
		float rad = angle * M_PI180;
		gl_float c = cos(rad);
		gl_float s = sin(rad);	
		
		float t0 = matrix[0],t1 = matrix[1],t2 = matrix[2],t3 = matrix[3];
				
		matrix[0] = matrix[4]*s + t0*c;
		matrix[4] = matrix[4]*c - t0*s;
		matrix[1] = matrix[5]*s + t1*c;
		matrix[5] = matrix[5]*c - t1*s;
		matrix[2] = matrix[6]*s + t2*c;
		matrix[6] = matrix[6]*c - t2*s;
		matrix[3] = matrix[7]*s + t3*c;
		matrix[7] = matrix[7]*c - t3*s;
	}
	
	public void rotate(gl_float angle, Vec3 vec)
	{
		if(vec.y == 0.0&&vec.z == 0.0)
			this.rotateAboutX(angle);
		else if(vec.x == 0.0&&vec.z == 0.0)
			this.rotateAboutY(angle);
		else if(vec.x == 0.0&&vec.y == 0.0)
			this.rotateAboutZ(angle);
	
		float rad = angle * M_PI180;
		gl_float c = cos(rad);
		gl_float s = sin(rad);
		vec.normalize;
		
	    //x^2(1-c)+c     xy(1-c)-zs     xz(1-c)+ys     0
	            //yx(1-c)+zs     y^2(1-c)+c     yz(1-c)-xs     0
	            //xz(1-c)-ys     yz(1-c)+xs     z^2(1-c)+c     0
	                 //0              0               0        1
		
		gl_float mc = 1 - c;
		
		gl_float xy = vec.x*vec.y*mc;
		gl_float xz = vec.x*vec.z*mc;
		gl_float yz = vec.y*vec.z*mc;
		
		gl_float xs = vec.x*s;
		gl_float ys = vec.y*s;
		gl_float zs = vec.z*s;

		gl_float xx = vec.x*vec.x;
		gl_float yy = vec.y*vec.y;
		gl_float zz = vec.z*vec.z;
		
		Mat4 mat = new Mat4();
		
		mat.matrix[0] = xx+c*(1.0 - xx);
		mat.matrix[1] = xy+zs;
		mat.matrix[2] = xz-ys;
		mat.matrix[3] = 0;
		mat.matrix[4] = xy-zs;
		mat.matrix[5] = yy+c*(1.0 - yy);
		mat.matrix[6] = yz+xs;
		mat.matrix[7] = 0;
		mat.matrix[8] = xz+ys;
		mat.matrix[9] = yz-xs;
		mat.matrix[10] = zz+c*(1.0-zz);
		mat.matrix[11] = 0;
		mat.matrix[12] = 0;
		mat.matrix[13] = 0;
		mat.matrix[14] = 0;
		mat.matrix[15] = 1;
		
		//debug writeln("rotate matrix: ",mat.matrix);
		
		float t1 = matrix[0], t2 = matrix[4], t3 = matrix[8];
		
		matrix[0] = t1*mat.matrix[0]+t2*mat.matrix[1]+t3*mat.matrix[2];
		matrix[4] = t1*mat.matrix[4]+t2*mat.matrix[5]+t3*mat.matrix[6];
		matrix[8] = t1*mat.matrix[8]+t2*mat.matrix[9]+t3*mat.matrix[10];
		
		t1 = matrix[1]; t2 = matrix[5]; t3 = matrix[9];
		
		matrix[1] = t1*mat.matrix[0]+t2*mat.matrix[1]+t3*mat.matrix[2];
		matrix[5] = t1*mat.matrix[4]+t2*mat.matrix[5]+t3*mat.matrix[6];
		matrix[9] = t1*mat.matrix[8]+t2*mat.matrix[9]+t3*mat.matrix[10];
		
		t1 = matrix[2]; t2 = matrix[6]; t3 = matrix[10];
				
		matrix[2] = t1*mat.matrix[0]+t2*mat.matrix[1]+t3*mat.matrix[2];
		matrix[6] = t1*mat.matrix[4]+t2*mat.matrix[5]+t3*mat.matrix[6];
		matrix[10] = t1*mat.matrix[8]+t2*mat.matrix[9]+t3*mat.matrix[10];
		
		t1 = matrix[3]; t2 = matrix[7]; t3 = matrix[11];
				
		matrix[3] = t1*mat.matrix[0]+t2*mat.matrix[1]+t3*mat.matrix[2];
		matrix[7] = t1*mat.matrix[4]+t2*mat.matrix[5]+t3*mat.matrix[6];
		matrix[11] = t1*mat.matrix[8]+t2*mat.matrix[9]+t3*mat.matrix[10];
		
		
		//debug writeln("rotated matrix: ",this.matrix);
	}
	
	public void rotate(gl_float angle, gl_float x, gl_float y, gl_float z)
	{
		Vec3 vec = new Vec3(x,y,z);
		this.rotate(angle,vec);
	}
	
	public void translate(gl_float x, gl_float y, gl_float z)
	{
		//Mat4 temp = new Mat4();
		//temp.matrix[12] = x;
		//temp.matrix[13] = y;
		//temp.matrix[14] = z;
		//debug writeln("translate matrix: ",temp.matrix);
		//this = temp * this;
		//debug writeln("translated matrix: ",this.matrix);
		
		matrix[12] += matrix[0]*x + matrix[4]*y + matrix[8]*z;
		matrix[13] += matrix[1]*x + matrix[5]*y + matrix[9]*z;
		matrix[14] += matrix[2]*x + matrix[6]*y + matrix[10]*z;
	}
	
	public void scale(gl_float x, gl_float y, gl_float z)
	{
		matrix[0] *= x;
		matrix[4] *= y;
		matrix[8] *= z;
		matrix[1] *= x;
		matrix[5] *= y;
		matrix[9] *= z;
		matrix[2] *= x;
		matrix[6] *= y;
		matrix[10] *= z;
		matrix[3] *= x;
		matrix[7] *= y;
		matrix[11] *= x;
	}
	
	public Mat4 opBinary(string s)(Mat4 other) if (s == "*")
	{
		Mat4 temp = new Mat4();
		
		temp.matrix[0] = matrix[0]*other.matrix[0]+matrix[4]*other.matrix[1]+matrix[8]*other.matrix[2]+matrix[12]*other.matrix[3];
		temp.matrix[1] = matrix[1]*other.matrix[0]+matrix[5]*other.matrix[1]+matrix[9]*other.matrix[2]+matrix[13]*other.matrix[3];
		temp.matrix[2] = matrix[2]*other.matrix[0]+matrix[6]*other.matrix[1]+matrix[10]*other.matrix[2]+matrix[14]*other.matrix[3];
		temp.matrix[3] = matrix[3]*other.matrix[0]+matrix[7]*other.matrix[1]+matrix[11]*other.matrix[2]+matrix[15]*other.matrix[3];
				
		temp.matrix[4] = matrix[0]*other.matrix[4]+matrix[4]*other.matrix[5]+matrix[8]*other.matrix[6]+matrix[12]*other.matrix[7];
		temp.matrix[5] = matrix[1]*other.matrix[4]+matrix[5]*other.matrix[5]+matrix[9]*other.matrix[6]+matrix[13]*other.matrix[7];
		temp.matrix[6] = matrix[2]*other.matrix[4]+matrix[6]*other.matrix[5]+matrix[10]*other.matrix[6]+matrix[14]*other.matrix[7];
		temp.matrix[7] = matrix[3]*other.matrix[4]+matrix[7]*other.matrix[5]+matrix[11]*other.matrix[6]+matrix[15]*other.matrix[7];
			
		temp.matrix[8] = matrix[0]*other.matrix[8]+matrix[4]*other.matrix[9]+matrix[8]*other.matrix[10]+matrix[12]*other.matrix[11];
		temp.matrix[9] = matrix[1]*other.matrix[8]+matrix[5]*other.matrix[9]+matrix[9]*other.matrix[10]+matrix[13]*other.matrix[11];
		temp.matrix[10] = matrix[2]*other.matrix[8]+matrix[6]*other.matrix[9]+matrix[10]*other.matrix[10]+matrix[14]*other.matrix[11];
		temp.matrix[11] = matrix[3]*other.matrix[8]+matrix[7]*other.matrix[9]+matrix[11]*other.matrix[10]+matrix[15]*other.matrix[11];
		
		temp.matrix[12] = matrix[0]*other.matrix[12]+matrix[4]*other.matrix[13]+matrix[8]*other.matrix[14]+matrix[12]*other.matrix[15];
		temp.matrix[13] = matrix[1]*other.matrix[12]+matrix[5]*other.matrix[13]+matrix[9]*other.matrix[14]+matrix[13]*other.matrix[15];
		temp.matrix[14] = matrix[2]*other.matrix[12]+matrix[6]*other.matrix[13]+matrix[10]*other.matrix[14]+matrix[14]*other.matrix[15];
		temp.matrix[15] = matrix[3]*other.matrix[12]+matrix[7]*other.matrix[13]+matrix[11]*other.matrix[14]+matrix[15]*other.matrix[15];
							
		return temp;
	}
	
	//will "reset" the matrix to the perspective (WARNING: CLEARS EVERYTHING OUT)
	public void perspective(gl_float fovy, gl_float aspect, gl_float zNear, gl_float zFar)
	{
		if(isNaN(fovy)||isNaN(aspect))
			return;
		gl_float f = 1/tan((fovy/2)*M_PI180);
		matrix = [
				(f/aspect), 0.0, 	0.0, 						0.0,
				0.0, 		f, 		0.0, 						0.0,
				0.0, 		0.0,	(zFar+zNear)/(zNear-zFar), 	-1.0,
				0.0, 		0.0, 	(2*zFar*zNear)/(zNear-zFar),	0.0
				];
	} 
	
	//will "reset" the matrix to the orthographic perspective (WARNING: CLEARS EVERYTHING OUT)
	public void orthographic(float left, float right, float bottom, float top, float nearZ, float farZ)
	{
		matrix = [
				2.0/(right-left), 			0.0, 						0.0, 						0.0,
				0.0, 						2.0/(top-bottom), 			0.0, 						0.0,
				0.0, 						0.0,						-2.0/(farZ-nearZ),			0.0,
				-(right+left)/(right-left), -(top+bottom)/(top-bottom), -(farZ+nearZ)/(farZ-nearZ),	1.0];
	}
	
	public Vec3 getWorldCoords()
	{
		return new Vec3(matrix[12..15]);
	}
	
	public void cameraLook(Vec3 pos, Vec3 lookAt)
	{
		Vec3 dir, right, up;
		
		//assume we aren't tilling the camera
		up.x(0.0);up.y(1.0);up.z(0.0);
		
		dir.x(lookAt.x - pos.x);
		dir.y(lookAt.y - pos.y);
		dir.z(lookAt.z - pos.z);
		dir.normalize;
		
		right = cross(dir,up);
		right.normalize;
		
		up = cross(right,dir);
		up.normalize;
				
		matrix[0] = right.x;
		matrix[4] = right.y;
		matrix[8] = right.z;
		matrix[12] = 0.0f;
		
		matrix[1] = up.x;
		matrix[5] = up.x;
		matrix[9] = up.x;
		matrix[13] = 0.0f;
		
		matrix[2] = -dir.x;
		matrix[6] = -dir.y;
		matrix[10] = -dir.z;
		matrix[14] = 0.0f;
		
		matrix[3] = 0.0f;
		matrix[7] = 0.0f;
		matrix[11] = 0.0f;
		matrix[15] = 1.0f;
		
		this.translate(-pos.x,-pos.y,-pos.z);
	}
	
	public void lookAt(Vec3 eye, Vec3 at, Vec3 up)
	{
		Mat4 temp = new Mat4();
		
		Vec3 xaxis, mUp = new Vec3(), mAt = new Vec3();
		
		// Compute our new look at vector, which will be
		//   the new negative Z axis of our transformed object.
		mAt.x = at.x-eye.x;
		mAt.y = at.y-eye.y;
		mAt.z = at.z-eye.z;
		mAt.normalize;
		
		// Make a useable copy of the current up vector.
		mUp.vector = up.vector.dup;
		
		// Cross product of the new look at vector and the current
		//   up vector will produce a vector which is the new
		//   positive X axis of our transformed object.
		xaxis = cross(mAt,mUp);
		xaxis.normalize;
		
		// Calculate the new up vector, which will be the
	    //   positive Y axis of our transformed object. Note
	    //   that it will lie in the same plane as the new
	    //   look at vector and the old up vector.
		mUp = cross(xaxis,mAt);
		
		// Account for the fact that the geometry will be defined to
		//   point along the negative Z axis.
		mAt.scale(-1.0);
		
		//fill it in
		temp.matrix[0] = xaxis.x;
		temp.matrix[1] = xaxis.y;
		temp.matrix[2] = xaxis.z;
		temp.matrix[3] = 0.0;
		temp.matrix[4] = mUp.x;
		temp.matrix[5] = mUp.y;
		temp.matrix[6] = mUp.z;
		temp.matrix[7] = 0.0;
		temp.matrix[8] = mAt.x;
		temp.matrix[9] = mAt.y;
		temp.matrix[10] = mAt.z;
		temp.matrix[11] = 0.0;
		temp.matrix[12] = eye.x;
		temp.matrix[13] = eye.y;
		temp.matrix[14] = eye.z;
		temp.matrix[15] = 1.0;
		
		this = this * temp;
	}

}