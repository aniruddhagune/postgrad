/*
Implement Contiguous memory allocation techniques
1. First fit
2. Best Fit
3. Worst fit
4. Next fit

Input:
1. No. of holes with size
2. No. of processes with sizes
3. Choose allocation strategy

Output:
1. Which process is allocated in which hole
2. How many processes are de-allocated due to insufficient space
3. After complete allocation, total free size of memory
*/

#include <iostream>
#include <vector>
#include <climits>

using namespace std;

struct process {
    int ID; int size; int holeID = -1; 
};

struct hole {
    int ID; int totalSize; int remSize;
};

// Initializers
void initHoles(vector<hole>& holes) {

    int nH;
    cout << "Enter number of holes: ";
    cin >> nH;

    for (int i = 0; i < nH; i++) {
        hole h;
        h.ID = i + 1;
        cout << "Enter size of hole " << h.ID << ": ";
        cin >> h.totalSize;
        h.remSize = h.totalSize;
        holes.push_back(h);
    }
    cout << "\n";
}

void initProcesses(vector<process>& processes) {

    int nP;
    cout << "Enter number of processes: ";
    cin >> nP;

    for (int i = 0; i < nP; i++) {
        process p;
        p.ID = i + 1;
        cout << "Enter size of process " << p.ID << ": ";
        cin >> p.size;
        processes.push_back(p);
    }
    cout << "\n";
}

// Reseters
void resetHoles(vector<hole>& holes) {
    for (auto& h : holes) {
        h.remSize = h.totalSize;
    }
}

void resetProcesses(vector<process>& processes) {
    for (auto& p : processes) {
        p.holeID = -1;
    }
}

// Show result
void report(const vector<process>& processes, const vector<hole>& holes) {
    cout << "\nAllocations: \n";
    for (const auto& p : processes) {
        if (p.holeID != -1) {
            cout << "Process " << p.ID << " is allocated to Hole " << p.holeID << "\n";
        } else {
            cout << "Process " << p.ID << " did not get allocated due to insufficient space.\n";
        }
    }

    cout << "\nHole details:\n";
    for (const auto& h : holes) {
        cout << "Hole " << h.ID << ": Remaining size = " << h.remSize 
             << ", Total size = " << h.totalSize << "\n";
    }

    int remTotal = 0;
    for (const auto& h : holes) {
        remTotal += h.remSize;
    }
    cout << "\nTotal free size of memory is " << remTotal << "\n";
}


// --- Allocation Algorithms ---

// First Fit
void firstFit(vector<process>& processes, vector<hole>& holes) {

    cout << "\nSimulating First Fit...\n";

    for (auto& p : processes) {
        for (auto& h : holes) {
            if (p.size <= h.remSize) {
                p.holeID = h.ID;
                h.remSize -= p.size;
                break;
            }
        }
    }
}

// Best Fit 
void bestFit(vector<process>& processes, vector<hole>& holes) {

    cout << "\nSimulating Best Fit...\n";

    for (auto& p : processes) {

        int aptSize = INT_MAX, aptIndex = -1;

        for (int i = 0; i < holes.size(); ++i) {
            if (p.size <= holes[i].remSize && holes[i].remSize < aptSize) {
                aptSize = holes[i].remSize;
                aptIndex = i;
            }
        }
        if (aptIndex != -1) {
            p.holeID = holes[aptIndex].ID;
            holes[aptIndex].remSize -= p.size;
        }
    }
}

// Worst Fit
void worstFit(vector<process>& processes, vector<hole>& holes) {

    cout << "\nSimulating Worst Fit...\n";

    for (auto& p : processes) {

        int aptSize = -1, aptIndex = -1;

        for (int i = 0; i < holes.size(); ++i) {
            if (p.size <= holes[i].remSize && holes[i].remSize > aptSize) {
                aptSize = holes[i].remSize;
                aptIndex = i;
            }
        }
        if (aptIndex != -1) {
            p.holeID = holes[aptIndex].ID;
            holes[aptIndex].remSize -= p.size;
        }
    }
}

// Next Fit
void nextFit(vector<process>& processes, vector<hole>& holes) {

    cout << "\nSimulating Next Fit...\n";

    int lastIndex = 0; // Start from the first hole

    for (auto& p : processes) {

        for (int i = lastIndex; i < holes.size(); ++i) {
            if (p.size <= holes[i].remSize) {
                p.holeID = holes[i].ID;
                holes[i].remSize -= p.size;
                lastIndex = i;
                break;
            }
        }
        
        if (p.holeID == -1) { // Wrap around
            for (int i = 0; i < lastIndex; ++i) {
                if (p.size <= holes[i].remSize) {
                    p.holeID = holes[i].ID;
                    holes[i].remSize -= p.size;
                    lastIndex = i;
                    break;
                }
            }
        }

    }
}


int main() {
    vector<process> processes;
    vector<hole> holes;

    initHoles(holes);
    initProcesses(processes);

    int ch;
    do {
        cout << "\n\n1. First Fit | 2. Best Fit | 3. Worst Fit | 4. Next Fit | 0. Exit\n";
        cout << "Choose a strategy: ";
        cin >> ch;

        if (ch < 0 || ch > 4) {
            cout << "Enter a valid number.\n";
            continue;
        }

        if (ch == 0) {
            cout << "Exiting...\n";
            break;
        }

        resetHoles(holes);
        resetProcesses(processes);
        
        switch (ch) {
            case 1:
                firstFit(processes, holes);
                break;
            case 2:
                bestFit(processes, holes);
                break;
            case 3:
                worstFit(processes, holes);
                break;
            case 4:
                nextFit(processes, holes);
                break;
        }
        report(processes, holes);
    } while (ch != 0);

    return 0;
}
