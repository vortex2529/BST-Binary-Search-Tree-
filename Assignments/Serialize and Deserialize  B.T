
class Codec {
public:

    // Encodes a tree to a single string.
    
    string serialize(TreeNode* root) {
        if(!root) return "";
        string s = "";

        queue<TreeNode*> q;
        q.push(root);
        while(!q.empty()){
            auto front = q.front();
            q.pop();

        

            if(!front){
                s.append("#,");
            }
            else{
                s.append(to_string(front->val) + ',');
            }

            if(front){
                if(front->left) q.push(front->left);
                else q.push(0);
                if(front->right) q.push(front->right);
                else q.push(0);

            }
        }
        cout<<s<<endl;
        return s;
    }

    // Decodes your encoded data to tree.
    
    TreeNode* deserialize(string data) {
        if(data.size() == 0) return 0;
        stringstream s(data);

        string str;
        getline(s,str,',');
        TreeNode* root = new TreeNode(stoi(str));
        queue<TreeNode*> q;
        q.push(root);
        while(!q.empty()){
            auto front = q.front();
            q.pop();

            getline(s,str,',');
            if(str == "#"){
                front->left = 0;
            }
            else{
                TreeNode* leftNode = new TreeNode(stoi(str));
                front->left = leftNode;
                q.push(leftNode);
            }

            getline(s,str,',');
            if(str == "#"){
                front->right = 0;
            }
            else{
                TreeNode* rightNode = new TreeNode(stoi(str));
                front->right = rightNode;
                q.push(rightNode);
            }
        }

        return root;

    }
};

