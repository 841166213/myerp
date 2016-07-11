/**
 * 
 */
package com.common.util.mail;

/**
 * @author 陈家桂
 *
 */
public class Test {

	public static void main(String[] args){
        //这个类主要是设置邮件
	  MailSenderInfo mailInfo = new MailSenderInfo(); 
	  mailInfo.setMailServerHost("smtp.139.com"); 
	  mailInfo.setValidate(true); 
	  mailInfo.setUserName("13926798906@139.com"); 
	  mailInfo.setPassword("pp0099oo");//您的邮箱密码 
	  mailInfo.setFromAddress("13926798906@139.com"); 
	  mailInfo.setToAddress("13926798906@139.com"); 
	  mailInfo.setSubject("设置邮箱标题"); 
	  mailInfo.setContent("设置邮箱内容"); 
        //这个类主要来发送邮件
	  SimpleMailSender sms = new SimpleMailSender();
         sms.sendTextMail(mailInfo);//发送文体格式 
         //sms.sendHtmlMail(mailInfo);//发送html格式
	}


}

