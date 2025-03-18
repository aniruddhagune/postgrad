/*
 * WAP to display all instance variable values  
 * without using dot operator or calling any explicit method.
 */

class Entity {
    String name;
    int someNumber;
    
    Entity(String name, int someNumber) {
        this.name = name;
        this.someNumber = someNumber;
    }

    public String toString() {
        System.out.println("There can be additional code here.");
        someNumber += 18;
        return ("I am an entity, named "+name+". I am entity number 2516"+someNumber+".");
    } 

}

public class Q4 {
    public static void main(String s[]) {
        Entity e1 = new Entity("Hela", 44);
        Entity e2 = new Entity("Kin", 666);
        
        System.out.println(e2);
        System.out.println("\n");
        System.out.println(e1);

    }
}
