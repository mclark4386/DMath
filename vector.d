module DMath.Vec;

private{
	import std.array,std.math;
}

alias gl_float float

const float M_PI = 3.14159265;
const float M_PI180 = 0.0174532925;
const float M_180PI = 57.2957795785;

public Vec3 cross(Vec3 A, Vec3 B)
{
	Vec3 temp = new Vec3();

	temp.x(A.y*B.z-A.z*B.y);
	temp.y(A.z*B.x-A.x*B.z);
	temp.z(A.x*B.y-A.y*B.x);

	return temp;
}

class Vec3
{
	gl_float vector[3];

	public this(gl_float [] data = null)
	{
		if(data is null)
			return;

		vector = data[0..3];
	}
	public this(gl_float x, gl_float y, gl_float z)
	{
		vector[0] = x;
		vector[1] = y;
		vector[2] = z;
	}

	public gl_float x()
	{
		return vector[0];
	}

	public gl_float y()
	{
		return vector[1];
	}

	public gl_float z()
	{
		return vector[2];
	}

	public void x(gl_float x)
	{
		vector[0] = x;
	}

	public void y(gl_float y)
	{
		vector[1] = y;
	}

	public void z(gl_float z)
	{
		vector[2] = z;
	}

	public Vec3 cross(Vec3 other)
	{
		return DPlay.Vec.cross(this, other);
	}

	public void normalize()
	{
		const gl_float ratio = 1.0/cast(gl_float)sqrt(vector[0]*vector[0]+vector[1]*vector[1]+vector[2]*vector[2]);

		vector[0] *= ratio;
		vector[1] *= ratio;
		vector[2] *= ratio;
	}

	public void scale(gl_float s)
	{
		vector[0] *= s;
		vector[1] *= s;
		vector[2] *= s;
	}
}

class Vec4
{
	gl_float vector[4];

	public this(gl_float [] data = null)
		{
			if(data is null)
				return;

			vector = data[0..4];
		}
		public this(gl_float x, gl_float y, gl_float z, gl_float w)
		{
			vector[0] = x;
			vector[1] = y;
			vector[2] = z;
			vector[3] = w;
		}

		public gl_float x()
		{
			return vector[0];
		}

		public gl_float y()
		{
			return vector[1];
		}

		public gl_float z()
		{
			return vector[2];
		}

		public gl_float w()
		{
			return vector[3];
		}

		public void x(gl_float x)
		{
			vector[0] = x;
		}

		public void y(gl_float y)
		{
			vector[1] = y;
		}

		public void z(gl_float z)
		{
			vector[2] = z;
		}

		public void w(gl_float w)
		{
			vector[3] = w;
		}

		public void loadQIdentity()
		{
			vector[0] = 0;
			vector[1] = 0;
			vector[2] = 0;
			vector[3] = 1;
		}

		public Vec4 qPreMultiply(Vec4 other)
		{
			Vec4 temp = new Vec4;

			temp.w(w*other.w-x*other.x-y*other.y-z*other.z);
			temp.x(w*other.x+x*other.w+y*other.z+z*other.y);
			temp.y(w*other.y-x*other.z-y*other.w-z*other.x);
			temp.z(w*other.z+x*other.y+y*other.x+z*other.w);

			return temp;
		}

		public Vec4 qPostMultiply(Vec4 other)
		{
			Vec4 temp = new Vec4;

			temp.w(other.w*w-other.x*x-other.y*y-other.z*z);
			temp.x(other.w*x+other.x*w+other.y*z+other.z*y);
			temp.y(other.w*y-other.x*z-other.y*w-other.z*x);
			temp.z(other.w*z+other.x*y+other.y*x+other.z*w);

			return temp;
		}

		public Vec4 qInverse()
		{
			Vec4 temp = new Vec4;
			temp.vector = vector;

			temp.vector[0] *= -1;
			temp.vector[1] *= -1;
			temp.vector[2] *= -1;

			return temp;
		}

		public void loadQFromRotate(float angle, float x, float y, float z)
		{
			Vec3 temp = new Vec3;
			temp.x(x);
			temp.y(y);
			temp.z(z);

			loadQFromRotate(angle,temp);
		}

		public void loadQFromRotate(float angle, Vec3 dir)
		{
			dir.normalize();

			//convert and find sin/cos of halfangle
			float rad = angle * M_PI180;
			float s = sin(rad *.5);
			float c = cos(rad *.5);

			w(c);
			x(dir.x*s);
			y(dir.y*s);
			z(dir.z*s);
		}


}