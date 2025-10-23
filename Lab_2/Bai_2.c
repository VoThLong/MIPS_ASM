#include <stdio.h>

int main()
{
    int SUM = 0;
    int N;
    scanf("%d", &N);
    for (int i = 0; i < N; i++)
    {
        SUM += i;
    }
    printf("%d \n", SUM);
}