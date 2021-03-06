///////////////////////////////////////////////////////
//    EE3450 Computer Architecture - Spring 109      //
//    Project: Find Greatest Common Divisors (GCD)   //
//    Recursive method (gcdA.c)                      //
///////////////////////////////////////////////////////

#include <stdio.h>

int gcd(int a, int b)
{
    // base case a = b, then return answer
    if (a == b)
        return a;

    // a is greater, a = a - b, do recursive
    else if (a > b)
        return gcd(a - b, b);

    // b is greater, b = b - a, do recursive
    else
        return gcd(a, b - a);
}

int main(void)
{

    int a, b;

    printf("Please give 2 integers separated by enter:\n");

    scanf("%d", &a);
    scanf("%d", &b);

    a = gcd(a, b);

    printf("The greatest common divisor is %d\n", a);

    return 0;
}