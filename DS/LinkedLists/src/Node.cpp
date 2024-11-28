#include "Node.h"
#include <iostream>

template <typename KT, typename DT>
Node<KT, DT>::Node(KT k, DT d) : key(k), data(d), next(nullptr), prev(nullptr) {}

template <typename KT, typename DT>
void Node<KT,DT>::printNode() const {
    std::cout<<"Key: "<< Node::key <<" value: "<<Node::data<<std::endl;
}

template <typename KT, typename DT>
Node<KT,DT>::~Node(){}

template class Node<int, int>;
template class Node<float, float>;
template class Node<double, double>;
template class Node<std::string, std::string>;
template class Node<char, char>;
