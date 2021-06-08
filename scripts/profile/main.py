import click
import os
import subprocess

#base_command = "perf stat -e instructions:u,branch-misses,cache-misses,cache-references,cycles,instructions,alignment-faults,bpf-output,cs,cpu-clock,migrations,dummy,emulation-faults,major-faults,minor-faults,faults,task-clock,L1-dcache-load-misses,L1-dcache-loads,L1-dcache-store-misses,L1-dcache-stores,L1-icache-load-misses,L1-icache-loads,branch-load-misses,branch-loads,dTLB-load-misses,iTLB-load-misses"
base_command = "perf stat"
taskset_command = "taskset -c "
perf_result = []
output_result = []
output_flag = False
is_px2 = False
is_tx2 = False
# 1,2 bigcore
# 0,3,4,5 small-core
def change_hotplug(cpus):
    global taskset_command
    #cpu_num = [ int(x) for x in cpus.split(",")]
    #for c in range(6):
    #    if c in cpu_num:
    #        os.system("echo 1 > /sys/devices/system/cpu/cpu"+str(c)+"/online")
    #    else:
    #        os.system("echo 0 > /sys/devices/system/cpu/cpu"+str(c)+"/online")
    taskset_command+=cpus+" "
    

def get_exectime(cmd):
    global base_command, perf_result,output_flag,output_result
    if len(perf_result) == 0:
        li = ""
        li += base_command + " " + cmd
        process = subprocess.Popen(li.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout_output, stderr_output = process.communicate()
        perf_result = stderr_output.decode("utf-8").strip().split("\n")
    exectime = 0
    for x in perf_result:
        if "elapsed" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            exectime = float(t)
    if output_flag:
        output_result.append(str(exectime)+"\n")
        # output_result.append("exectime,"+str(exectime)+"\n")
        return
    print("exetime result of "+cmd)
    print("execution time = " + str(exectime))


def get_meminfo(cmd):
    global base_command, perf_result,output_flag,output_result
    if len(perf_result) == 0:
        li = ""
        li += base_command + " " + cmd
        process = subprocess.Popen(li.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout_output, stderr_output = process.communicate()
        perf_result = stderr_output.decode("utf-8").strip().split("\n")
    number_of_instructions = 0
    number_of_cycles = 0
    ipc = 0
    for x in perf_result:
        if "insn" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            number_of_instructions = int(t)
        elif "cycles" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            number_of_cycles = int(t)
    if output_flag:
        output_result.append("cpi,"+str(number_of_cycles/number_of_instructions)+"\n")
        return

    print("cpi result of "+cmd)
    print("cpi = " + str(number_of_cycles/number_of_instructions))

def get_cpi(cmd):
    global base_command, perf_result,output_flag,output_result
    if len(perf_result) == 0:
        li = ""
        li += base_command + " " + cmd
        process = subprocess.Popen(li.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout_output, stderr_output = process.communicate()
        perf_result = stderr_output.decode("utf-8").strip().split("\n")
    number_of_instructions = 0
    number_of_cycles = 0
    ipc = 0
    for x in perf_result:
        if "insn" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            number_of_instructions = int(t)
        elif "cycles" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            number_of_cycles = int(t)

    if output_flag:
        output_result.append("cpi,"+str(number_of_cycles/number_of_instructions)+"\n")
        return
    print("cpi result of "+cmd)
    print("cpi = " + str(number_of_cycles/number_of_instructions))

def get_ipc(cmd):
    global base_command, perf_result,output_flag,output_result, is_px2, is_tx2,taskset_command
    li = ""
    li += taskset_command + base_command + " " + cmd
    process = subprocess.Popen(li.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout_output, stderr_output = process.communicate()
    perf_result = stderr_output.decode("utf-8").strip().split("\n")
    number_of_instructions = 0
    #ipc = []
    ipc = 0
    #seq = []
    #seq = []
    exectime = 0
    for x in perf_result:
        if "insn" in x:
            print(x)
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            number_of_instructions = int(t)
            #seq.append(r[0][1])
            ipc = number_of_instructions
            #ipc.append(number_of_instructions)
        if "elapsed" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            exectime = float(t)
    # px2 1 -> 1997000
    #     0 -> 2035200

    # tx2 all -> 2035200
    #real_ipc = []
    #if is_px2 :
    #    for i ,data in enumerate(ipc):
    #        if seq[i] == "0":
    #            real_ipc.append(float(ipc[i])/(float(exectime)*2035200000))
    #        if seq[i] == "1":
    #            real_ipc.append(float(ipc[i])/(float(exectime)*1997000000))
    #if is_tx2 :
    #    for i ,data in enumerate(ipc):
    #        real_ipc.append(float(ipc[i])/(float(exectime)*2035200000))

    #calculated_ipc = sum(real_ipc)/len(real_ipc)
    calculated_ipc = ipc/(exectime*2035200000)
    if output_flag:
        output_result.append(str(calculated_ipc)+"\n")
#        output_result.append("ipc,"+str(ipc)+"\n")
        return
    print("# of instructions result of "+cmd)

    print("calculated ipc"+str(calculated_ipc))

#    print("number of instructions = " + str(number_of_instructions))
    print("ipc = " + str(ipc))
    print("")

@click.option('--meminfo', is_flag=True , help="Get mem info")
@click.option('--exectime', is_flag=True, help="Get execution time of app")
@click.option('--cpus', type=click.STRING, help="default=0,1,2,3,4,5")
@click.option('--output', type=click.STRING, help="default=None")
@click.option('--cpi', is_flag=True, help="Cycles Per Instructions")
@click.option('--ipc', is_flag=True, help="instruction per cycle")
@click.option('--device',type=click.STRING, help="px2/tx2")
@click.argument('command')
@click.command()
def main(command, ipc, cpi, cpus, meminfo, exectime, output, device):
    global output_flag, output_result, is_px2, is_tx2
    if device == "px2" or device == "PX2":
        is_px2 = True
    if device == "tx2" or device == "TX2":
        is_tx2 = True
    if output:
        output_flag = True
    if cpus:
        change_hotplug(cpus)
    else:
        change_hotplug("0,1,2,3,4,5") # maximum
    if ipc:
        get_ipc(command)
    if cpi:
        get_cpi(command)
    if exectime:
        get_exectime(command)
    if meminfo:
        get_meminfo(command)
    change_hotplug("0,1,2,3,4,5") # maximum

    if output:
        with open(output,"w") as f:
            f.writelines(output_result)
            f.close()
if __name__ == "__main__":
    main()
