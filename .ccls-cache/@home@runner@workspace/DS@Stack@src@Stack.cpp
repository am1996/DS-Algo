#include "Stack.h"
#include <iostream>

template <typename ST>
Stack<ST>::Stack()
{
    top = nullptr;
}

template <typename ST>
bool Stack<ST>::isEmpty(){
    return top == nullptr;
}

template <typename ST>
T Stack<ST>::pop(){
    if(isEmpty()){
        std::cout << "Stack Underflow\n";
        exit(1);
    }
    ST data = top->value;
    Node<ST>* temp = top;
    top = top->next;
    delete temp;
    return data;
}

template <typename ST>
void Stack<ST>::push(ST value){
    Node<ST>* node = new Node<ST>(value);
    node->next = top;
    top = node;
}

template <typename ST>
Node<ST>* Stack<ST>::peak(){
    if (isEmpty()) {
        std::cout << "Stack is Empty\n";
        exit(1);
    }
    return top->data;
}

template <typename ST>
Stack<ST>::~Stack()
{
    //dtor
}

template class Stack<int>;
template class Stack<float>;
template class Stack<double>;
template class Stack<bool>;
template class Stack<std::string>;
