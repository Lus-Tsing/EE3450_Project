///////////////////////////////////////////////////////
//    EE3450 Computer Architecture - Spring 109      //
//    Project: Find Greatest Common Divisors (GCD)   //
//    Binary GCD (gcdC.c)                            //
///////////////////////////////////////////////////////

#include <stdio.h>

int divide_by_two = 0;

int gcd(int a, int b)
{
    int check_a_even = 0, check_b_even = 0;

    check_a_even = (a & 1) == 0;
    check_b_even = (b & 1) == 0;

    // base case (E2)
    if (a == b)
        return a << divide_by_two;

    // a and b are even (BG1)
    else if (check_a_even && check_b_even)
    {
        // a and b shift right 1 bit
        divide_by_two += 1;
        return gcd(a >> 1, b >> 1);
    }

    // a is even, b is odd (BG2)
    else if (check_a_even)
        // a shifts right 1 bit
        return gcd(a >> 1, b);

    // a is odd, b is even (BG2)
    else if (check_b_even)
        // b shifts right 1 bit
        return gcd(a, b >> 1);

    // a is greater (E1)
    else if (a > b)
        return gcd(a - b, b);

    // b is greater (E1)
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
