#include <stdio.h>
#define  MAX 100

int main()
{
    int A[MAX];
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
    {
        scanf("%d", &A[i]);
    }

    int i, j;

    scanf("%d %d", &i, &j);

    if (i < j)
    {
        A[i] = i;
    }
    else
    {
        A[i] = j;
    }

    printf("%d\n", A[i]);

    return 0;
}