#include <iostream> 
#include <stdio.h>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

struct process {
    int ID;
    int CB;
    int AT=0;
};


int findShortestJob(const vector<process>& processes, int currentTime, vector<bool>& completed, const vector<int>& remainingTime) {
    int minIndex = -1;
    int minBurstTime = INT_MAX;

    for (int i = 0; i < processes.size(); i++) {
        
        if (processes[i].AT <= currentTime && !completed[i]) {
            if (remainingTime[i] < minBurstTime && remainingTime[i] > 0) {
                minBurstTime = remainingTime[i];
                minIndex = i; 
            }
        }
    }

    return minIndex;
}

void SJFP(vector<process>& processes) {
    int nP = processes.size();
    vector<int> WT(nP, 0);  
    vector<int> TAT(nP, 0);
    vector<int> RT(nP, -1); // -1 for the fact that processes will now be pre-empted, so -1 = not started.
    
    vector<int> remainingTime(nP);
    vector<bool> completed(nP, false);
    
    for (int i=0; i<nP; i++) {
        remainingTime[i] = processes[i].CB;
    }

    int currentTime = 0;
    int completedCount = 0;

    while (completedCount < nP) {
        int index = findShortestJob(processes, currentTime, completed, remainingTime);
        if (index == -1) {
            currentTime++;
            continue;  
        }
        
        // Since response time is only for the first time CPU is allocated.
        if (RT[index] == -1) {
            RT[index] = currentTime - processes[index].AT;
        }
        
        remainingTime[index] -= 1;
        currentTime++;

        if (remainingTime[index] == 0) {
            completedCount++;
            completed[index] = true;
            TAT[index] = currentTime - processes[index].AT;
            WT[index] = TAT[index] - processes[index].CB;
        }
    }
    
    // Avg Calculation
    int totalWT = 0, totalTAT = 0, totalRT = 0;
    for (int i = 0; i < nP; i++) {
        totalWT += WT[i];
        totalTAT += TAT[i];
        totalRT += RT[i];
    }
    
    float avgWT = (float)totalWT / nP;
    float avgTAT = (float)totalTAT / nP; 
    float avgRT = (float)totalRT / nP; 
    
    // Display
    cout << endl << "SJF (Pre-emptive) / Shortest Remaining Job First" << endl << endl;
    cout << setw(10) << "ID" << setw(15) << "CPU Burst" << setw(15) << "AT" << setw(15) << "WT" << setw(15) << "TAT" << setw(15) << "RT" << endl;
    
    for (int i = 0; i < nP; i++) {
        cout << setw(10) << processes[i].ID << setw(15) << processes[i].CB
             << setw(15) << processes[i].AT << setw(15) << WT[i] 
             << setw(15) << TAT[i] << setw(15) << RT[i] << endl;
    }
    
    cout << setw(10) << "---" << setw(15) << "---" << setw(15) << "---" << setw(15) << "---" << setw(15) << "---" << setw(15) << "---" << endl;
    
    cout << fixed << setprecision(2);
    cout << setw(10) << "Avg" << setw(15) << "---" << setw(15) << "---" 
         << setw(15) << avgWT << setw(15) << avgTAT << setw(15) << avgRT << endl;
}


// Separation
// For
// Readability

int main()
{
    vector<process> processes;
    
    int nP;
    cout << "Please enter the number of processes: ";
    cin >> nP; cout << endl;
    
    for (int i=0; i<nP; i++) {
        process p;
        
        p.ID = i+1;
        cout << "\nCPU burst of process " << i+1 << ": ";
        cin >> p.CB;
        cout << "Arrival time of the process " << i+1 << ": ";
        cin >> p.AT;
        
        processes.push_back(p);
    }
    
    SJFP(processes);
    return 0;
}
