public class LinkedQueue {
    private Node head = new Node(null);
    private int size = 0;

    private static class Node {
        Object object;
        Node prev = this, next = this;

        Node(Object object) {
            this.object = object;
        }

        Node(Object object, Node prev, Node next) {
            this.object = object;
            this.prev = prev;
            this.next = next;
        }
    }

    public int size() {
        return size;
    }    

    public void enqueue(Object obj) {
        head.prev.next = new Node(obj, head.prev, head);
        head.prev= head.prev.next;
        ++size;
    }

    public Object peek() {
        if (size == 0) {
            throw new IllegalStateException();
        }
        return head.next.object;
    }

    public Object dequeue() {
        if (size == 0) {
            throw new IllegalStateException();
        }
        Object temp = head.next.object;
        head.next = head.next.next;
        head.next.prev = head;
        --size;
        return temp;
    }

    public Object nthFromStart(int n) {
        if (size < n || n <= 0) {
            throw new IllegalStateException();
        }
        Node p = head;
        for (int i = 0; i < n; i++) {
            p = p.next;
        }
        return p.object;
    }

    public Object nthFromEnd(int n) {
        if (size < n || n <= 0) {
            throw new IllegalStateException();
        }
        Node p = head;
        for (int i = 0; i < n; i++) {
            p = p.prev;
        }
        return p.object;
    }

    public void reverse() {
        if (head.next == head || head.next == head.prev) {
            return; 
        }
    
        Node current = head.next, first = head.next;
        do {
            Node temp = current.next;
            current.next = current.prev;
            current.prev = temp;
            current = current.prev;
        } while (current != first); 
    }
    

    public Object[] toArray() {
        Object[] arr = new Object[size];
        Node p = head.next;
        for (int i = 0; i < size; i++) {
            arr[i] = p.object;
            p = p.next;
        }
        return arr;
    }

    public LinkedQueue copy() {
        LinkedQueue copy = new LinkedQueue();
        Node p = this.head.next;
        for (int i = 0; i < size; i++) {
            copy.enqueue(p.object);
            p = p.next;
        }
        return copy;
    }

    public boolean compare(LinkedQueue queue) {
        if (this.size != queue.size) {
            return false;
        }
        Node p = this.head.next, q = queue.head.next;
        for (int i = 0; i < size; i++) {
            if(p.object == null){
                if(q.object != null){
                    return false;
                }
            }
            else if (!(p.object.equals(q.object))) {
                return false;
            }
            p = p.next;
            q = q.next;
        }
        return true;
    }

    public void printOddElements() {
        Node p = head.next;
        for (int i = 1; i <= size; i+=2) {
            System.out.println(p.object);
            p=p.next.next;
        }
    }

    public void printEvenElements() {
        Node p = head.next.next;
        for (int i = 2; i <= size; i+=2) {
            System.out.println(p.object);
            p=p.next.next;
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("Queue: ");
        Node p = head.next;
        for (int i = 0; i < size; i++) {
            sb.append(p.object).append(" ");
            p = p.next;
        }
        return sb.toString();
    }
    public static void main(String[] args) {
        LinkedQueue q = new LinkedQueue();
        q.enqueue("A");
        q.enqueue("B");
        q.enqueue("C");

        System.out.println(q.dequeue()); // A
        System.out.println(q.peek());    // B
        System.out.println(q);
    }
}
