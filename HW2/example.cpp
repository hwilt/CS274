#include <stdio.h>
#include <iostream>
using namespace std;

void printTriangle(int rows){
    int space;

    for(int i = 1, k = 0; i <= rows; ++i, k = 0){
        for(space = 1; space <= rows - i; ++space){
            cout << " ";
        }
        while(k != 2*i-1){
            cout << "*";
            ++k;
        }
        cout << endl;
    }
}

int main(){
    int n = 0;
    cout << "Enter number of rows: ";
    cin >> n;
    if(n <= 0){
        cout << "Choose a bigger number!";
    }
    else{
        printTriangle(n);
    }
    return 0;
}