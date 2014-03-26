package codeforces;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Aashish
 */
/**
 * This program is a basic demo for IPC.
 * here in this program strict message alteration is required.
 * both the programs are identical except for the connection setting.
 *
 * this process work as server process.
 *
 */

import java.net.*;
import java.io.*;


public class process1 {
    
    static ServerSocket ServerSocket = null;
    static Socket clientSocket = null;
    static String inputLine, outputLine="";
    static PrintWriter out[] = new PrintWriter[10];
    static BufferedReader in[] = new BufferedReader[10];
    //receiver re[] = new receiver[10];
    static int count=0;
    static String name[] = new String[10];
    static int flag=0;

    public static void main(String[] args) {

        

        try {
            //creating a server Socket
            ServerSocket = new ServerSocket(4444);
            //can use any port number which is greater then 1024
        } catch (IOException e) {
            System.out.println("Could not listen on port: 4444");
            System.exit(-1);
        }
        
        Acceptor ac = new Acceptor(ServerSocket);
        ac.start();

        try {
            //accepting a clients request// wait till a client connects
           // clientSocket = ServerSocket.accept();
            
//------------------connection Established----------------------


            
            String msg = "no message";
            while (true) {
                
                //flag=0;
                //reading from a client
               /* if(in.ready()){
                    inputLine = in.readLine();
                    msg = inputLine;
                    if (msg.equals("exit")) {
                        break;
                    }
                    System.out.println("echo:" + inputLine);
                }*/
                //System.out.println("Message:");
                
                for(int i=0;i<count;i++){
                    if(in[i].ready()){
                        msg = in[i].readLine();
                        System.out.println(i+" : "+msg);
                        for(int j=0;j<count;j++){
                            if(j!=i){
                                out[j].println(i+": "+ msg);
                            }
                        }
                    }
                }
                
                BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));

                if(stdIn.ready()){
                    outputLine = stdIn.readLine();
                    //outputLine = "Your message: " +outputLine ;
                    //sending message to a client
                    for(int i=0;i<count;i++){
                        out[i].println(outputLine);
                    }
                    if (outputLine.equals("exit")) {
                    //flag=1;
                    break;
                }
                }

                /*out = null;
                in = null;*/

           }
            //out.close();
            //in.close();

            //clientSocket.close();

            //ServerSocket.close();

        } catch (IOException e) {
            System.out.println("Accept failed: 4444");
            System.exit(-1);

        }
    }
    
    public void givethemsg(String message,int id){
        
        flag=1;
        System.out.println(id+": "+message);
        for(int i=0;i<count;i++){
            if(i!=id){
                out[i].println(id+": "+message);
            }
        }
    }
    
    public void dothejob(Socket cs) throws IOException{
                            
                //create an output stream
                out[count] = new PrintWriter(cs.getOutputStream(), true);
                //create an input stream
                in[count] = new BufferedReader(new InputStreamReader(cs.getInputStream()));
                
                //receiver re = new receiver(cs,in[count],count);
                //re.start();
                System.out.println("yahan aya" + count);
                out[count].println("What is your name buddy??");
                Acceptor ac = new Acceptor(ServerSocket);
                ac.start();
                //re[count] = re;
                
                count++;
        
        }
}