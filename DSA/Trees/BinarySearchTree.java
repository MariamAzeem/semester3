class NodeBST {
    int data;
    NodeBST left, right;

    NodeBST(int value) {
        data = value;
        left = right = null;
    }
}

public class BinarySearchTree {
    NodeBST root;

    NodeBST insert(NodeBST node, int value) {
        if (node == null) {
            node = new NodeBST(value);
            return node;
        }
        if (value < node.data)
            node.left = insert(node.left, value);
        else if (value > node.data)
            node.right = insert(node.right, value);
        return node;
    }

    boolean search(NodeBST node, int key) {
        if (node == null)
            return false;
        if (node.data == key)
            return true;
        else if (key < node.data)
            return search(node.left, key);
        else
            return search(node.right, key);
    }

    NodeBST delete(NodeBST root, int key) {
        // Base case
        if (root == null)
            return root;

        // Traverse the tree to find the node
        if (key < root.data)
            root.left = delete(root.left, key);
        else if (key > root.data)
            root.right = delete(root.right, key);

        // Node found
        else {
            // CASE 1: No child (leaf node)
            if (root.left == null && root.right == null)
                return null;

            // CASE 2: One child
            else if (root.left == null)   // only right child
                return root.right;        // replace with right child
            else if (root.right == null)  // only left child
                return root.left;         // replace with left child

            // CASE 3: Two children
            else {
                NodeBST successor = successor(root); // find inorder successor
                root.data = successor.data;              // copy successor’s value
                root.right = delete(root.right, successor.data); // delete successor
            }
        }
        return root;
    }
	private NodeBST successor(NodeBST root) { //find least value below the right child of this root node
		NodeBST x = root.right;
		while(x != null){
			x = x.left;
		}
		return x;
	}
	
    void inorder(NodeBST node) {
        if (node == null) return;
        inorder(node.left);
        System.out.print(node.data + " ");
        inorder(node.right);
    }

    

    public static void main(String[] args) {
        BinarySearchTree bst = new BinarySearchTree();
        bst.root = bst.insert(bst.root, 50);
        bst.insert(bst.root, 30);
        bst.insert(bst.root, 70);
        bst.insert(bst.root, 20);
        bst.insert(bst.root, 40);
        bst.insert(bst.root, 60);
        bst.insert(bst.root, 80);

        System.out.print("Inorder Traversal: ");
        bst.inorder(bst.root);

        int key = 40;
        if (bst.search(bst.root, key))
            System.out.println("\n" + key + " found in tree");
        else
            System.out.println("\n" + key + " not found");
    }
}
