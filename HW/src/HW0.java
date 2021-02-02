/**
 *
 * @author Henry Wilt CS274
 * @version 1.0, February 2021
 */
import java.io.*;
import java.util.*;

public class HW0 {
    //This will hold the data of the file, line by line
    public static ArrayList<String[]> FILE_DATA = new ArrayList<>();
    //This will hold the converted data
    public static ArrayList<String[]> CONVERTED_DATA = new ArrayList<>();
    
    
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
                String[] splits = data.split(",");
                if(isValidBase(splits[0], splits[2])){
                    FILE_DATA.add(splits);
                }
                else{
                    splits[2] = "improper input";
                    FILE_DATA.add(splits);
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
            for(int i = 0; i < FILE_DATA.size(); i++){
                String[] temp = FILE_DATA.get(i);
                for(int j = 0; j < temp.length; j++){
                    writer.write(temp[j] + ",");
                }
                writer.write("\n");
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
     * @param base the base for the value
     * @param value is a string of the value
     * @return boolean isValid this will be true if the input is proper 
     */
    public static boolean isValidBase(String base, String value){
        boolean isValid = true;
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
    
    /**
     * This mehod will allow us to convert base binary, hexadecimal, and decimal 
     * into each other easily. 
     * 
     * TODO: FINISH THE METHOD AND CONVERSION
     * 
     * @param base starting base of the value
     * @param convertBase the base we want to convert the value to
     * @param value the value in form of a string
     */
    public static void convertValue(String base, String convertBase, String value){
        String[] convert = {convertBase, ""};
        if(value.equalsIgnoreCase("improper input")){ //if value was not improper
            convert[1] = "improper input";
            CONVERTED_DATA.add(convert); //adding the value and its base to the converted array
        }
        else{
            switch(convertBase){
                case "B": //Binary
                    convert[1] = convertBinary(base,value);
                    break;
                case "H": //Hexadecimal
                    convert[1] = convertHex(base,value);
                    break;
                case "D": //Decimal
                    convert[1] = convertDecimal(base,value);
                    break;
            }
            CONVERTED_DATA.add(convert); //adding the value and its base to the converted array
        }
    }
    
    public static String convertBinary(String base, String value){
        String convertedValue = "";
        if(base.equals("H")){
            
        }
        else if(base.equals("D")){
            
        }
        return convertedValue;
    }
    
    public static String convertHex(String base, String value){
        String convertedValue = "";
        if(base.equals("B")){
            
        }
        else if(base.equals("D")){
            
        }
        return convertedValue;
    }
    
    public static String convertDecimal(String base, String value){
        String convertedValue = "";
        if(base.equals("H")){
            
        }
        else if(base.equals("B")){
            
        }
        return convertedValue;
    }
    
    public static void main(String[] args){
        readFile();
        for(int i = 0; i < FILE_DATA.size(); i++){
            String[] temp = FILE_DATA.get(i);
            convertValue(temp[0], temp[1], temp[2]);
        }
        writeFile();
    }
}
