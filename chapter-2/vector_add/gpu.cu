#include <stdio.h>
#include <stdlib.h>
#include "../../gpu_utils.cu"



__global__ 
void vecAddKernel(float* A, float* B, float *C, int n){
  int i = blockDim.x*blockIdx.x + threadIdx.x;
  if(i < n){
    C[i] = A[i] + B[i];
  }
}

void vecAdd(float* A_h, float* B_h, float* C_h, int n){
  const int size = n * sizeof(float);
  float* A_d;
  float* B_d;
  float* C_d;

  gpuErrchk(cudaMalloc((void**)&A_d, size));
  gpuErrchk(cudaMalloc((void**)&B_d, size));
  gpuErrchk(cudaMalloc((void**)&C_d, size));

  cudaMemcpy(A_d, A_h, size, cudaMemcpyHostToDevice);
  cudaMemcpy(B_d, B_h, size, cudaMemcpyHostToDevice);
  cudaMemcpy(C_d, C_h, size, cudaMemcpyHostToDevice);

  int blockSize = 256;

  GpuTimer timer;
  timer.Start();
  vecAddKernel<<<(n+blockSize-1)/blockSize, blockSize>>>(A_d, B_d, C_d, n);
  timer.Stop();

  printf("Block Size %d, %f ms\n", blockSize, timer.Elapsed());

  cudaMemcpy(C_h, C_d, size, cudaMemcpyDeviceToHost);

  cudaFree(&A_d);
  cudaFree(&B_d);
  cudaFree(&C_d);
}

int main(){
  int n{};
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

  free(A);
  free(B);
  free(C);
  return 0;
}