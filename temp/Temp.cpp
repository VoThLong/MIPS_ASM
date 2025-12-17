#include <iostream>
using namespace std;

int main()
{
    int a[] = {1,18,36,47,5};
    int size = 5;

    int *b = a;
    int i = 0;
    while(true)
    {
        if (i == 5) {break;}
        int *temp = b + i;
        int temp2 = *temp;
        cout << temp2;
        i++;
    }

    return 0;
}