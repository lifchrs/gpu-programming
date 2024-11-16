#ifndef __GPU_UTILS_H__
#define __GPU_UTILS_H__

struct GpuTimer
{
      cudaEvent_t start;
      cudaEvent_t stop;

      GpuTimer()
      {
            cudaEventCreate(&start);
            cudaEventCreate(&stop);
      }

      ~GpuTimer()
      {
            cudaEventDestroy(start);
            cudaEventDestroy(stop);
      }

      void Start()
      {
            cudaEventRecord(start, 0);
      }

      void Stop()
      {
            cudaEventRecord(stop, 0);
      }

      float Elapsed()
      {
            float elapsed;
            cudaEventSynchronize(stop);
            cudaEventElapsedTime(&elapsed, start, stop);
            return elapsed;
      }
};

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

#endif  /* __GPU_UTILS_H__ */
