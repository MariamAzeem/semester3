public class ArrayQueue {
    private Object[] data;
    private int front;    
    private int rear;    
    private int size;
    private int capacity;

    public ArrayQueue(int capacity) {
        this.capacity = capacity;
        data = new Object[capacity];
        front = 0;
        rear = 0;
        size = 0;
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public boolean isFull() {
        return size == capacity;
    }

    public void enqueue(Object item) {
        if (isFull()) {
            throw new IllegalStateException("Queue is full");
        }
        data[rear] = item;
        rear = (rear + 1) % capacity;
        size++;
    }

    public Object dequeue() {
        if (isEmpty()) {
            throw new IllegalStateException("Queue is empty");
        }
        Object item = data[front];
        data[front] = null; // Optional: help garbage collector
        front = (front + 1) % capacity;
        size--;
        return item;
    }

    public Object peek() {
        if (isEmpty()) {
            throw new IllegalStateException("Queue is empty");
        }
        return data[front];
    }

    public int size() {
        return size;
    }

    public static void main(String[] args) {
        ArrayQueue q = new ArrayQueue(5);

        q.enqueue(10);
        q.enqueue(20);
        q.enqueue(30);

        System.out.println(q.dequeue()); // 10
        System.out.println(q.peek());    // 20
        System.out.println(q.size());    // 2
    }
}

