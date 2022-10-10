#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>

struct ListNode {
      int val;
      struct ListNode *next;
};

struct ListNode* initListNode(int forloop) {
   //create a link
   struct ListNode* forveri= (struct ListNode*)malloc(sizeof(struct ListNode));
   forveri->val = 0;
   struct ListNode* head = forveri;
   for(int i = 1; i< forloop ; i++)
   {
        struct ListNode* newlinked = (struct ListNode*)malloc(sizeof(struct ListNode));
        newlinked->val = i; // assign data in first node
        head->next = newlinked; // Link first node with second
        head = head->next;
   }
   head->next = NULL;

   return forveri;
}

struct ListNode* initErrorList(int forloop,int Errorpoint)
{
   struct ListNode* forveri= (struct ListNode*)malloc(sizeof(struct ListNode));
   struct ListNode* ErrorNode;
   forveri->val = 0;
   struct ListNode* head = forveri;
   for(int i = 1; i< forloop ; i++)
   {
        struct ListNode* newlinked = (struct ListNode*)malloc(sizeof(struct ListNode));
        newlinked->val = i; // assign data in first node
        head->next = newlinked; // Link first node with second
        head = head->next;
        if( i == Errorpoint)
        {
            ErrorNode = head;
        }
   }
   head->next = ErrorNode;

   return forveri;
}
bool hasCycle(struct ListNode *head) {
        struct ListNode *second = head, *first = head;
        while (first && first->next) {
            second = second->next;
            first = first->next->next;
            if (second == first) 
            {
                 return true;
            }
        }
        return false;      
}
int main(){
    struct ListNode* first = initErrorList(5,2);
    struct ListNode* second = initListNode(5);
    struct ListNode* third = initListNode(10);

    printf("%d\n",hasCycle(first));
    printf("%d\n",hasCycle(second));
    printf("%d\n",hasCycle(third));
    return 0;
}


