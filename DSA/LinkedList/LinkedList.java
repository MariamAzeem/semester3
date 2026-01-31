import java.util.ArrayList;
import java.util.Collections;

class Node {
    int data;
    Node next;

    public Node(int data) {
        this.data = data;
    }

    public Node(int data, Node next) {
        this.data = data;
        this.next = next;
    }

    public int count() {
        int count = 0;
        for (Node p = this; p != null; p = p.next) {
            count++;
        }
        return count;
    }

    public int sum() {
        int sum = 0;
        for (Node p = this; p != null; p = p.next) {
            sum += p.data;
        }
        return sum;
    }

    public void printList() {
        for (Node p = this; p != null; p = p.next) {
            System.out.print(p.data + " ");
        }
        System.out.println();
    }

    public Node insert(int x) {
        if (this.data > x) {
            Node p = new Node(x, this);
            return p;
        }
        Node p = this;
        while (p.next != null) {
            if (p.next.data > x) {
                break;
            }
            p = p.next;
        }
        p.next = new Node(x, p.next);
        return this;
    }

    public Node delete(int x) {
        if (this.data > x) {
            return this;
        }
        if (this.data == x) {
            return this.next;
        }
        Node p = this;
        while (p != null) {
            if (p.next.data > x) {
                break;
            }
            if (p.next.data == x) {
                p.next = p.next.next;
                break;
            }
            p = p.next;
        }
        return this;
    }

    public boolean search(int x) {
        if (x < this.data) {
            return false;
        }
        if (this.data == x) {
            return true;
        }
        Node p = this.next;
        while (p != null) {
            if (p.data > x) {
                break;
            }
            if (p.data == x) {
                return true;
            }
            p = p.next;
        }
        return false;
    }

    public Node replace1(int x, int position) {
        if (this.data > position) {
            return this;
        }
        if (this.data == position) {
            this.data = x;
            return this;
        }
        Node p = this.next;
        while (p != null) {
            if (p.data > position) {
                break;
            }
            if (p.data == position) {
                p.data = x;
            }
            p = p.next;
        }
        return this;
    }

    public Node replace2(int x, int position) {
        if (position > this.count())
            return this;
        Node p = this;
        for (int i = 1; i < position; i++) {
            p = p.next;
        }
        p.data = x;
        return this;
    }

    public static Node copy(Node copy, int copyFrom, Node paste, int pasteFrom, int copyTill) {
        Node p = copy;
        for (int i = 1; i < copyFrom; i++) {
            p = p.next;
        }
        Node q = paste;
        for (int i = 1; i < pasteFrom; i++) {
            q = q.next;
        }
        for (int i = 1; i <= copyTill; i++) {
            q.data = p.data;
            p = p.next;
            q = q.next;
        }
        return paste;
    }

    public Node copy(Node start) {
        Node copy = new Node(start.data);
        Node p = copy, q = start;
        for (int i = 1; i < start.count(); i++) {
            p.next = new Node(q.next.data);
            p = p.next;
            q = q.next;
        }
        return copy;
    }

    public Node concate(Node n2) {
        Node concated = this;
        int n1count = this.count();
        for (int i = 1; i < n1count; i++) {
            concated = concated.next;
        }
        concated.next = n2;
        return this;
    }

    public Node dltLast() {
        Node p = this;
        int count = this.count();
        for (int i = 1; i < count - 1; i++) {
            p = p.next;
        }
        p.next = null;
        return this;
    }

    public Node reverse() {
        int count = this.count();
        Node[] reverse = new Node[count];
        Node p = this;
        for (int i = 0; i < count; i++) {
            reverse[i] = p;
            p = p.next;
        }
        for (int i = 0; i <= count / 2; i++) {
            Node temp = reverse[i];
            reverse[i] = reverse[count - 1 - i];
            reverse[count - 1 - i] = temp;
        }
        for (int i = 0; i < count - 1; i++) {
            reverse[i].next = reverse[i + 1];
        }
        reverse[count - 1].next = null;
        return reverse[0];
    }

