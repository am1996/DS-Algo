#include "LinkedList.h"
#include <iostream>

template <typename KT,typename DT>
LinkedList<KT,DT>::LinkedList(): head(nullptr),cursor(nullptr),prev(nullptr){};

template <typename KT,typename DT>
LinkedList<KT,DT>::LinkedList(Node<KT,DT>* head): head(head),cursor(head),prev(head){};

template <typename KT,typename DT>
LinkedList<KT,DT>::LinkedList(Node<KT,DT>* head,
                  Node<KT,DT>* cursor,
                  Node<KT,DT>* prev) :
                            head(head),
                            cursor(cursor),
                            prev(prev){};


template <typename KT,typename DT>
bool LinkedList<KT,DT>::curIsEmpty(){
    return cursor == nullptr;
}

template <typename KT,typename DT>
void LinkedList<KT,DT>::toFirst(){
    cursor  = head;
    prev = nullptr;
}

template <typename KT,typename DT>
bool LinkedList<KT,DT>::listIsEmpty(){
    return head == nullptr;
}

template <typename KT,typename DT>
void LinkedList<KT,DT>::advance(){
    prev = cursor;
    cursor = cursor->next;
};

template <typename KT, typename DT>
void LinkedList<KT,DT>::toEnd(){
    toFirst();
    if(!listIsEmpty()) while(cursor->next != nullptr) advance();
}

template <typename KT, typename DT>
int LinkedList<KT,DT>::length(){
    Node<KT,DT>* q;
    int c = 0;
    q = head;
    while(q!= nullptr){
        c++;
        q = q->next;
    }
    return c;
}

template <typename KT, typename DT>
void LinkedList<KT, DT>::insertFirst(KT key, DT data){
    Node<KT,DT> node(key,data);
    Node<KT,DT>* pnew = &node;
    pnew->next = head;
    head = pnew;
    cursor = head;
    prev = NULL;
}

template <typename KT, typename DT>
void LinkedList<KT, DT>::insertAfter(KT key, DT data){
    if (cursor == nullptr) {
        std::cerr << "The given previous node cannot be null" << std::endl;
        return;
    }
    Node<KT, DT>* newNode = new Node<KT, DT>(key, data);
    newNode->next = cursor->next;
    cursor->next = newNode;
}

template <typename KT, typename DT>
void LinkedList<KT, DT>::insertBefore(KT key, DT data){
    if (prev == nullptr) {
        std::cerr << "The given previous node cannot be null" << std::endl;
        return;
    }
    Node<KT, DT>* newNode = new Node<KT, DT>(key, data);
    newNode->next = prev->next;
    prev->next = newNode;
}

template <typename KT, typename DT>
void LinkedList<KT,DT>::traverse(){
    Node<KT,DT>* pq = head;
    while(pq != nullptr){
        std::cout << "key: " << pq->key << " value: " << pq->data << std::endl;
        pq = pq->next;
    }

    return;
};

template <typename KT, typename DT>
void LinkedList<KT,DT>::updateData(Node<KT,DT>* p){
    cursor->data = p->data;
};


template <typename KT,typename DT>
DT LinkedList<KT,DT>::retrieveData(){
    if(cursor != nullptr) return cursor->data;
    return 0;
};

template <typename KT,typename DT>
LinkedList<KT,DT>::~LinkedList(){};

template class LinkedList<int, int>;
template class LinkedList<float, float>;
template class LinkedList<double, double>;
template class LinkedList<std::string, std::string>;
template class LinkedList<char, char>;