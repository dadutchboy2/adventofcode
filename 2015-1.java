public class Main {
    public static void main(String[] args) {
        int floor = 0;
        int i = 0;
        String instructionString = "insert input here";
        char[] instructions = instructionString.toCharArray();
        for (i = 1; i <= instructions.length; i++) {
            char instruction = instructions[i - 1];
            floor += instruction == '(' ? 1 : -1;
            if (floor == -1) {
                break;
            }
        }
        System.out.println(i);
    }
}
//i couldnt for the life of me figure out how to read a file, java sucks and ill avoid it for the rest of my life