    public Node reversedCopy() {
        int count = this.count();
        Node[] reverse = new Node[count];
        Node p = this;
        for (int i = 0; i < count; i++) {
            reverse[i] = p;
            p = p.next;
        }
        Node reversedCopy = new Node(reverse[count - 1].data);
        Node q = reversedCopy;
        for (int i = count - 2; i >= 0; i--) {
            q.next = new Node(reverse[i].data);
            q = q.next;
        }
        return reversedCopy;
    }

    public Node shuffle() {
        int count = this.count();
        ArrayList<Node> shuffle = new ArrayList<>();
        Node p = this;
        for (int i = 0; i < count; i++) {
            shuffle.add(p);
            p = p.next;
        }
        Collections.shuffle(shuffle);
        for (int i = 0; i < count - 1; i++) {
            shuffle.get(i).next = shuffle.get(i + 1);
        }
        shuffle.get(count - 1).next = null;
        return shuffle.get(0);
    }

    public Node[] bifurcate() {
        Node[] bifurcate = new Node[2];
        Node x = this;
        bifurcate[0] = new Node(x.data);
        x = x.next;
        Node p = bifurcate[0];
        int count = this.count();
        for (int i = 2; i <= count / 2; i++) {
            p.next = new Node(x.data);
            p = p.next;
            x = x.next;
        }
        bifurcate[1] = new Node(x.data);
        x = x.next;
        Node q = bifurcate[1];
        for (int i = (count / 2) + 1; i < count; i++) {
            q.next = new Node(x.data);
            q = q.next;
            x = x.next;
        }
        return bifurcate;
    }

    public Node[] nLists(int n) {
        Node[] nNodes = new Node[n];
        int count = this.count();
        int size = count / n;
        int extra = count % n;
        Node p = this, q;
        for (int i = 0; i < n; i++) {
            int sizeOfList = size + (extra > i ? 1 : 0);
            q = new Node(p.data);
            p = p.next;
            nNodes[i] = q;
            for (int j = 1; j < sizeOfList; j++) {
                q.next = new Node(p.data);
                p = p.next;
                q = q.next;
            }
        }
        return nNodes;
    }

    public Node[] evenOddNodes() {
        Node[] tNodes = new Node[2];
        Node x = this;
        tNodes[0] = new Node(x.data);
        x = x.next;
        tNodes[1] = new Node(x.data);
        x = x.next;
        Node p = tNodes[0], q = tNodes[1];
        int count = this.count() / 2;
        for (int i = 1; i < count; i++) {
            p.next = new Node(x.data);
            x = x.next;
            p = p.next;
            q.next = new Node(x.data);
            x = x.next;
            q = q.next;
        }
        if (this.count() % 2 == 1) {
            p.next = new Node(x.data);
        }
        return tNodes;
    }
}

public class LinkedList {
    public static void main(String[] args) {
        // Create a linked list with 1->2->3->4->5
        Node head = new Node(1);
        Node p = head;
        for (int i = 2; i <= 5; i++) {
            p.next = new Node(i);
            p = p.next;
        }

        System.out.println("Original List:");
        head.printList();

        // Insert a new node
        head = head.insert(0);
        head = head.insert(6);
        System.out.println("\nAfter Insertion:");
        head.printList();

        // Delete a node
        head = head.delete(3);
        System.out.println("\nAfter Deleting 3:");
        head.printList();

        // Search for a value
        System.out.println("\nSearch for 4: " + (head.search(4) ? "Found" : "Not Found"));
        System.out.println("Search for 10: " + (head.search(10) ? "Found" : "Not Found"));

        // Reverse the list
        head = head.reverse();
        System.out.println("\nReversed List:");
        head.printList();

        // Bifurcate the list
        Node[] bif = head.bifurcate();
        System.out.println("\nBifurcated Lists:");
        System.out.print("First half: ");
        bif[0].printList();
        System.out.print("Second half: ");
        bif[1].printList();
    }
}
