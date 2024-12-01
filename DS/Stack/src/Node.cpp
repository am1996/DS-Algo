#include "Node.h"

template <typename T>
Node<T>::Node(T v)
{
    value = v;
    next = nullptr;
}
template <typename T>
Node<T>::~Node()
{
    //dtor
}
