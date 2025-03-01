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


// Superseded by findShortestJob; this checks for AT first and CB second
// but SJF would still look at lowest CB in the queue
// So a static sort of two conditions won't be correct
// There needs to be a function to dynamically find shortest CB job in ready queue

/*bool sortSJFnP(const process &a, const process &b) {
    if (a.AT == b.AT) {
        return a.CB<b.CB;
    }
    return a.AT < b.AT;
}*/ 

int findShortestJob(const vector<process>& processes, int currentTime, vector<bool>& completed) {
    int minIndex = -1;
    int minBurstTime = INT_MAX;

    for (int i = 0; i < processes.size(); i++) {
        // Check if the process has arrived and is not yet completed
        if (processes[i].AT <= currentTime && !completed[i]) {
            if (processes[i].CB < minBurstTime) {
                minBurstTime = processes[i].CB;
                minIndex = i; // Update the index of the shortest job
            }
        }
    }

    return minIndex; // Return the index of the process with the shortest job
}

void SJFnP(vector<process>& processes) {
    int nP = processes.size();
    vector<int> WT(nP, 0);  
    vector<int> TAT(nP, 0);
    vector<int> RT(nP, 0);
    vector<bool> completed(nP, false); // Because sorting by AT & then by CB would be wrong.

    int currentTime = 0;

    for (int count = 0; count < nP; count++) {

        int index = findShortestJob(processes, currentTime, completed);
        if (index == -1) {
            currentTime++;
            count--; 
            continue;
        }

        RT[index] = currentTime;
        WT[index] = currentTime - processes[index].AT; 
        TAT[index] = WT[index] + processes[index].CB; 

        currentTime += processes[index].CB; 
        completed[index] = true;
    }

    // Calculation for average
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
    cout << endl << "SJF (Non-Preemptive)" << endl;
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
    
    SJFnP(processes);
    return 0;
}
