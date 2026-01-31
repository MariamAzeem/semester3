import java.util.*;

public class BinaryTree {
    Object root;
    BinaryTree left, right;

    BinaryTree(Object root) {
        this.root = root;
    }

    BinaryTree(Object root, BinaryTree left, BinaryTree right) {
        this.root = root;
        this.left = left;
        this.right = right;
    }

    public void setRoot(Object root) {
        this.root = root;
    }

    public void setLeft(BinaryTree left) {
        this.left = left;
    }

    public void setRight(BinaryTree right) {
        this.right = right;
    }

    public Object getRoot() {
        return root;
    }

    public BinaryTree getLeft() {
        return left;
    }

    public BinaryTree getRight() {
        return right;
    }

    String InOrder() {
        StringBuffer s = new StringBuffer();
        if (left != null) {
            s.append(left.InOrder());
        }
        s.append(root);
        if (right != null) {
            s.append(right.InOrder());
        }
        return s.toString();
    }

    String preOrder() {
        StringBuffer s = new StringBuffer();
        s.append(root);
        if (left != null) {
            s.append(left.preOrder());
        }
        if (right != null) {
            s.append(right.preOrder());
        }
        return s.toString();
    }

    String postOrder() {
        StringBuffer s = new StringBuffer();
        if (left != null) {
            s.append(left.postOrder());
        }
        if (right != null) {
            s.append(right.postOrder());
        }
        s.append(root);
        return s.toString();
    }

    String levelOrder() {
        StringBuffer s = new StringBuffer();
        Queue<BinaryTree> q = new LinkedList<BinaryTree>();
        q.add(this);
        q.add(null);
        while (!q.isEmpty()) {
            BinaryTree x = q.poll();
            if (x == null) {
                s.append("\n");
                if (q.isEmpty())
                    break;
                else
                    q.add(null);
            } else {
                s.append(x.root);
                if (x.left != null)
                    q.add(x.left);
                if (x.right != null)
                    q.add(x.right);
            }
        }
        return s.toString();
    }

    Boolean isLeaf() {
        return left == null && right == null;
    }

    int size() {
        if (isLeaf())
            return 1;
        if (left == null)
            return 1 + right.size();
        if (right == null)
            return 1 + left.size();
        return 1 + left.size() + right.size();
    }

    int height() {
        if (isLeaf())
            return 0;
        if (left == null)
            return 1 + right.height();
        if (right == null)
            return 1 + left.height();
        return 1 + Math.max(left.height(), right.height());
    }

    Boolean search(Object x) {
        if (root == x || root.equals(x))
            return true;
        if (isLeaf())
            return false;
        if (left == null)
            return right.search(x);
        if (right == null)
            return left.search(x);
        return left.search(x) || right.search(x);
    }

    Boolean equals(BinaryTree t) {
        if (t == null)
            return false;
        if (root == null && t.root == null)
            return true;
        if (root == null || t.root == null)
            return false;
        if (!root.equals(t.root))
            return false;
        boolean leftEquals = (left == null && t.left == null) || (left != null && left.equals(t.left));
        boolean rightEquals = (right == null && t.right == null) || (right != null && right.equals(t.right));
        return leftEquals && rightEquals;
    }

    Boolean isFull() {
        if (isLeaf())
            return true;
        if (left != null && right != null) {
            return left.isFull() && right.isFull();
        }
        return false;
    }

    public static void main(String[] args) {
        BinaryTree bt = new BinaryTree(5, new BinaryTree(3, new BinaryTree(2), new BinaryTree(4)),
                new BinaryTree(7, new BinaryTree(6), new BinaryTree(8)));
        System.out.println(bt.search(5));
        System.out.println(bt.isFull());
        System.out.println(bt.height());
        System.out.println(bt.size());
        System.out.println(bt.InOrder());
        System.out.println(bt.preOrder());
        System.out.println(bt.postOrder());
        System.out.println(bt.levelOrder());
        BinaryTree bt2 = new BinaryTree(5, new BinaryTree(3, new BinaryTree(2), new BinaryTree(4)),
                new BinaryTree(7, new BinaryTree(6), new BinaryTree(8)));
        System.out.println(bt.equals(bt2));
        BinaryTree bt3 = new BinaryTree(5, new BinaryTree(3, new BinaryTree(2), new BinaryTree(4)),
                new BinaryTree(7, new BinaryTree(1), new BinaryTree(8)));
        System.out.println(bt.equals(bt3));
    }
}
