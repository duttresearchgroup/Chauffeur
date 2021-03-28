import click
import os
import subprocess

base_command = "perf stat -e instructions:u,branch-misses,cache-misses,cache-references,cycles,instructions,alignment-faults,bpf-output,cs,cpu-clock,migrations,dummy,emulation-faults,major-faults,minor-faults,faults,task-clock,L1-dcache-load-misses,L1-dcache-loads,L1-dcache-store-misses,L1-dcache-stores,L1-icache-load-misses,L1-icache-loads,branch-load-misses,branch-loads,dTLB-load-misses,iTLB-load-misses"
perf_result = []
output_result = []
output_flag = False
# 1,2 bigcore
# 0,3,4,5 small-core
def change_hotplug(cpus):
    cpu_num = [ int(x) for x in cpus.split(",")]
    for c in range(6):
        if c in cpu_num:
            os.system("echo 1 > /sys/devices/system/cpu/cpu"+str(c)+"/online")
        else:
            os.system("echo 0 > /sys/devices/system/cpu/cpu"+str(c)+"/online")

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
    global base_command, perf_result,output_flag,output_result
    li = ""
    li += base_command + " " + cmd
    process = subprocess.Popen(li.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout_output, stderr_output = process.communicate()
    perf_result = stderr_output.decode("utf-8").strip().split("\n")
    number_of_instructions = 0
    ipc = 0
    for x in perf_result:
        if "insn" in x:
            x = ' '.join(x.split())
            r = x.split(' ')
            t = r[0].replace(',','')
            number_of_instructions = int(t)
            ipc = float(r[3])

    if output_flag:
        output_result.append(str(ipc)+"\n")
#        output_result.append("ipc,"+str(ipc)+"\n")
        return
    print("ipc result of "+cmd)
#    print("number of instructions = " + str(number_of_instructions))
    print("ipc = " + str(ipc))
    print("")

@click.option('--meminfo', is_flag=True , help="Get mem info")
@click.option('--exectime', is_flag=True, help="Get execution time of app")
@click.option('--cpus', type=click.STRING, help="default=0,1,2,3,4,5")
@click.option('--output', type=click.STRING, help="default=None")
@click.option('--cpi', is_flag=True, help="Cycles Per Instructions")
@click.option('--ipc', is_flag=True, help="instruction per cycle")
@click.argument('command')
@click.command()
def main(command, ipc, cpi, cpus, meminfo, exectime, output):
    global output_flag, output_result
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
