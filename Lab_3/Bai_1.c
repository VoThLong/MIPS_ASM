#include <stdio.h>

int main()
{
    int arr1[] = {5, 6, 7, 8, 1, 2, 3, 9, 10, 4};
    int arr2[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    int arr3[8];
    int size1 = 10;
    int size2 = 16;
    int size3 = 8;

    for (int i = 0; i < size3; i++)
    {
        arr3[i] = arr1[i] + arr2[size2 - 1 - i];
    }

    for (int i = 0; i < size3; i++)
    {
        printf("%d ", arr3[i]);
    }
}