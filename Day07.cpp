#include <iostream>
#include <fstream>
#include <iterator>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

class Node {
    public:
    Node(string dirName, Node *parent) {
        this->name = dirName;
        this->isDir = true;
        this->parent = parent;
    }
    
    Node(string fileName, int size, Node *parent) {
        this->name = fileName;
        this->isDir = false;
        this->size = size;
        this->parent = parent;
    }

    bool isDir;
    int size;
    string name;
    vector<Node *> files;
    vector<Node *> folders;
    Node *parent;
};

void buildTree(Node *cur, vector<vector<string>> &a) {

    while (a.size()) {
        vector<string> row = a[0]; a.erase(a.begin());

        if (row[0] == "$") { // Command
            if (row[1] == "ls") { // do nothing
                continue;
            }
            else if (row[1] == "cd") { // move in
                if (row[2] == "..") {
                    buildTree(cur->parent, a);
                } else { // Move into a child dir
                    for (auto c : cur->folders) {
                        if (c->name == row[2]) {
                            buildTree(c, a);
                            break;
                        }
                    }
                }
            } 
        } else { // Files and dirs
            if (row[0] == "dir") {
                Node *n = new Node(row[1], cur);
                cur->folders.push_back(n);
            } else {
                Node *n = new Node(row[1], atoi(row[0].c_str()), cur);
                cur->files.push_back(n);
            }
        }
    }
}

long calcDirSizes(Node *cur) {
    int s = 0;

    for (auto f : cur->files) s = s + f->size;
    for (auto d : cur->folders) s = s + calcDirSizes(d);

    cur->size = s;

    return s;
}

void printTree(string o, Node *cur) {
    for(auto f : cur->files) {
        cout << o << f->name << endl;
    }

    for(auto f : cur->folders) {
        cout << o << "/" << f->name <<  " " << f->size << endl;
        printTree(o+"  ", f);
    }
}

long getBigs(Node *cur) {
    long ret = 0;
    if (cur->size <= 100000) { ret += (cur->size); }
    for(auto f : cur->folders) {
        ret += getBigs(f);
    }

    return ret;
}



long part2(long target, int best, Node *cur) {
    if (cur->size < best && cur->size >= target) {
        best = cur->size;
    }
    for(auto f : cur->folders) {
        best = part2(target, best, f);
    }

    return best;
}


int main()
{
    vector<vector<string>> vec;

    ifstream file_in("input.txt");

    // Split up the input
    string line;
    while (getline(file_in, line))
    {
        istringstream ss(line);
        string word;
        vector<string> words;

        while (ss >> word) words.push_back(word);
        vec.push_back(words);
    }

    // Build a tree
    Node *root = new Node("/", NULL);
    vec.erase(vec.begin());
    buildTree(root, vec);
    calcDirSizes(root);
    printTree("", root);

    // Bodge results
    int sum = getBigs(root);
    cout << "Part 1 " << sum <<  endl;

    long target = 532950;
    cout << "Part 2 " << part2(target, 70000000, root) << endl;
}
