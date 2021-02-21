#include <stdio.h>
#include <iostream>
using namespace std;

void printTriangle(int rows, char ch){
    int i, j, k = 0;
    bool isLast = false; 
    for (i = 1; i <= rows; i++)
    { 
        if(i == rows){
            isLast = true;
        }
        if(isLast){
            for (i = 0; i < 2 * rows - 1; i++) { 
                cout << ch; 
            }
            for(int spaces = 0; spaces <= rows; spaces++){
                cout << " ";
            }
            for (i = 0; i < 2 * rows - 1; i++) { 
                cout << ch; 
            }
        }
        else{
            for (j = i; j < rows; j++) { 
                cout << " "; 
            }
            while (k != (2 * i - 1)) { 
                if (k == 0 || k == 2 * i - 2) 
                    cout << ch; 
                else
                    cout << " "; 
                k++; 
                ; 
            } 
            k = 0;
            //isHollow = false; 
            for (j = i; j < rows * 2; j++) { 
                cout << " "; 
            }
            for(int spaces = i; spaces <= rows; spaces++){
                cout << " ";
            }
            while(k != (2 * i - 1)){
                cout << ch;
                k++;
            }
            k = 0;
            cout << endl;
        }
    } 
}

int main(){
    int n = 0;
    char character = '*';
    cout << "Enter number of rows: ";
    cin >> n;
    cout << "Enter a character for the pyramid: ";
    cin >> character;
    if(n <= 0){
        cout << "Choose a bigger number!";
    }
    else{
        printTriangle(n, character);
    }
    return 0;
}