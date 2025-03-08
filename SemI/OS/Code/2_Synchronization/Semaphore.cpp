/*
Implement process synchronization through semaphore by accepting following input:
1. Semaphore variables value
2. No. of processes having different priorities

- Assign Random priority between 0 to 10 to each process.
- Allow processes in critical section with consideration of higher priority processes first and so on.

The output of the program is total number of processes with names in critical section.
Total number of processes is in waiting state.
*/

#include <iostream>
#include <stdio.h>
#include <vector>
#include <time.h>
#include <stdlib.h>
#include <algorithm>

using namespace std;

struct process {
	int ID; int Priority;
};

// Semaphores
bool P(int& s) {
	if (s > 0) {
		s--;
		return true;
	}
	return false;
}

void V(int& s) {
	s++;
}

// Process
void createProcessVector(int nP, vector<process>& processes){
	cout << "---Processes generated--- \n";
	for (int i=0; i<nP; i++) {
		process p;

		p.ID = i+1;
		p.Priority = rand() % 11;

		cout << "Process ID: " << p.ID << ",Priority: " << p.Priority << endl;

		processes.push_back(p);
	}
	cout << endl;
}

bool sortPriority(const process& p1, const process& p2) {
	return p1.Priority > p2.Priority;
}

void requestAccess(int& s, vector<process>& processes) {
	int CS = 0, notCS = 0;

	sort(processes.begin(), processes.end(), sortPriority);

	cout << "---Simulating---\n";
	for (const auto& p : processes) {
        if (P(s)) {
            cout << "Process ID: " << p.ID << " (Priority: " << p.Priority 
                 << ") entered critical section.\n";
            CS++;
        } else {
            cout << "Process ID: " << p.ID << " (Priority: " << p.Priority 
                 << ") is waiting.\n";
            notCS++;
        }
    }

    cout << "\nTotal in critical section: " << CS << "\n";
    cout << "Total in waiting state: " << notCS << "\n";
}

int main() {

	vector<process> processes;

	int s, nP;
	srand(time(NULL));

	cout << "Enter value of Semaphore variable: "; cin >> s;
	cout << "Enter number of processes: "; cin >> nP; cout << endl;

	createProcessVector(nP, processes);
	requestAccess(s, processes);

	return 0;
	
}
