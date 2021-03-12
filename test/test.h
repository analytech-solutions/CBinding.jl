#ifndef TEST_H
#define TEST_H


#include "test.h"


typedef void T1;
typedef T1 T2;

typedef char T3;
typedef short T4;
typedef int T5;
typedef long T6;
typedef long long T7;

typedef signed char T8;
typedef signed short T9;
typedef signed int T10;
typedef signed long T11;
typedef signed long long T12;

typedef unsigned char T13;
typedef unsigned short T14;
typedef unsigned int T15;
typedef unsigned long T16;
typedef unsigned long long T17;

typedef float T18;
typedef double T19;
typedef long double T20;

typedef float _Complex T21;
typedef double _Complex T22;
typedef long double _Complex T23;


typedef void T1;
typedef T1 T2;
typedef _Bool B1;

struct S234;
struct S234;
typedef struct S234 S234;
struct S234 { int i; };
typedef struct S432 { int i; int j; S234 *s; } S432;
typedef struct { int i; int j; } S4323;

typedef void *T1432;
typedef T1 *T2234;
typedef struct { int i; int j; } *S4323b;
typedef struct S234 *S234a;
typedef struct S432b { int i; int j; } *S432b;

typedef struct F2aoeuret { int i; float f; } (*F2aoeu)(struct S5445 { int i; float f; } x);


enum E1 {
	E1_1,
	E1_2,
	E1_3
};

enum E2 {
	E2_1 = 1,
	E2_2 = E2_1,
	E2_3 = E2_1+10,
	E2_4 = 0x0u,
	E2_5 = 0xffffffffull,
	E2_6 = 0xffffffffffffull
};


struct S1 {
};

struct S2 {
	int i;
};

struct S3 {
	struct S1 s;
};

struct S4 {
	struct {
		int i;
		struct S3 s;
	};
};

struct S5 {
	struct {
		int i;
		struct S3 s;
	} s;
};

struct S6 {
	struct S7 {
		int i;
		struct S3 s;
	} s, s1;
	int i;
	struct S7 s2;
};

struct S8 {
	struct S7 s;
};

struct S9 {
	struct {
		int i;
	} s1, s2;
};

struct S10 {
	struct S11 {
		int i;
	};
};

struct S12 {
	struct {
		int i;
	} s1, *s2, **s3, ***s4;
};

struct S13 {
	struct {
		int i;
	} *s;
};

struct S14 {
	struct {
		int i;
	} s1, *s2, s3[2], s4[5][2], *s5[5][2], *s6[][2];
};

struct S15 {
	struct {
		int i;
	} s[2];
};

struct S16 {
	int i:3, j:3;
	unsigned int u:10;
};

struct S17 {
	char c;
	int i;
};

struct S18 {
	char c;
	int i;
} __attribute__((packed));

struct S19 {
	struct {
		char c;
	} __attribute__((packed));
	struct {
		int i;
	} __attribute__((packed));
};

struct S20 {
	struct {
		char c;
	};
	struct {
		int i;
	};
} __attribute__((packed));

struct S21 {
	void (*f)(void);
};

struct S22 {
	union { int i; float f; struct { int j; }; } (*(*f)(struct S22 x, int i))(int, float);
};

struct S23 {
	int (*f)(char const *, ...);
};

struct S24;
struct _S24;

struct S25 {
	struct S24 *s1;
	struct _S24 *s2;
	struct S25 *s3;
};

struct S24 {
	struct S24 *s1;
	struct _S24 *s2;
	struct S25 s3;
};

struct S26 {
	enum E3 {
		E3_1
	} e1, *e2;
	enum E3 e3;
	enum E1 e4, *e5;
};

typedef struct S27_ {
	int i;
} S27;

typedef struct {
	int i;
} S28;

struct S29;
typedef struct S29 S29_;
typedef struct S29 * S29_ptr;
struct S29 {
	S29_ *s1;
	S29_ptr s2;
};

struct S30;
typedef void (*F1)(struct S30 s);
struct S30 {
	int i:10, j:5, k:3;
	F1 f;
};

