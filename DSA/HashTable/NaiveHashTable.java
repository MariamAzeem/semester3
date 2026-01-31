/*
 * Naive Hash Table Implementation
 * This implementation is for educational purposes only.
 * It demonstrates the basic concept of hashing.
 * It does NOT handle collisions properly and is not suitable
 * for real-world usage.
 */

public class NaiveHashTable{ 
    private Entry[] entries = new Entry[11];
    private int size;
    private class Entry{
        Object key, value;
        Entry(Object key, Object value){
            this.key = key;
            this.value = value;
        }
    }
    private int hash(Object key){
        return(key.hashCode() & 0x7fffffff) % entries.length;
    }
    public Object get(Object key){
        return entries[hash(key)].value;
    }
    public void put(Object key, Object value){
        entries[hash(key)] = new Entry(key, value);
        ++size;
    }
    public Object remove(Object key){
        int h = hash(key);
        Object temp = entries[h].value;
        entries[h] = null;
        --size;
        return temp;
    }
    public int size(){
        return size;
    }
    public static void main(String[] args) {
        NaiveHashTable naive = new NaiveHashTable();
        naive.put("A", 1);
        naive.put("B", 2);
        System.out.println(naive.get("A"));
        System.out.println(naive.remove("A"));
    }
}