public class AVLTree {
    int key, height;
    AVLTree left, right;

    AVLTree(int key) {
        this.key = key;
        this.height = 0;
        left = right = null;
    }

    AVLTree(int key, AVLTree left, AVLTree right) {
        this.key = key;
        this.left = left;
        this.right = right;
        this.height = 1 + Math.max(height(left), height(right));
    }

    int height(AVLTree n) {
        return (n == null) ? -1 : n.height;
    }

    AVLTree insert(AVLTree t, int value) {
        if (t == null)
            return new AVLTree(value);

        if (value < t.key)
            t.left = insert(t.left, value);
        else if (value > t.key)
            t.right = insert(t.right, value);
        else
            return t; // duplicate

        // update height
        t.height = 1 + Math.max(height(t.left), height(t.right));

        // rebalance the node (in-place)
        t.rebalance();

        return t;
    }

    AVLTree delete(AVLTree t, int key) {
        // Base case
        if (t == null)
            return t;

        // Traverse the tree to find the node
        if (key < t.key)
         t.left = delete(t.left, key);
        else if (key > t.key)
         t.right = delete(t.right, key);

        // Node found
        else {
            // CASE 1: No child (leaf node)
            if(t.left == null && t.right == null)
                return null;

            // CASE 2: One child
            else if(t.left == null)   // only right child
                return t.right;        // replace with right child
            else if(t.right == null)  // only left child
                return t.left;         // replace with left child

            // CASE 3: Two children
            else {
                AVLTree successor = successor(t); // find inorder successor
             t.key = successor.key;              // copy successor’s value
             t.right = delete(t.right, successor.key); // delete successor
            }
        }
       // update height
       t.height = 1 + Math.max(height(t.left), height(t.right));

       // rebalance the node (in-place)
       t.rebalance();

       return t;
    }
	AVLTree successor(AVLTree t) { //find least value below the right child of this t node
		AVLTree x = t.right;
		while(x != null){
			x = x.left;
		}
		return x;
	}

    private void rotateLeft() {
        AVLTree newLeft = new AVLTree(key, left, right.left);
        key = right.key;
        right = right.right;
        left = newLeft;

        // Update heights after rotation
        left.height = 1 + Math.max(height(left.left), height(left.right));
        height = 1 + Math.max(height(left), height(right));
    }

    private void rotateRight() {
        AVLTree newRight = new AVLTree(key, left.right, right);
        key = left.key;
        left = left.left;
        right = newRight;

        // Update heights after rotation
        right.height = 1 + Math.max(height(right.left), height(right.right));
        height = 1 + Math.max(height(left), height(right));
    }

    void rebalance() {
        int balance = height(left) - height(right);

        // Right Heavy
        if (balance < -1) {
            if (right != null && height(right.left) > height(right.right))
                right.rotateRight();
            rotateLeft();
        }

        // Left Heavy
        else if (balance > 1) {
            if (left != null && height(left.right) > height(left.left))
                left.rotateLeft();
            rotateRight();
        }
    }

    @Override
    public String toString() {
        return inorder(this);
    }

    private String inorder(AVLTree node) {
        if (node == null) return "";
        return inorder(node.left) + " " + node.key + " " + inorder(node.right);
    }

    public static void main(String[] args) {
        AVLTree t = new AVLTree(5);
        t = t.insert(t, 4);
        t = t.insert(t, 3);
        t = t.insert(t, 2);
        t = t.insert(t, 8);
        System.out.println("Inorder Traversal:" + t);
    }
}
