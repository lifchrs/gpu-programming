#include <iostream>

void vecAdd(float* A_h, float* B_h, float* C_h, int n){
  for(int i = 0; i < n; ++i){
    C_h[i] = A_h[i] + B_h[i];
  }
}

int main(){
  int n;
  std::cin >> n;
  float A[n], B[n], C[n];
  for(int i = 0; i < n; ++i){
    A[i] = i;
    B[i] = i + 1;
  }
  vecAdd(A, B, C, n);
  for(float i : C){
    std::cout << i << " ";
  }
  std::cout << "\n";
  return 0;
}