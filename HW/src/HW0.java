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
                String[] splits = data.split(","); //splits the tokens
                if(isValidBase(splits[0], splits[2])){
                    FILE_DATA.add(splits); //adds the tokens to an arraylist of string arrays
                }
                else{
                    splits[2] = "improper input"; //changes the input to improper so it does not go through the converter and break it
                    FILE_DATA.add(splits); //adds the tokens to an arraylist of string arrays
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
     */
    public static void writeFile(){
        try {
            FileWriter writer = new FileWriter("conversion_out.txt");
            writer.write("Converter Results\n");
            for(int i = 0; i < FILE_DATA.size(); i++){ //both data arraylists are the same size
                String[] temp = FILE_DATA.get(i);
                String[] convertedTemp = CONVERTED_DATA.get(i);
                writer.write(temp[2] + " " + temp[0] + " = " + convertedTemp[1] + " " + convertedTemp[0]);
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
     * This method will allow us to convert base binary, hexadecimal, and decimal 
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
            convert[1] = "improper output";
            CONVERTED_DATA.add(convert); //adding the value and its base to the converted array
        }
        else{
            switch(convertBase){
                case "B": //Binary
                    convert[1] = convertToBinary(base,value);
                    break;
                case "H": //Hexadecimal
                    convert[1] = convertToHex(base,value);
                    break;
                case "D": //Decimal
                    convert[1] = convertToDecimal(base,value);
                    break;
            }
            CONVERTED_DATA.add(convert); //adding the value and its base to the converted array
        }
    }
    
    /**
     * This method converts Decimal or Hexadecimal to Binary
     * 
     * @param base the starting base you are trying to convert from.
     * @param value the starting value you convert from.
     * @return String which contains the convertedValue 
     */
    public static String convertToBinary(String base, String value){
        String convertedValue = "";
        if(base.equals("H")){
            value = convertToDecimal(base, value); //First convert to decimal
            String[] digits = {"0","1"};
            int val = Integer.parseInt(value); //Change the string to an int
            String temp = "";
            while(val != 0){ //goes until the int value is zero
                temp = digits[val % 2]; // chooses either a 0 or 1 with moldus
                val = val / 2; //then divides it out
                convertedValue = temp + convertedValue; //adds the binary value to the convertedValue
            }
        }
        else if(base.equals("D")){
            String[] digits = {"0","1"};
            int val = Integer.parseInt(value); //Change the string to an int
            String temp = "";
            while(val != 0){ //goes until the int value is zero
                temp = digits[val % 2]; // chooses either a 0 or 1 with moldus
                val = val / 2; //then divides it out
                convertedValue = temp + convertedValue; //adds the binary value to the convertedValue in the right order
            }
        }
        return convertedValue;
    }
    
    /**
     * This method converts Decimal or Binary to Hexadecimal
     * 
     * @param base the starting base you are trying to convert from.
     * @param value the starting value you convert from.
     * @return String which contains the convertedValue 
     */
    public static String convertToHex(String base, String value){
        String convertedValue = "";
        if(base.equals("D")){
            String[] digits = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"};
            int val = Integer.parseInt(value); //changes the  string to an int
            String temp = "";
            while(val != 0){ // goes until int value is zero
                temp = digits[val % 16]; // choose the correct hex value 
                val = val / 16; //divides out that current value
                convertedValue = temp + convertedValue; //adds the hex value to the convertedValue in the right order
            }
        }
        else if(base.equals("B")){
            if(value.length() % 4 != 0){ // checks if the value is divisable by 4 so it can change the binary to hex
                switch(value.length() % 4){ // goes to how many binary values are moldus of 4
                    case 1: //missing 3 binary zeroes
                        value = "000" + value; // adding 3 zeroes to the start of the binary value
                        break;
                    case 2: //missing 2 binary zeroes
                        value = "00" + value; // adding 3 zeroes to the start of the binary value
                        break;
                    case 3: //missing 1 binary zeroes
                        value = "0" + value; // adding 3 zeroes to the start of the binary value
                        break;
                }
            }
            int startingDigit = 1; // "starting" more like the start of the first set of 4 binary values
            int sum = 0; 
            for(int i = 0; i < value.length(); i++){
                if(startingDigit == 1){
                    sum += Integer.parseInt(value.charAt(i) + "") * 8; // the first digit checked "1000" so the one is
                }
                else if(startingDigit == 2){
                    sum += Integer.parseInt(value.charAt(i) + "") * 4; // the first digit checked "0100" so the one is
                }
                else if(startingDigit == 3){
                    sum += Integer.parseInt(value.charAt(i) + "") * 2; // the first digit checked "0010" so the one is
                }
                else if(startingDigit == 4){
                    sum += Integer.parseInt(value.charAt(i) + "") * 1; // the first digit checked "0001" so the one is
                    startingDigit = 1; //changes the starting digit back to 1
                    if(sum < 10){ 
                        convertedValue += "" + sum; //just puts the characters 0-9
                    }
                    else if(sum == 10){
                        convertedValue += "A"; //adds the character "A"
                    }
                    else if(sum == 11){
                        convertedValue += "B"; //adds the character "B"
                    }
                    else if(sum == 12){
                        convertedValue += "C"; //adds the character "C"
                    }
                    else if(sum == 13){
                        convertedValue += "D"; //adds the character "D"
                    }
                    else if(sum == 14){
                        convertedValue += "E"; //adds the character "E"
                    }
                    else if(sum == 15){
                        convertedValue += "F"; //adds the character "F"
                    }
                    sum = 0; //sets the sum back to zero
                }
                startingDigit++; //adds 1 so you dont mess up the count
            }
            
        }
        return convertedValue;
    }
    
    /**
     * This method converts Hexadecimal and Binary to Decimal
     * 
     * @param base the starting base you are converting from
     * @param value the starting value you want to convert
     * @return String which contains the convertedValue
     */
    public static String convertToDecimal(String base, String value){
        String convertedValue = "";
        if(base.equals("H")){
            String digits = "0123456789ABCDEF"; // the values of hex
            int val = 0;
            for(int i = 0; i < value.length(); i++){
                // gets the current character in the hex value then finds the index in the string which is 0-15 corrsonding to the hex values
                int temp = digits.indexOf(value.charAt(i)); 
                val = 16*val + temp; //mulitplys the val at the moment by 16 + temp
            }
            convertedValue += val;
        }
        else if(base.equals("B")){
            int exp = 1;
            int val = 0;
            for(int i = value.length() - 1; i >= 0; i--){
                if(value.charAt(i) == '1'){ // checks if the character is a 1 
                    val += exp;//adds the exp value to value
                }
                exp *= 2; // times the current exponent by 2 (1,2,4,8,16, ...)
            }
            convertedValue += val;
        }
        return convertedValue;
    }
    
    public static void main(String[] args){
        readFile(); //gets the data from the file
        for(int i = 0; i < FILE_DATA.size(); i++){
            String[] temp = FILE_DATA.get(i);
            convertValue(temp[0], temp[1], temp[2]); //converts each value
        }
        writeFile(); //writes the data to the file
    }
}
