package com.wifi.test.wifi_test;

import android.os.Handler;
import android.os.Message;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.TextView;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;

public class MainActivity extends AppCompatActivity {


    final String TAG = "tianyx";

    Socket socket;
    Handler myHandler;
    OutputStream outputStream;
    Button conn, send;
    TextView showtx;
    EditText sendet;
    CheckBox ledcb;
    boolean isThread_Run = false;
    Thread myThread;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        conn = (Button) findViewById(R.id.connect);
        send = (Button) findViewById(R.id.send);

        showtx = (TextView) findViewById(R.id.textView);
        sendet = (EditText) findViewById(R.id.editText);
        ledcb = (CheckBox) findViewById(R.id.led);

        conn.setOnClickListener(new BtnOnClickListener());
        send.setOnClickListener(new BtnOnClickListener());

        myHandler = new Myhandler();

        ledcb.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                outputStream.write("led_on".getBytes());
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    }).start();

                }else{
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                outputStream.write("led_off".getBytes());
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    }).start();
                }
            }
        });
    }

    public class  Myhandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what){
                case  0:
                    showtx.append((CharSequence) msg.obj);
                    break;
                case 1:
                    break;
            }

            super.handleMessage(msg);
        }
    }

    public class MyRunnable implements Runnable {

        @Override
        public void run() {
            // TODO Auto-generated method stub

            try {// 创建一个Socket对象，并指定服务端的IP及端口号
                Log.d(TAG, "going to new socket");
                socket = new Socket("192.168.4.1", 8080);
                // 创建一个InputStream用户读取要发送的文件。
                //InputStream inputStream = new FileInputStream("e://a.txt");
                if (socket == null) {
                    Log.d(TAG, "new socket fail");
                    return ;
                }

                InputStream inputStream = socket.getInputStream();
                // 获取Socket的OutputStream对象用于发送数据。
                outputStream = socket.getOutputStream();
                // 创建一个byte类型的buffer字节数组，用于存放读取的本地文件
                byte buffer[] = new byte[64];
                int temp = 0;
                // 循环读取文件
                Log.d(TAG, "run");

                while ((temp = inputStream.read(buffer)) != -1) {
                    Message msg = new Message();
                    msg.what = 0;
                    Log.d(TAG, new String(buffer, 0, temp));   //new String(buffer,"UTF-8"));
                    msg.obj = new String(buffer, 0, temp);
                    myHandler.sendMessage(msg);
                }
            } catch (UnknownHostException e) {
                Log.d(TAG, "UnknownHostException");
                e.printStackTrace();
            } catch (IOException e) {
                Log.d(TAG, "IOException");
                e.printStackTrace();
            }catch (Exception e){
                Log.d(TAG, "Exception");

            }
        }
    }



    public  class  BtnOnClickListener implements  View.OnClickListener {

        @Override
        public void onClick(View v) {
            switch (v.getId())
            {
                case R.id.connect:
                    if(conn.getText().toString().equals("connect")) {
                        conn.setText("disconnect");
                        isThread_Run = true;
                        myThread = new Thread(new MyRunnable());
                        myThread.start();
                        showtx.setText("");
                    }
                    else {
                        conn.setText("connect");
                        isThread_Run = false;
                        try {
                            socket.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        myThread = null;
                    }
                    break;
                case R.id.send:
                    String str = sendet.getText().toString();
                    try {
                        outputStream.write(str.getBytes());
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    break;
            }
        }
    }
}
