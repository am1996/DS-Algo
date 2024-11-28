#ifndef LINKEDLIST_H
#define LINKEDLIST_H
#include "Node.h"

template <typename KT,typename DT>
class LinkedList
{
    public:
        Node<KT,DT>* head;
        Node<KT,DT>* cursor;
        Node<KT,DT>* prev;
    public:
        LinkedList();
        LinkedList(Node<KT,DT>* head);
        LinkedList(Node<KT,DT>* head,
                  Node<KT,DT>* cursor,
                  Node<KT,DT>* prev);

        bool listIsEmpty();
        bool curIsEmpty();
        void toFirst();
        void advance();
        void toEnd();
        int length();
        void insertFirst(KT key,DT value);
        void insertAfter(KT key,DT value);
        void insertBefore(KT key,DT value);
        void updateData(Node<KT,DT>* p);
        DT retrieveData();
        void traverse();
        virtual ~LinkedList();

    protected:

    private:
};

#endif
