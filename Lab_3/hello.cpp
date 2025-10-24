#include<iostream>
using namespace std;

int main()
{
    int a, b;
    int n;
    cin >> a >> b >> n;
    int sum = 0;
    int i=0;
    while (i<n){
        sum+= a*b;
        a++;
        b++;

        i++;
    }
    cout<< sum;
}