#ifndef STACK_H
#define STACK_H
#include "Node.h"

template <typename ST>
class Stack
{
    public:
        Stack();
        void push(ST value);
        bool isEmpty();
        T pop();
        Node<ST>* peak();
        virtual ~Stack();

    private:
        Node<ST>* top;
};

#endif // STACK_H
