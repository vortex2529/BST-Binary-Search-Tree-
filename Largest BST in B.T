#include <iostream>
#include <queue>
#include <limits.h>
using namespace std;

class Node{
    public:
    int data;
    Node* left;
    Node* right;

    Node(int _data):data(_data),left(NULL),right(NULL){}
};

class NodeData{
    public:
    int size;
    int maxVal;
    int minVal;
    bool validBST;
    NodeData(){}
    NodeData(int s,int max,int min,bool valid):size(s),maxVal(max),minVal(min),validBST(valid){}
};


// Node* insertIntoBST(Node* root,int data){
//     if(!root){
//       // if first node
//       root = new Node(data);
//       return root;
//     }

//       // if not the first node
//     if(root->data > data){
//       // insert into left
//       root->left = insertIntoBST(root->left,data);
//     }
//     else{
//       // insert into right
//       root->right = insertIntoBST(root->right,data);
//     }

//     return root;
// }
// void takeInput(Node* &root){
//     int data;
//     cin>>data;
//     while(data != -1){
//       root = insertIntoBST(root,data);
//       cin>>data;
//     }
// }
void LevelOrderTraversal_PrintLevelWise(Node* root){
  queue<Node*> q;

  q.push(root);
  q.push(NULL);

  while(!q.empty()){

    Node* temp = q.front();
    q.pop();
    if(temp == NULL){
      cout<<endl;
      if(!q.empty()){
        q.push(NULL);
      }
    }
    else{
      cout<<temp->data<<" ";
      if(temp->left){
        q.push(temp->left);
      }
      if(temp->right){
        q.push(temp->right);
      }
    } 
  }
}

Node* buildTree(){
  int data;
  cin>>data;

  if(data == -1){
    return 0;
  }

  Node* root = new Node(data);
  root->left = buildTree();
  root->right = buildTree();

  return root;
}





NodeData largestBstFromBT(Node* root,int &ans){
  if(!root){
    NodeData temp(0,INT_MIN,INT_MAX,true); //size,max,min,valid
    return temp;
  }

  NodeData left = largestBstFromBT(root->left,ans);
  NodeData right = largestBstFromBT(root->right,ans);


  NodeData curr;

  curr.size = left.size + right.size + 1;
  curr.maxVal = max(root->data,right.maxVal);
  curr.minVal = min(root->data,left.minVal);
  
  if(left.validBST && right.validBST && (root->data > left.maxVal && root->data < right.minVal)){
      curr.validBST = true;
  }
  else{ 
      curr.validBST = false;
  }

  if(curr.validBST){
    ans = max(ans,curr.size);
  }
  return curr;

}

int main() {
    Node* root = buildTree();

    cout<<"Printing B.T :"<<endl;
    LevelOrderTraversal_PrintLevelWise(root);
    cout<<endl;

    int ans = 0;
    NodeData temp = largestBstFromBT(root,ans);

    cout<<"Printing Size of Largest BST nodes in a B.T :"<<ans<<endl;


}
