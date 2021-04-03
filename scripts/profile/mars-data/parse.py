1. Loop all the files and select the ones which end in (-fine_trace.csv)
2. Extract the application name -- first part (e.g., jetson_inference)

    3. For each application extract <avg> power_cpu_w, power_gpu_w, power_mem_w
    
4. Create a new CSV (energy-results.csv) with Appname, <avg> power_cpu_w, <avg> power_gpu_w, <avg> power_mem_w