typedef struct F2ret { int i; float f; } (*F2)(union { int i; float f; } x);
typedef struct F3ret { int i; float f; } (*F3[3])(union { int i; float f; } x[1], struct F3ret *p);

struct _S31;
typedef struct _S31 S31;
struct S32 {
	S31 *s;
};

typedef struct S33 {
	int i;
} S33;

typedef struct {
	int const i;
	int const *p;
	int const * const cp;
	S33 const *s;
	S33 const * const cs;
} S34;

typedef struct {
	struct {
		int i;
	} const *cp, *p, s;
} S35;

typedef struct {
	int length;
	char data[];
} S36;

struct S37 {
	int x, (*y)(void), (*z)(int i);
};

typedef enum E4_ {
	E4_1,
} E4;

typedef enum {
	E5_1,
} E5;

typedef enum {
	E6_0,
	E6_1,
} __attribute__((packed)) E6;

typedef int T24[2];
typedef int T25[5][2];
typedef int const *T26[2];
typedef struct {
	int i;
} T27[3];


extern int const g1;
extern struct S24 const g2;
extern struct S24 * const g3;

extern int g4;
extern struct S24 g5;
extern struct S24 *g6;

static int const g7 = 0;


void f1(void);
extern void f2(void);
int f3(void);
void f4(int i);
int f5(int i, ...);
void f6(char const *p);
void f7(int i1, int i2, int, int, int i5);
void f8(int i1, int, int _2);
void f9(int (*arg)(int, int));
int (*f10(void))(int, int);
struct { int i; float f; } (*f11)(union { int i; float f; } x);

struct SG1 {
	int i;
} g8, (*f12)(union { int i; float j; } u[2], union N1 { int i; float j; } n, struct SG1 *s), f13(union { int i; float j; } u, union N2 { int i; float j; } n, struct SG1 *s);

static void f14(void);

struct S38 {
	void (*f)();
};


#define DEFINE_CHAR ('\'')
#define DEFINE_STRING ("\"")
// #define DEFINE_STRINGS ("\"" "\"")
#define DEFINE_INT (1234)
#define DEFINE_OxINT (0xabcd)
#define DEFINE_OINT (0777)
#define DEFINE_INTu (4321u)
#define DEFINE_FLOAT (0.1234f)
#define DEFINE_DOUBLE (0.1234)
//#define DEFINE_LONGDOUBLE (0.1234l)
#define DEFINE_DOT_FLOAT (.1234f)
#define DEFINE_DOT_DOUBLE (.1234)
//#define DEFINE_DOT_LONGDOUBLE (.1234l)
#define DEFINE_FLOAT_DOT (1234.f)
#define DEFINE_DOUBLE_DOT (1234.)
//#define DEFINE_LONGDOUBLE_DOT (1234.l)
#define DEFINE_EXP_FLOAT (-2.14e3f)
#define DEFINE_EXP_DOUBLE (-2.14e3)
//#define DEFINE_EXP_LONGDOUBLE (-2.14e3l)
#define DEFINE_INT_TYPE (int)
#define DEFINE_UINT_TYPE (unsigned int)
#define DEFINE_DEFINED DEFINE_INT_TYPE
// #define DEFINE_MATH ((DEFINE_DOUBLE+DEFINE_FLOAT) * (DEFINE_INT-DEFINE_OINT) / DEFINE_EXP_DOUBLE)
// #define DEFINE_INT_DIVIDE (1 / DEFINE_INT)
// #define DEFINE_OP_NEG (-i)
// #define DEFINE_OP_PRE_DEC (--i)
// #define DEFINE_OP_POST_DEC (i++)
// #define DEFINE_OP_DOT (s.i)
// #define DEFINE_OP_ARROW (s->i)
// #define DEFINE_OP_SUBSCRIPT (DEFINE_STRING[0])
// #define DEFINE_CALL (printf("\n"))
// #define DEFINE_INT_CAST ((int)0xffffffff)
// #define DEFINE_INTPTR_CAST ((int *)0xffffffff)
#define E6_0 0


#endif
