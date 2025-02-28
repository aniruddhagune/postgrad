#include <iostream> 
#include <stdio.h>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

struct process {
    int ID; int CB; int AT=0;
};


bool sortAT(const process &a, const process &b) {
    return a.AT < b.AT;
}

// FCFS
void FCFS(vector<process>& processes) {
    int nP = processes.size();  
    vector<int> WT(nP, 0);  
    vector<int> TAT(nP, 0);
    vector<int> RT(nP, 0);
    
    int CT = 0;
    
    sort(processes.begin(), processes.end(), sortAT); 

    // Calculation for single process
    for (int i = 0; i < nP; i++) {
        if (CT < processes[i].AT) {
            CT = processes[i].AT; 
        }

        RT[i] = CT - processes[i].AT;
        WT[i] = CT - processes[i].AT;
        TAT[i] = WT[i] + processes[i].CB;
        
        CT += processes[i].CB; // Update Current Time
    }
    
   
    // Calculation for average
    int totalWT = 0, totalTAT = 0, totalRT = 0;
    for (int i = 0; i < nP; i++) {
        totalWT += WT[i];
        totalTAT += TAT[i];
        totalRT += RT[i];
    }
    
    float avgWT = (float) totalWT / nP;
    float avgTAT = (float) totalTAT / nP; 
    float avgRT = (float) totalRT / nP; 
    
    
    // Display
    cout << endl << "FCFS" << endl;
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
    
    FCFS(processes);
    return 0;
}
