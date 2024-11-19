#include <iostream>
#include "Node.h"
#include "LinkedList.h"

using namespace std;

int main()
{
    Node<int,int> n(1,2);
    Node<int,int>* pn = &n;
    LinkedList<int,int> l1(pn);

    l1.insertBefore(4,20);

    l1.insertAfter(3,5);
    l1.traverse();
    std::cout<< l1.length() << std::endl;
    return 0;
}
