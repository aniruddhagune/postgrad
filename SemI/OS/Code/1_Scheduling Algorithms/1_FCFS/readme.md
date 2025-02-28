## Problem Statement

Implement FCFS, SJF and SJF (pre-emptive) on processes in C/C++.<br/>
User input:<br/> 
- Number of processes
- CPU bursts
- Arrival times.
<br/>
Use different algorithms on the same data, and calculate
- Waiting times
- Turnaround times
- Response times
- Averages of those metrics
<br/>
Compare the average metrics between different algorithms.

## FCFS

Simple algorithm that serves processes in the order they arrive.
Processes are served to completion after which the process next in queue will be given CPU time.
