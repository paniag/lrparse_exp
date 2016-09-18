#include <iostream>
#include <vector>

using namespace std;

class DFA {
public:
    DFA(size_t letters, size_t states)
        : N(letters), Q(states), q0(0), T(), qfs()
    {
        // The default is for each state to loop back on itself.
        for (int q = 0; q < Q; q++) {
            T.emplace_back(vector<size_t>(N, q));
        }
    }

    DFA & SetStart(size_t start) {
        q0 = start;
        return *this;
    }

    DFA & SetTrans(size_t qi, size_t l, size_t qn) {
        T[qi][l] = qn;
        return *this;
    }

    DFA & SetFinals(const vector<size_t> & finals) {
        qfs = finals;
        return *this;
    }

    template <class ForwardIt>
    bool Accepts(ForwardIt first, ForwardIt last) {
        size_t q = q0;
        for (ForwardIt curr = first; curr != last; curr++) {
            q = T[q][*curr];
        }
        return accepting(q);
    }

private:
    bool accepting(size_t q) {
        for (auto it = qfs.begin(); it != qfs.end(); ++it) {
            if (q == *it) {
                return true;
            }
        }
        return false;
    }

    // Size of alphabet. Alphabet is [0,N).
    size_t N;
    // Number of states. State space is [0,Q).
    size_t Q;
    // Starting state. Defaults to 0.
    size_t q0;
    // Transition table. T[q][l] is the new state after receiving letter l
    // while in state q.
    vector<vector<size_t>> T;
    // Accepting states. Defaults to empty.
    vector<size_t> qfs;
};

int main(int argc, char * argv[]) {
    // d accepts binary strings of odd length.
    DFA d(2, 2);
    d.SetTrans(0,0,1)
     .SetTrans(0,1,1)
     .SetTrans(1,0,0)
     .SetTrans(1,1,0)
     .SetFinals({1});

    // Test cases.
    vector<vector<size_t>> pos{
        {0},
        {0,0,0},
        {1,0,1},
        {0,1,1}
    };
    vector<vector<size_t>> neg{
        {0,0},
        {1,0},
        {1,0,1,1},
        {}
    };

    // Run tests and show results.
    cout << "pos" << endl;
    for (auto it = pos.begin(); it != pos.end(); ++it) {
        cout << d.Accepts(it->begin(), it->end());
    }
    cout << endl;
    cout << "neg" << endl;
    for (auto it = neg.begin(); it != neg.end(); ++it) {
        cout << d.Accepts(it->begin(), it->end());
    }
    cout << endl;

    return 0;
}
