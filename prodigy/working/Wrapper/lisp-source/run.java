


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
// To run :
// 1> compile the java code using "javac run.java"
// 2> then run using "java run <String Hostname> <int PortNumber>"
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

class Run{

    public static void main(String args[]){

        try{

        toKQML KQMLobject = new toKQML(args[0], Integer.parseInt(args[1]));

        System.out.println("Got Connected");

        System.in.read();

        KQMLobject.OpenParen();
        KQMLobject.Achieve();
        KQMLobject.Sender("AGENT-A");
        KQMLobject.Content("((on-top A B))");
        KQMLobject.CloseParen();
        KQMLobject.Newline();

        System.out.println("Sent String");
        System.out.println(KQMLobject.Read());

        System.in.read();
        KQMLobject.Quit();

        } catch (Exception e){
            System.out.println("Error");
            e.printStackTrace();
        }
    }
}
