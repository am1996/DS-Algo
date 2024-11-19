#ifndef NODE_H
#define NODE_H

template <typename KT, typename DT>
class Node
{
    public:
        KT key; // key
        DT data; // Data
        Node *next;
        Node *prev;

    public:
        Node(KT key, DT data);
        void printNode() const;
        virtual ~Node();

    protected:

    private:
};

#endif // NODE_H
