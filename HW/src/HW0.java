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
    //This will hold the converted data
    public static ArrayList<String> CONVERTED_DATA = new ArrayList<>();
    //This is the index of the second comma in the line data
    public static final int SECOND_COMMA = 3; 
    //This is the index of the first comma in the line data
    public static final int FIRST_COMA = 1; 
    
    
    /**
     * This method will allow us to read from file "conversion_in.txt"
     * then put the data in the file line by line in an arrayList to
     * use more conveniently.
     */
    public static void readFile(){
        try{
            File file = new File("conversion_in.txt");
            Scanner reader = new Scanner(file);
            while(reader.hasNextLine()){
                String data = reader.nextLine();
                if(isValidBase(data)){
                    FILE_DATA.add(data);
                }
                else{
                    String[] splits = data.split(",");
                    data = splits[0] + "," + splits[1] + ",improper input";
                    FILE_DATA.add(data);
                }
            }
            reader.close();
        }catch (FileNotFoundException e) {
            System.out.println("File not Found");
            e.printStackTrace();
        }
    }
    
    /**
     * This method will allow us to write into file "conversion_out.txt"
     * 
     * TODO: PRINT OUT THE VALUES CONVERTED INTO A TABLE
     */
    public static void writeFile(){
        try {
            FileWriter writer = new FileWriter("conversion_out.txt");
            writer.write("Converter Results\n");
            for(String i : FILE_DATA){
                writer.write(i + "\n");
            }
            writer.close();
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        } 
    }
    
    /**
     * This method checks if the line data has an improper input like for
     * b, h, "298" B = binary which in the input "298" would not be proper
     * so return false.
     * 
     * @param data the line data to check if the input is improper
     * @return boolean isValid this will be true if the input is proper 
     */
    public static boolean isValidBase(String data){
        boolean isValid = true;
        String base = data.substring(0, FIRST_COMA);
        String value = data.substring(SECOND_COMMA + 1);
        switch(base){ //checking each case Binary, Hexadecimal, and Decimal
            case "B": //Binary
                for(int i = 0; i < value.length(); i++){
                    int temp = value.charAt(i);
                    if(temp != '0' && temp != '1'){
                        return false;
                    }
                }
                break;
            case "H": //Hexadecimal
                for(int i = 0; i < value.length(); i++){
                    int temp = value.charAt(i);
                    boolean isTrue = temp != '0' && temp != '1' && temp != '2' && 
                            temp != '3' && temp != '4' && temp != '5' &&
                            temp != '6' && temp != '7' && temp != '8' && temp != '9' 
                            && temp != 'A' && temp != 'B' && temp != 'C' && temp != 'D'
                            && temp != 'E' && temp != 'F';
                    if(isTrue){ //if any of those numbers are found then it will be an improper input
                        return false;
                    }
                }
                break;
            case "D": //Decimal
                for(int i = 0; i < value.length(); i++){
                    int temp = value.charAt(i);
                    boolean isTrue = temp != '0' && temp != '1' && temp != '2' && 
                            temp != '3' && temp != '4' && temp != '5' &&
                            temp != '6' && temp != '7' && temp != '8' && temp != '9';
                    if(isTrue){ //if any of those numbers are found then it will be an improper input
                        return false;
                    }
                }
                break;
        }
        return isValid;
    }
    
    public static void convertValue(String data){
        
    }
    
    public static void main(String[] args){
        readFile();
        for(String i: FILE_DATA){
            System.out.println(i);
        }
        writeFile();
    }
}
