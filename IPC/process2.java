/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package codechef;

/**
 *
 * @author Aashish
 */
/**
 * This program is a basic demo for IPC
 * here in this program strict message alteration is required.
 * both the programs are identical except for the connection setting.
 * 
 * this process work as client process.
 *
 */
import os_pack1.*;
import java.net.*;
import java.io.*;

public class process2 {

    public static void main(String[] args) {
        Socket Socket = null;
        PrintWriter out = null;
        BufferedReader in = null;

        try {
            //create a client Socket
            Socket = new Socket("localhost", 4444);
            //-------connection established---------

        } catch (UnknownHostException e) {
            System.err.println("Don't know about host: localhost.");
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Couldn't get I/O for " + "the connection to: localhost.");
            System.exit(1);
        }
        try {
            String msg = "no message";
            BufferedReader stdIn = null;
           
            while (true) {
                //create an output stream
                out = new PrintWriter(Socket.getOutputStream(), true);
                //create an input stream
                in = new BufferedReader(new InputStreamReader(Socket.getInputStream()));
                //System.out.println("Message:");
                stdIn = new BufferedReader(new InputStreamReader(System.in));
                String userInput="";

                if(stdIn.ready()){
                    userInput = stdIn.readLine();
                    //userInput = "Your message: "+ userInput;

                    //sending message to the server
                    out.println(userInput);
                }
                if (userInput.equals("exit") || msg.equals("exit")) {
                    break;
                }

                //receiving message from the server and printing
                if(in.ready()){
                    msg = in.readLine();

                    System.out.println("echo: " + msg);
                }
                out = null;
                in = null;

            }
            out.close();
            in.close();

            stdIn.close();
            Socket.close();
        } catch (Exception e) {
        }

    }
}