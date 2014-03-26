/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package codeforces;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Aashish
 */
public class Acceptor extends Thread{
    
    ServerSocket sersoc= null;
    Socket cs;
    process1 pr1= new process1();
    
    public Acceptor(ServerSocket ss){
        sersoc = ss;
    }
    
    public void run(){
        try {
            cs = sersoc.accept();
            pr1.dothejob(cs);
            
        } catch (IOException ex) {
            Logger.getLogger(Acceptor.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.getMessage());
        }
    }
}
