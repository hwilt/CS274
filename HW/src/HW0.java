/**
 *
 * @author Henry Wilt CS274
 * @version 1.0, February 2021
 */
import java.io.*;
import java.util.*;

public class HW0 {
    //This will hold the data of the file, line by line
    public static ArrayList<String> FILE_DATA = new ArrayList<>(); 
    
    /**
     * This method will allow us to read the file "conversion_in.txt"
     * then put the data in the file line by line in an arrayList to
     * use more conveniently.
     */
    public static void readFile(){
        try{
            File file = new File("conversion_in.txt");
            Scanner reader = new Scanner(file);
            while(reader.hasNextLine()){
                String data = reader.nextLine();
                FILE_DATA.add(data);
            }
            reader.close();
        }catch (FileNotFoundException e) {
            System.out.println("File not Found");
            e.printStackTrace();
        }
    }
    
    public static void writeFile(){
        try {
            FileWriter writer = new FileWriter("conversion_out.txt");
            writer.write("Files in Java might be tricky, but it is fun enough!");
            writer.close();
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        } 
    }
    
    
    
    public static void main(String[] args){
        try {
            FileWriter writer = new FileWriter("conversion_out.txt");
            writer.write("Files in Java might be tricky, but it is fun enough!");
            writer.close();
            System.out.println("Successfully wrote to the file.");
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        } 
    }
}
