#include <stdio.h>
#include <stdlib.h>

void vecAdd(float* A_h, float* B_h, float* C_h, int n){
  for(int i = 0; i < n; ++i){
    C_h[i] = A_h[i] + B_h[i];
  }
}

int main(){
  int n;
  printf("Enter an array size: ");
  scanf("%d", &n);

  float* A = (float*)malloc(n * sizeof(float));
  float* B = (float*)malloc(n * sizeof(float));
  float* C = (float*)malloc(n * sizeof(float));

  for(int i = 0; i < n; ++i){
    A[i] = i;
    B[i] = i + 1;
  }
  vecAdd(A, B, C, n);
  for(int i = 0; i < n; ++i){
    printf("%f ", C[i]);
  }

  free(A);
  free(B);
  free(C);
  return 0;
}