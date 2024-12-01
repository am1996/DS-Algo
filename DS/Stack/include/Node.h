#ifndef NODE_H
#define NODE_H

template <typename T>
class Node
{
    public:
        Node(T v);
        T value;
        Node<T>* next;
        virtual ~Node();
};

#endif // NODE_H
