#include<stdio.h>
#include<math.h>
#include<time.h>
#include<windows.h>

#define PRINTF 0

// ���ַ�
float BiSearch(float c, float eps = 1e-6) {
	float a = 0, b = c, x = 0.f;
	for (int i = 0; i < 100; ++i)
	{
		x = (a + b) / 2.0f;
		(x*x - c < 0) ? a = (a + x) / 2.0f : b = (b + x) / 2.0f;
#if _DEBUG && PRINTF
		printf("BiSearch: step=%d x=%f \n", i + 1, x);
#endif
		if (b-a < eps)
		{
			break;
		}
	}
	return x;
}

// ţ�ٷ�
float Newton(float c, float eps=1e-6) {
	float x0 = 1.0f;
	for(int i = 0; i < 100; ++i)
	{
		float x1 = (x0 + c / x0) * 0.5f;
#if _DEBUG && PRINTF
		printf("Newton: step=%d x=%f \n", i+1, x1);
#endif
		if (fabs(x1 - x0) < eps)
		{
			x0 = x1;
			break;
		}
		x0 = x1;
	}
	return x0;
}

// ƽ�����������㷨
float InvSqrt(float number)
{
	long i;
	float x2, y;
	const float threehalfs = 1.5F;

	x2 = number * 0.5F;
	y = number;
	i = *(long *)&y; // evil floating point bit level hacking���Ը�������а��λԪhack��
	i = 0x5f3759df - (i >> 1); // what the fuck?�������������ô���£���
	y = *(float *)&i;
	y = y * (threehalfs - (x2 * y * y)); // 1st iteration ����һ�ε�����
	y  = y * ( threehalfs - ( x2 * y * y ) ); // 2nd iteration, this can be removed���ڶ��ε���������ɾ����

	y *= number; // ����1/y
#if _DEBUG && PRINTF
	printf("InvSqrt: step=%d x=%f \n", 2, y);
#endif

	return y;
}

// ��ͬ��������ƽ����
int main()
{
#if PRINTF
	BiSearch(3);
	Newton(3);
	InvSqrt(3);
#else
	const int TIMES = 1e6;
	float x = 0, y = 5.f;

	clock_t t = clock(), e = t;
	for(int i = 0; i < TIMES; ++i)
		x = BiSearch(y);
	e = clock();
	printf("res=%f, BiSearch using %dms\n", x, e-t);
	t = e;

	for (int i = 0; i < TIMES; ++i)
		x = Newton(y);
	e = clock();
	printf("res=%f, Newton using %dms\n", x, e - t);
	t = e;

	for (int i = 0; i < TIMES; ++i)
		x = sqrt(y);
	e = clock();
	printf("res=%f, sqrt using %dms\n", x, e - t);
	t = e;

	for (int i = 0; i < TIMES; ++i)
		x = InvSqrt(y);
	e = clock();
	printf("res=%f, InvSqrt using %dms\n", x, e - t);
	t = e;
#endif
	system("PAUSE");
	return 0;
}
